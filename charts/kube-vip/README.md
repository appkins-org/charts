# kube-vip

![Version: 0.4.5](https://img.shields.io/badge/Version-0.4.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.4.1](https://img.shields.io/badge/AppVersion-v0.4.1-informational?style=flat-square)

A Helm chart for kube-vip

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| kube-vip |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| config.address | string | `""` |  |
| env.cp_enable | string | `"false"` |  |
| env.lb_enable | string | `"true"` |  |
| env.lb_port | string | `"6443"` |  |
| env.svc_election | string | `"false"` |  |
| env.svc_enable | string | `"true"` |  |
| env.vip_arp | string | `"true"` |  |
| env.vip_cidr | string | `"32"` |  |
| env.vip_interface | string | `""` |  |
| env.vip_leaderelection | string | `"false"` |  |
| envFrom | list | `[]` |  |
| envValueFrom | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| hostAliases[0].hostnames[0] | string | `"kubernetes"` |  |
| hostAliases[0].ip | string | `"127.0.0.1"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/kube-vip/kube-vip"` |  |
| image.tag | string | `"v0.5.11"` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| resources | object | `{}` |  |
| securityContext.capabilities.add[0] | string | `"NET_ADMIN"` |  |
| securityContext.capabilities.add[1] | string | `"NET_RAW"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations[0].effect | string | `"NoSchedule"` |  |
| tolerations[0].key | string | `"node-role.kubernetes.io/control-plane"` |  |
| tolerations[0].operator | string | `"Exists"` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |

