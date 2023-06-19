#!/bin/bash


helm_customize_values() {
	local loadbalancer_ip=$1
	local helm_chart_version=$2

	helm inspect values oci://ghcr.io/tinkerbell/charts/stack --version "$helm_chart_version" >/tmp/stack-values.yaml
	sed -i "s/192.168.2.111/${loadbalancer_ip}/g" /tmp/stack-values.yaml
}

helm_install_tink_stack() {
	local namespace=$1
	local version=$2
	local interface=$3

	trusted_proxies=$(kubectl get nodes -o jsonpath='{.items[*].spec.podCIDR}' | tr ' ' ',')
	helm install stack-release oci://ghcr.io/tinkerbell/charts/stack --version "$version" --create-namespace --namespace "$namespace" --wait --set "boots.boots.trustedProxies=${trusted_proxies}" --set "hegel.hegel.trustedProxies=${trusted_proxies}" --set "kubevip.interface=$interface" --values /tmp/stack-values.yaml
}

apply_manifests() {
	local worker_ip=$1
	local worker_mac=$2
	local manifests_dir=$3
	local host_ip=$4
	local namespace=$5

	disk_device="/dev/sda"
	if lsblk | grep -q vda; then
		disk_device="/dev/vda"
	fi
	export DISK_DEVICE="$disk_device"
	export TINKERBELL_CLIENT_IP="$worker_ip"
	export TINKERBELL_CLIENT_MAC="$worker_mac"
	export TINKERBELL_HOST_IP="$host_ip"

	for i in "$manifests_dir"/{hardware.yaml,template.yaml,workflow.yaml}; do
		envsubst <"$i"
		echo -e '---'
	done >/tmp/manifests.yaml
	kubectl apply -n "$namespace" -f /tmp/manifests.yaml
	kubectl apply -n "$namespace" -f "$manifests_dir"/ubuntu-download.yaml
}

run_helm() {
	local host_ip=$1
	local worker_ip=$2
	local worker_mac=$3
	local manifests_dir=$4
	local loadbalancer_ip=$5
	local helm_chart_version=$6
	local loadbalancer_interface=$7
	local namespace="tink-system"

	helm_customize_values "$loadbalancer_ip" "$helm_chart_version"
	helm_install_tink_stack "$namespace" "$helm_chart_version" "$loadbalancer_interface"
	apply_manifests "$worker_ip" "$worker_mac" "$manifests_dir" "$loadbalancer_ip" "$namespace"
}

main() {
	local host_ip=$1
	local worker_ip=$2
	local worker_mac=$3
	local manifests_dir=$4
	local loadbalancer_ip=$5
	local helm_chart_version=$6
	local loadbalancer_interface=$7

	run_helm "$host_ip" "$worker_ip" "$worker_mac" "$manifests_dir"/manifests "$loadbalancer_ip" "$helm_chart_version" "$loadbalancer_interface"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
	set -euxo pipefail

	main "$@"
	echo "all done!"
fi
