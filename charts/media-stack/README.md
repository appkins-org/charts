# media-stack

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://geek-cookbook.github.io/charts/ | prowlarr | ^4.5.2 |
| https://geek-cookbook.github.io/charts/ | radarr | ^16.3.2 |
| https://geek-cookbook.github.io/charts/ | sonarr | ^16.3.2 |
| https://geek-cookbook.github.io/charts/ | transmission | ^8.4.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"nginx"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| prowlarr.env.TZ | string | `"UTC"` |  |
| prowlarr.image.pullPolicy | string | `"IfNotPresent"` |  |
| prowlarr.image.repository | string | `"lscr.io/linuxserver/prowlarr"` |  |
| prowlarr.image.tag | string | `"latest"` |  |
| prowlarr.ingress.main.enabled | bool | `false` |  |
| prowlarr.persistence.config.enabled | bool | `false` |  |
| prowlarr.service.main.ports.http.port | int | `9696` |  |
| radarr.env | object | See below | environment variables. |
| radarr.env.TZ | string | `"UTC"` | Set the container timezone |
| radarr.image.pullPolicy | string | `"IfNotPresent"` |  |
| radarr.image.repository | string | `"lscr.io/linuxserver/radarr"` |  |
| radarr.image.tag | string | `"latest"` |  |
| radarr.ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| radarr.metrics.enabled | bool | See values.yaml | Enable and configure Exportarr sidecar and Prometheus serviceMonitor. |
| radarr.metrics.exporter.env.additionalMetrics | bool | `false` | Set to true to enable gathering of additional metrics (slow) |
| radarr.metrics.exporter.env.port | int | `9793` | metrics port |
| radarr.metrics.exporter.env.unknownQueueItems | bool | `false` | Set to true to enable gathering unknown queue items |
| radarr.metrics.exporter.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| radarr.metrics.exporter.image.repository | string | `"ghcr.io/onedr0p/exportarr"` | image repository |
| radarr.metrics.exporter.image.tag | string | `"v1.0.0"` | image tag |
| radarr.metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| radarr.metrics.prometheusRule.rules | list | See prometheusrules.yaml | Configure additionial rules for the chart under this key. |
| radarr.metrics.serviceMonitor.interval | string | `"3m"` |  |
| radarr.metrics.serviceMonitor.labels | object | `{}` |  |
| radarr.metrics.serviceMonitor.scrapeTimeout | string | `"1m"` |  |
| radarr.persistence | object | See values.yaml | Configure persistence settings for the chart under this key. # Config persistence is required for the Prometheus exporter sidecar. |
| radarr.probes | object | See values.yaml | Configures the probes for the main Pod. |
| radarr.service | object | See values.yaml | Configures service settings for the chart. |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| sonarr.env | object | See below | environment variables. |
| sonarr.env.TZ | string | `"UTC"` | Set the container timezone |
| sonarr.image.pullPolicy | string | `"IfNotPresent"` |  |
| sonarr.image.repository | string | `"lscr.io/linuxserver/sonarr"` |  |
| sonarr.image.tag | string | `"latest"` |  |
| sonarr.ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| sonarr.metrics.enabled | bool | See values.yaml | Enable and configure Exportarr sidecar and Prometheus serviceMonitor. |
| sonarr.metrics.exporter.env.additionalMetrics | bool | `false` | Set to true to enable gathering of additional metrics (slow) |
| sonarr.metrics.exporter.env.port | int | `9794` | metrics port |
| sonarr.metrics.exporter.env.unknownQueueItems | bool | `false` | Set to true to enable gathering unknown queue items |
| sonarr.metrics.exporter.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| sonarr.metrics.exporter.image.repository | string | `"ghcr.io/onedr0p/exportarr"` | image repository |
| sonarr.metrics.exporter.image.tag | string | `"v1.0.0"` | image tag |
| sonarr.metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| sonarr.metrics.prometheusRule.rules | list | See prometheusrules.yaml | Configure additionial rules for the chart under this key. |
| sonarr.metrics.serviceMonitor.interval | string | `"3m"` |  |
| sonarr.metrics.serviceMonitor.labels | object | `{}` |  |
| sonarr.metrics.serviceMonitor.scrapeTimeout | string | `"1m"` |  |
| sonarr.persistence | object | See values.yaml | Configure persistence settings for the chart under this key. # Config persistence is required for the Prometheus exporter sidecar. |
| sonarr.probes | object | See values.yaml | Configures the probes for the main Pod. |
| sonarr.service | object | See values.yaml | Configures service settings for the chart. |
| tolerations | list | `[]` |  |
| transmission.env.TRANSMISSION_DOWNLOAD_DIR | string | `"/downloads/complete"` | Torrent download directory |
| transmission.env.TRANSMISSION_INCOMPLETE_DIR | string | `"/downloads/incomplete"` | Incomplete download directory |
| transmission.env.TRANSMISSION_INCOMPLETE_DIR_ENABLED | bool | `false` | Enable incomplete download directory |
| transmission.env.TRANSMISSION_RPC_PASSWORD | string | `"CHANGEME"` | Password to access the Web UI |
| transmission.env.TRANSMISSION_WATCH_DIR | string | `"/watch"` | Watch directory |
| transmission.env.TRANSMISSION_WATCH_DIR_ENABLED | bool | `false` | Enable watch directory |
| transmission.env.TRANSMISSION_WEB_HOME | string | `"/config/flood-for-transmission/"` | Path in container where the Web UI is located |
| transmission.env.TZ | string | `"UTC"` | Set the container timezone |
| transmission.fullname | string | `"transmission"` |  |
| transmission.image.pullPolicy | string | `"IfNotPresent"` |  |
| transmission.image.repository | string | `"lscr.io/linuxserver/transmission"` |  |
| transmission.image.tag | string | `"latest"` |  |
| transmission.ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| transmission.initContainers.custom-webui.command[0] | string | `"/bin/sh"` |  |
| transmission.initContainers.custom-webui.command[1] | string | `"-c"` |  |
| transmission.initContainers.custom-webui.command[2] | string | `"curl -o- -sL https://github.com/johman10/flood-for-transmission/releases/download/latest/flood-for-transmission.tar.gz | tar xzf - -C /config"` |  |
| transmission.initContainers.custom-webui.image | string | `"curlimages/curl:latest"` |  |
| transmission.initContainers.custom-webui.name | string | `"custom-webui"` |  |
| transmission.initContainers.custom-webui.securityContext.runAsGroup | int | `568` |  |
| transmission.initContainers.custom-webui.securityContext.runAsUser | int | `568` |  |
| transmission.initContainers.custom-webui.volumeMounts[0].mountPath | string | `"/config"` |  |
| transmission.initContainers.custom-webui.volumeMounts[0].name | string | `"config"` |  |
| transmission.persistence.config.enabled | bool | `false` |  |
| transmission.persistence.config.mountPath | string | `"/config"` |  |
| transmission.persistence.downloads.enabled | bool | `false` |  |
| transmission.persistence.downloads.mountPath | string | `"/downloads"` |  |
| transmission.persistence.watch.enabled | bool | `false` |  |
| transmission.persistence.watch.mountPath | string | `"/watch"` |  |

