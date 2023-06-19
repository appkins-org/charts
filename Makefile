#charts/%: pkg/%.zip
#	helm package -d $@ $<

KUBECONFIG := $(shell pwd)/.data/kubeconfig

CHARTS := $(patsubst charts/%/,%,$(dir $(wildcard charts/*/Chart.yaml)))

${CHARTS}:

dep/update: ${CHARTS}
	helm dependency update charts/$<

dep/build: ${CHARTS}
	helm dependency build charts/$<

dep: ${CHARTS}
	helm dependency update charts/$<

lint: ${CHARTS}
	helm lint charts/$<

template: ${CHARTS}
	helm template $< charts/$< -n kube-system | tee $(patsubst %,.data/%.yaml,$<)

deploy: ${CHARTS}
	helm upgrade --install \
							 -n kube-system \
							 --kubeconfig ${KUBECONFIG} \
							 $< charts/$<
