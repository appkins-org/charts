# argocd-stack

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 5.22.1](https://img.shields.io/badge/AppVersion-5.22.1-informational?style=flat-square)

Helm chart for fully configuring argocd.

**Homepage:** <https://argo-cd.readthedocs.io/en/stable/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| appkins | <nbatkins@gmail.com> | <https://github.com/appkins> |

## Installing the Chart

To install the chart using the recommended OCI method you can use the following command.

```shell
helm upgrade --install argocd-stack oci://ghcr.io/appkins/charts/argocd-stack --version 0.0.1
```

Alternativly you can use the legacy non-OCI method via the following commands.

```shell
helm repo add appkins https://appkins.github.io/helm-charts/
helm upgrade --install argocd-stack appkins/argocd-stack --version 0.0.1
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.containeroo.ch | local-path-provisioner | ^0.0.24 |
| https://charts.jetstack.io | cert-manager | ^1.12.1 |
| https://charts.min.io | minio | ^4.0.12 |
| https://fluent.github.io/helm-charts | fluent-bit | ^0.30.4 |
| https://grafana.github.io/helm-charts | loki | ^2.15.2 |
| https://grafana.github.io/helm-charts | mimir-distributed | ^4.5.0-weekly.241 |
| https://grafana.github.io/helm-charts | tempo | ^1.3.1 |
| https://helm.cilium.io | cilium | ^1.14.0-snapshot.3 |
| https://kubernetes-sigs.github.io/metrics-server | metrics-server | ^3.10.0 |
| https://metallb.github.io/metallb | metallb | ^0.13.10 |
| https://prometheus-community.github.io/helm-charts | kube-prometheus-stack | ^46.8.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| IPPools[0].cidrs[0] | string | `"192.168.1.98/32"` |  |
| IPPools[0].cidrs[1] | string | `"192.168.1.99/32"` |  |
| IPPools[0].matchLabels."io.kubernetes.service.namespace" | string | `"kube-system"` |  |
| IPPools[0].name | string | `"system-pool"` |  |
| cert-manager.fullnameOverride | string | `"cert-manager"` |  |
| cert-manager.installCRDs | bool | `false` |  |
| cert-manager.nameOverride | string | `"cert-manager"` |  |
| cert-manager.prometheus.serviceMonitor.enabled | bool | `false` |  |
| cert-manager.resources.requests.cpu | string | `"10m"` |  |
| cert-manager.resources.requests.memory | string | `"32Mi"` |  |
| cert-manager.webhook.serviceType | string | `"ClusterIP"` |  |
| cilium.bgp.announce.loadbalancerIP | bool | `true` |  |
| cilium.bgp.announce.podCIDR | bool | `true` |  |
| cilium.bgp.enabled | bool | `false` |  |
| cilium.bgpControlPlane.enabled | bool | `true` |  |
| cilium.bpf.lbExternalClusterIP | bool | `true` |  |
| cilium.bpf.masquerade | bool | `true` |  |
| cilium.cluster.id | int | `0` |  |
| cilium.cluster.name | string | `"kubernetes"` |  |
| cilium.clustermesh.config.enabled | bool | `false` |  |
| cilium.dashboards.enabled | bool | `true` |  |
| cilium.datasource.jsonData | string | `"{}"` |  |
| cilium.enabled | bool | `true` |  |
| cilium.encryption.nodeEncryption | bool | `false` |  |
| cilium.envoy.enabled | bool | `true` |  |
| cilium.envoy.prometheus.enabled | bool | `true` |  |
| cilium.envoy.prometheus.serviceMonitor.enabled | bool | `false` |  |
| cilium.externalIPs.enabled | bool | `true` |  |
| cilium.fullnameOverride | string | `"cilium"` |  |
| cilium.hostPort.enabled | bool | `true` |  |
| cilium.hostServices.enabled | bool | `true` |  |
| cilium.hubble.enabled | bool | `true` |  |
| cilium.hubble.metrics.enabled | bool | `false` |  |
| cilium.hubble.relay.enabled | bool | `true` |  |
| cilium.hubble.relay.replicas | int | `1` |  |
| cilium.hubble.ui.enabled | bool | `true` |  |
| cilium.ingressController.default | bool | `true` |  |
| cilium.ingressController.enabled | bool | `true` |  |
| cilium.ingressController.loadbalancerMode | string | `"shared"` |  |
| cilium.ingressController.service.annotations."io.cilium/lb-ipam-ips" | string | `"72.216.61.243,192.168.1.99,1192.168.1.98"` |  |
| cilium.ingressController.service.loadBalancerClass | string | `"cilium"` |  |
| cilium.ingressController.service.loadBalancerIP | string | `"192.168.1.99"` |  |
| cilium.ingressController.service.type | string | `"LoadBalancer"` |  |
| cilium.ipam.mode | string | `"kubernetes"` |  |
| cilium.isDefault | bool | `false` |  |
| cilium.k8sServiceHost | string | `"192.168.1.198"` |  |
| cilium.k8sServicePort | int | `6443` |  |
| cilium.kubeProxyReplacement | string | `"strict"` |  |
| cilium.loadBalancer.l7.backend | string | `"envoy"` |  |
| cilium.nameOverride | string | `"cilium"` |  |
| cilium.nodePort.enabled | bool | `true` |  |
| cilium.nodeinit.automount | bool | `true` |  |
| cilium.nodeinit.enabled | bool | `true` |  |
| cilium.operator.prometheus.enabled | bool | `true` |  |
| cilium.operator.replicas | int | `1` |  |
| cilium.priorityClassName | string | `"system-node-critical"` |  |
| cilium.prometheus.enabled | bool | `true` |  |
| cilium.tunnel | string | `"vxlan"` |  |
| cilium.url | string | `"http://{{ include \"prometheus.fullname\" .}}:{{ .Values.prometheus.server.service.servicePort }}{{ .Values.prometheus.server.prefixURL }}"` |  |
| features.bgp | bool | `false` |  |
| features.nodeEncryption | bool | `false` |  |
| fluent-bit.config.filters | string | `"[FILTER]\n  Name kubernetes\n  Match kube.*\n  Merge_Log On\n  Keep_Log Off\n  K8S-Logging.Parser On\n  K8S-Logging.Exclude On\n"` |  |
| fluent-bit.config.inputs | string | `"[INPUT]\n  Name              tail\n  Path              /var/log/containers/*.log\n  multiline.parser  docker, cri\n  Tag               kube.*\n  Mem_Buf_Limit     5MB\n  Skip_Long_Lines   On\n\n[INPUT]\n  Name           systemd\n  Tag            host.*\n  Systemd_Filter _SYSTEMD_UNIT=kubelet.service\n  Read_From_Tail On\n\n[INPUT]\n  name            node_exporter_metrics\n  tag             node_metrics\n  scrape_interval 2\n\n[INPUT]\n  Name                 event_type\n  Type                 traces\n"` |  |
| fluent-bit.config.outputs | string | `"[OUTPUT]\n  Name            prometheus_exporter\n  Match           node_metrics\n  Host            prometheus-prometheus.{{ include \"argocd-stack.domain\" .}}\n  port            9090\n  add_label       app fluent-bit\n\n[OUTPUT]\n  name                   loki\n  match                  *\n  Host                   loki.{{ include \"argocd-stack.domain\" .}}\n  labels                 job=fluentbit\n  auto_kubernetes_labels on\n\n[OUTPUT]\n  Name                 opentelemetry\n  Match                *\n  Host                 tempo.{{ include \"argocd-stack.domain\" .}}\n  Port                 3100\n  Metrics_uri          /api/v1/push\n  Logs_uri             /api/v1/push\n  Traces_uri           /api/v1/push\n  Log_response_payload True\n  Tls                  Off\n  Tls.verify           Off\n  # add user-defined labels\n  add_label            app fluent-bit\n  add_label            color blue\n"` |  |
| fluent-bit.config.service | string | `"[SERVICE]\n  Daemon Off\n  Flush {{ .Values.flush }}\n  Log_Level {{ .Values.logLevel }}\n  Parsers_File parsers.conf\n  Parsers_File custom_parsers.conf\n  HTTP_Server On\n  HTTP_Listen 0.0.0.0\n  HTTP_Port {{ .Values.metricsPort }}\n  Health_Check On\n"` |  |
| fluent-bit.dashboards.enabled | bool | `true` |  |
| fluent-bit.enabled | bool | `true` |  |
| fluent-bit.fullnameOverride | string | `"fluent-bit"` |  |
| fluent-bit.nameOverride | string | `"fluent-bit"` |  |
| fluent-bit.serviceMonitor.enabled | bool | `false` |  |
| fullnameOverride | string | `"argocd-stack"` |  |
| global.clusterDomain | string | `"cluster.local"` |  |
| global.dnsService | string | `"kube-dns"` | Definitions to set up nginx resolver |
| global.priorityClassName | string | `"system-cluster-critical"` |  |
| global.replicas | int | `1` |  |
| kube-prometheus-stack.alertmanager.enabled | bool | `false` |  |
| kube-prometheus-stack.extraManifests[0].apiVersion | string | `"v1"` |  |
| kube-prometheus-stack.extraManifests[0].kind | string | `"Namespace"` |  |
| kube-prometheus-stack.extraManifests[0].metadata.labels."app.kubernetes.io/instance" | string | `"cilium"` |  |
| kube-prometheus-stack.extraManifests[0].metadata.labels.app | string | `"kube-prometheus-stack"` |  |
| kube-prometheus-stack.extraManifests[0].metadata.name | string | `"monitoring"` |  |
| kube-prometheus-stack.fullnameOverride | string | `"prometheus"` |  |
| kube-prometheus-stack.grafana."grafana.ini"."auth.anonymous".enabled | bool | `true` |  |
| kube-prometheus-stack.grafana."grafana.ini"."auth.anonymous".org_name | string | `"Appkins Org."` |  |
| kube-prometheus-stack.grafana."grafana.ini"."auth.anonymous".org_role | string | `"Admin"` |  |
| kube-prometheus-stack.grafana."grafana.ini".auth.disable_login_form | bool | `true` |  |
| kube-prometheus-stack.grafana."grafana.ini".server.root_url | string | `"%(protocol)s://%(domain)s:%(http_port)s/grafana"` |  |
| kube-prometheus-stack.grafana."grafana.ini".server.serve_from_sub_path | bool | `true` |  |
| kube-prometheus-stack.grafana.adminPassword | string | `"admin"` |  |
| kube-prometheus-stack.grafana.dashboardProviders."dashboardproviders.yaml".apiVersion | int | `1` |  |
| kube-prometheus-stack.grafana.dashboardProviders."dashboardproviders.yaml".providers[0].disableDeletion | bool | `false` |  |
| kube-prometheus-stack.grafana.dashboardProviders."dashboardproviders.yaml".providers[0].editable | bool | `true` |  |
| kube-prometheus-stack.grafana.dashboardProviders."dashboardproviders.yaml".providers[0].folder | string | `""` |  |
| kube-prometheus-stack.grafana.dashboardProviders."dashboardproviders.yaml".providers[0].name | string | `"default"` |  |
| kube-prometheus-stack.grafana.dashboardProviders."dashboardproviders.yaml".providers[0].options.path | string | `"/var/lib/grafana/dashboards/default"` |  |
| kube-prometheus-stack.grafana.dashboardProviders."dashboardproviders.yaml".providers[0].orgId | int | `1` |  |
| kube-prometheus-stack.grafana.dashboardProviders."dashboardproviders.yaml".providers[0].type | string | `"file"` |  |
| kube-prometheus-stack.grafana.dashboardsConfigMaps.default | string | `"grafana-dashboards"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".apiVersion | int | `1` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].editable | bool | `true` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].isDefault | bool | `true` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].name | string | `"Prometheus"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].type | string | `"prometheus"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].url | string | `"http://prometheus-server.kube-system.svc.cluster.local:9090"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[1].access | string | `"proxy"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[1].basicAuth | bool | `false` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[1].name | string | `"Tempo"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[1].type | string | `"tempo"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[1].uid | string | `"traces"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[1].url | string | `"http://tempo.kube-system.svc.cluster.local:3200"` |  |
| kube-prometheus-stack.grafana.enabled | bool | `false` |  |
| kube-prometheus-stack.grafana.fullnameOverride | string | `"grafana"` |  |
| kube-prometheus-stack.grafana.nameOverride | string | `"grafana"` |  |
| kube-prometheus-stack.grafana.namespaceOverride | string | `"monitoring"` |  |
| kube-prometheus-stack.grafana.resources.limits.memory | string | `"100Mi"` |  |
| kube-prometheus-stack.grafana.serviceMonitor.enabled | bool | `false` |  |
| kube-prometheus-stack.nameOverride | string | `"prometheus"` |  |
| kube-prometheus-stack.namespaceOverride | string | `"monitoring"` |  |
| kube-prometheus-stack.nodeExporter.enabled | bool | `false` |  |
| kube-prometheus-stack.prometheus-node-exporter.namespaceOverride | string | `"kube-system"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.enableFeatures[0] | string | `"exemplar-storage"` |  |
| kube-prometheus-stack.prometheusOperator.admissionWebhooks.certManager.enabled | bool | `true` |  |
| kube-prometheus-stack.prometheusOperator.admissionWebhooks.enabled | bool | `false` |  |
| kube-prometheus-stack.prometheusOperator.networkPolicy.enabled | bool | `false` |  |
| kube-prometheus-stack.prometheusOperator.networkPolicy.flavor | string | `"cilium"` |  |
| kube-prometheus-stack.thanosRuler.enabled | bool | `true` |  |
| local-path-provisioner.enabled | bool | `true` |  |
| local-path-provisioner.fullnameOverride | string | `"local-provisioner"` |  |
| local-path-provisioner.isDefault | bool | `false` |  |
| local-path-provisioner.nameOverride | string | `"local-provisioner"` |  |
| local-path-provisioner.nodePathMap[0].node | string | `"DEFAULT_PATH_FOR_NON_LISTED_NODES"` |  |
| local-path-provisioner.nodePathMap[0].paths[0] | string | `"/data/local-path-provisioner"` |  |
| local-path-provisioner.storageClass.create | bool | `true` |  |
| local-path-provisioner.storageClass.defaultClass | bool | `true` |  |
| local-path-provisioner.storageClass.name | string | `"local-path"` |  |
| local-path-provisioner.storageClass.reclaimPolicy | string | `"Delete"` |  |
| logLevel | string | `"info"` |  |
| loki.datasource.jsonData | string | `"{}"` |  |
| loki.datasource.uid | string | `""` |  |
| loki.enabled | bool | `true` |  |
| loki.fullnameOverride | string | `"loki"` |  |
| loki.isDefault | bool | `true` |  |
| loki.livenessProbe.httpGet.path | string | `"/ready"` |  |
| loki.livenessProbe.httpGet.port | string | `"http-metrics"` |  |
| loki.livenessProbe.initialDelaySeconds | int | `45` |  |
| loki.loki.schema_config.configs[0].from | string | `"2023-01-01"` |  |
| loki.loki.schema_config.configs[0].index.period | string | `"24h"` |  |
| loki.loki.schema_config.configs[0].index.prefix | string | `"index_"` |  |
| loki.loki.schema_config.configs[0].object_store | string | `"{{ include \"argocd-stack.storage\" .}}"` |  |
| loki.loki.schema_config.configs[0].schema | string | `"v12"` |  |
| loki.loki.schema_config.configs[0].store | string | `"tsdb"` |  |
| loki.loki.storage.bucketNames.admin | string | `"loki"` |  |
| loki.loki.storage.bucketNames.chunks | string | `"loki"` |  |
| loki.loki.storage.bucketNames.ruler | string | `"loki"` |  |
| loki.loki.storage.s3.accessKeyId | string | `"{{ include \"argocd-stack.minio.user\" .}}"` |  |
| loki.loki.storage.s3.endpoint | string | `"{{ include \"minio.endpoint\" .}}"` |  |
| loki.loki.storage.s3.insecure | bool | `true` |  |
| loki.loki.storage.s3.secretAccessKey | string | `"{{ include \"argocd-stack.minio.password\" .}}"` |  |
| loki.loki.storage.type | string | `"{{ include \"argocd-stack.storage\" .}}"` |  |
| loki.monitoring.dashboards.enabled | bool | `true` |  |
| loki.monitoring.serviceMonitor.enabled | bool | `false` |  |
| loki.nameOverride | string | `"loki"` |  |
| loki.readinessProbe.httpGet.path | string | `"/ready"` |  |
| loki.readinessProbe.httpGet.port | string | `"http-metrics"` |  |
| loki.readinessProbe.initialDelaySeconds | int | `45` |  |
| loki.singleBinary.replicas | int | `1` |  |
| metallb.crds.enabled | bool | `false` |  |
| metallb.enabled | bool | `true` |  |
| metallb.fullnameOverride | string | `"metallb"` |  |
| metallb.nameOverride | string | `"metallb"` |  |
| metrics-server.apiService.create | bool | `true` |  |
| metrics-server.apiService.insecureSkipTLSVerify | bool | `true` |  |
| metrics-server.args[0] | string | `"--kubelet-insecure-tls"` |  |
| metrics-server.enabled | bool | `true` |  |
| metrics-server.fullnameOverride | string | `"metrics-server"` |  |
| metrics-server.hostNetwork.enabled | bool | `false` |  |
| metrics-server.metrics.enabled | bool | `true` |  |
| metrics-server.nameOverride | string | `"metrics-server"` |  |
| metrics-server.serviceMonitor.enabled | bool | `false` |  |
| mimir.alertmanager.enabled | bool | `false` |  |
| mimir.enabled | bool | `false` |  |
| mimir.fullnameOverride | string | `"mimir"` |  |
| mimir.mimir.structuredConfig.activity_tracker.filepath | string | `"/active-query-tracker/activity.log"` |  |
| mimir.mimir.structuredConfig.blocks_storage.backend | string | `"s3"` |  |
| mimir.mimir.structuredConfig.blocks_storage.s3.access_key_id | string | `"{{ include \"argocd-stack.minio.user\" .}}"` |  |
| mimir.mimir.structuredConfig.blocks_storage.s3.bucket_name | string | `"mimir"` |  |
| mimir.mimir.structuredConfig.blocks_storage.s3.endpoint | string | `"{{ include \"minio.endpoint\" .}}"` |  |
| mimir.mimir.structuredConfig.blocks_storage.s3.insecure | bool | `true` |  |
| mimir.mimir.structuredConfig.blocks_storage.s3.secret_access_key | string | `"{{ include \"argocd-stack.minio.password\" .}}"` |  |
| mimir.mimir.structuredConfig.blocks_storage.tsdb.dir | string | `"/data/tsdb"` |  |
| mimir.mimir.structuredConfig.blocks_storage.tsdb.head_compaction_interval | string | `"15m"` |  |
| mimir.mimir.structuredConfig.blocks_storage.tsdb.wal_replay_concurrency | int | `3` |  |
| mimir.mimir.structuredConfig.usage_stats.installation_mode | string | `"helm"` |  |
| mimir.minio.enabled | bool | `false` |  |
| mimir.nameOverride | string | `"mimir"` |  |
| mimir.nginx.enabled | bool | `false` |  |
| minio.buckets[0].name | string | `"loki"` |  |
| minio.buckets[0].policy | string | `"none"` |  |
| minio.buckets[0].purge | bool | `false` |  |
| minio.buckets[1].name | string | `"tempo"` |  |
| minio.buckets[1].policy | string | `"none"` |  |
| minio.buckets[1].purge | bool | `false` |  |
| minio.buckets[2].name | string | `"mimir"` |  |
| minio.buckets[2].policy | string | `"none"` |  |
| minio.buckets[2].purge | bool | `false` |  |
| minio.enabled | bool | `true` |  |
| minio.fullnameOverride | string | `"minio"` |  |
| minio.logLevel | string | `"info"` |  |
| minio.mode | string | `"standalone"` |  |
| minio.nameOverride | string | `"minio"` |  |
| minio.replicas | string | `"{{ .Values.global.replicas }}"` |  |
| minio.rootPassword | string | `"minio123"` |  |
| minio.rootUser | string | `"minio"` |  |
| minio.serverPort | int | `3100` |  |
| nameOverride | string | `"argocd-stack"` |  |
| namespaceOverride | string | `nil` |  |
| prometheus.enabled | bool | `true` |  |
| tags.distributed | bool | `true` |  |
| tags.logging | bool | `true` |  |
| tags.monitoring | bool | `true` |  |
| tempo.enabled | bool | `true` |  |
| tempo.fullnameOverride | string | `"tempo"` |  |
| tempo.nameOverride | string | `"tempo"` |  |
| tempo.serviceMonitor.enabled | bool | `false` |  |
| tempo.storage.trace.backend | string | `"{{ include \"argocd-stack.storage\" .}}"` |  |
| tempo.storage.trace.bucket | string | `"tempo"` |  |
| tempo.storage.trace.s3.access_key | string | `"{{ include \"argocd-stack.minio.user\" .}}"` |  |
| tempo.storage.trace.s3.bucket | string | `"tempo"` |  |
| tempo.storage.trace.s3.endpoint | string | `"{{ include \"minio.endpoint\" .}}"` |  |
| tempo.storage.trace.s3.insecure | bool | `true` |  |
| tempo.storage.trace.s3.secret_key | string | `"{{ include \"argocd-stack.minio.password\" .}}"` |  |

