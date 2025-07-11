# Baremetal Operator Helm Chart

This Helm chart deploys the [Metal3 Baremetal Operator](https://github.com/metal3-io/baremetal-operator) to Kubernetes.

## Overview

The Baremetal Operator is a Kubernetes controller that manages bare metal hosts, providing lifecycle management for physical servers through the Metal3 project. This chart converts the original Kustomize-based deployment into a parameterized Helm chart.

## Features

- **Customizable CRDs**: Install and configure Custom Resource Definitions with webhook conversion and CA injection
- **Webhook Support**: Configurable admission webhooks for validation and conversion
- **Cert-Manager Integration**: Automatic certificate management for secure webhook communication
- **RBAC**: Complete role-based access control configuration
- **Ironic Integration**: Configurable connection to Ironic services
- **Prometheus Monitoring**: Optional metrics collection

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- cert-manager (if using webhook certificates)

## Installation

### Basic Installation

```bash
helm repo add metal3 https://metal3-io.github.io/baremetal-operator
helm install baremetal-operator metal3/baremetal-operator
```

### Custom Installation

```bash
helm install baremetal-operator metal3/baremetal-operator \
  --set webhook.enabled=true \
  --set certManager.enabled=true \
  --set crds.install=true
```

## Configuration

### Key Configuration Options

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespace.create` | Create the namespace | `true` |
| `namespace.name` | Namespace name | `baremetal-operator-system` |
| `webhook.enabled` | Enable webhook | `true` |
| `certManager.enabled` | Enable cert-manager integration | `true` |
| `crds.install` | Install CRDs | `true` |
| `crds.webhookConversion.enabled` | Enable webhook conversion for CRDs | `true` |
| `crds.caInjection.enabled` | Enable CA injection for CRDs | `true` |
| `prometheus.enabled` | Enable Prometheus monitoring | `false` |
| `prometheus.serviceMonitor.enabled` | Enable ServiceMonitor creation | `false` |
| `prometheus.serviceMonitor.namespace` | Namespace for ServiceMonitor | `""` |

### CRD Configuration

The chart allows fine-grained control over which CRDs have webhook conversion and CA injection enabled:

```yaml
crds:
  install: true
  webhookConversion:
    enabled: true
    enabledCrds:
      - baremetalhosts
      - hostfirmwarecomponents
      - hostfirmwaresettings
  caInjection:
    enabled: true
    enabledCrds:
      - baremetalhosts
      - hostfirmwarecomponents
```

### Ironic Configuration

Configure the connection to Ironic services:

```yaml
ironic:
  config:
    IRONIC_ENDPOINT: "http://ironic.example.com:6385/v1"
    IRONIC_INSPECTOR_ENDPOINT: "http://ironic-inspector.example.com:5050/v1"
    IRONIC_DEPLOYMENT: "Integrated"
    IRONIC_TIMEOUT: "3600"
```

### Webhook Configuration

The chart supports configurable webhook settings:

```yaml
webhook:
  enabled: true
  service:
    name: webhook-service
    port: 443
    targetPort: 8443
  validatingWebhookConfiguration:
    failurePolicy: Fail
    sideEffects: None
```

### Prometheus Monitoring

The chart supports optional Prometheus monitoring through ServiceMonitor:

```yaml
prometheus:
  enabled: true
  serviceMonitor:
    enabled: true
    namespace: "monitoring"  # Optional: Deploy to monitoring namespace
    labels:
      app: baremetal-operator
    interval: 30s
    scrapeTimeout: 10s
```

The monitoring setup includes:

- **Metrics Service**: Exposes controller metrics on port 8443
- **ServiceMonitor**: Configures Prometheus to scrape metrics
- **RBAC**: Provides authentication and authorization for metrics access
- **TLS**: Secure metrics endpoint with bearer token authentication

## Upgrading

To upgrade the chart:

```bash
helm upgrade baremetal-operator metal3/baremetal-operator
```

## Updating CRDs

The CRDs in this chart are kept as close to the original as possible to make updates easy. To update CRDs:

1. Copy the new CRD files from the baremetal-operator repository
2. Place them in `templates/crds/`
3. Ensure each file is wrapped with `{{- if .Values.crds.install }}` and `{{- end }}`

The webhook conversion and CA injection patches are applied separately through the `templates/crds/crds.yaml` file.

## Uninstalling

To uninstall the chart:

```bash
helm uninstall baremetal-operator
```

Note: CRDs are not automatically removed during uninstall. To remove them manually:

```bash
kubectl delete crd baremetalhosts.metal3.io
kubectl delete crd hostfirmwarecomponents.metal3.io
# ... etc for other CRDs
```

## Values

See `values.yaml` for the complete list of configurable values.

## License

This chart is licensed under the Apache License 2.0.
