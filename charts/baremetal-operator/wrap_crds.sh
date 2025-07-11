#!/bin/bash

# Array of CRD files and their corresponding names
declare -A crds=(
    ["metal3.io_hostfirmwarecomponents.yaml"]="hostfirmwarecomponents"
    ["metal3.io_hostfirmwaresettings.yaml"]="hostfirmwaresettings"
    ["metal3.io_firmwareschemas.yaml"]="firmwareschemas"
    ["metal3.io_preprovisioningimages.yaml"]="preprovisioningimages"
    ["metal3.io_bmceventsubscriptions.yaml"]="bmceventsubscriptions"
    ["metal3.io_hardwaredata.yaml"]="hardwaredata"
    ["metal3.io_dataimages.yaml"]="dataimages"
    ["metal3.io_hostupdatepolicies.yaml"]="hostupdatepolicies"
)

cd /Users/atkini01/src/appkins-org/charts/charts/baremetal-operator/templates/crds

for file in "${!crds[@]}"; do
    crd_name="${crds[$file]}"
    echo "Processing $file with CRD name: $crd_name"

    # Create a temporary file
    temp_file=$(mktemp)

    # Add the template header
    cat << EOF > "$temp_file"
{{- if .Values.crds.install }}
{{- if has "$crd_name" .Values.crds.crdList }}
EOF

    # Add the original content but modify the metadata section
    sed '1,/^metadata:/d' "$file" | sed '1,/^  name:/d' > temp_content

    cat << EOF >> "$temp_file"
---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.16.5
    {{- if .Values.crds.caInjection.enabled }}
    {{- if has "$crd_name" .Values.crds.caInjection.enabledCrds }}
    cert-manager.io/inject-ca-from: {{ .Values.namespace.name }}/{{ .Values.namePrefix }}{{ .Values.certManager.certificate.name }}
    {{- end }}
    {{- end }}
  name: $crd_name.metal3.io
  labels:
    {{- include "baremetal-operator.labels" . | nindent 4 }}
    {{- with .Values.commonLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
EOF

    # Add the spec content, but modify the scope line to add webhook conversion
    sed -n '/^spec:/,$ p' "$file" | sed '1d' | sed '/^  scope: Namespaced$/a \
  {{- if .Values.crds.webhookConversion.enabled }}\
  {{- if has "'$crd_name'" .Values.crds.webhookConversion.enabledCrds }}\
  conversion:\
    strategy: Webhook\
    webhook:\
      clientConfig:\
        service:\
          namespace: {{ .Values.namespace.name }}\
          name: {{ .Values.namePrefix }}{{ .Values.webhook.service.name }}\
          path: /convert\
        {{- if not .Values.certManager.enabled }}\
        caBundle: Cg==\
        {{- end }}\
      conversionReviewVersions:\
      - v1\
  {{- end }}\
  {{- end }}' >> "$temp_file"

    # Add the closing template conditions
    cat << EOF >> "$temp_file"
{{- end }}
{{- end }}
EOF

    # Replace the original file
    mv "$temp_file" "$file"

    echo "Processed $file"
done

echo "All CRD files have been processed!"
