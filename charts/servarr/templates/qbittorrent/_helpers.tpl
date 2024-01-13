{{- define "qbittorrent.name" -}}
{{- default "qbittorrent" .Values.qbittorrent.name }}
{{- end -}}

{{/*
qbittorrent common labels
*/}}
{{- define "qbittorrent.labels" -}}
{{- include "servarr.labels" . }}
app.kubernetes.io/component: qbittorrent
{{- end }}

{{/*
qbittorrent selector labels
*/}}
{{- define "qbittorrent.selectorLabels" -}}
{{- include "servarr.selectorLabels" . }}
app.kubernetes.io/component: qbittorrent
{{- end }}

{{- define "qbittorrent.port" }}
{{- default 8000 .Values.qbittorrent.service.port }}
{{- end }}

{{- define "qbittorrent.apiKey" -}}
{{- default (uuidv4 | replace "-" "") .Values.qbittorrent.apiKey }}
{{- end }}

{{- define "qbittorrent.recurseFlattenMap" -}}
{{- $map := first . -}}
{{- $label := last . -}}
{{- range $key, $val := $map -}}
{{- $sublabel := $key | title -}}
{{- if $label -}}
{{- $sublabel = list $label $key | join "\\" | title -}}
{{- end -}}
{{- if kindOf $val | eq "map" -}}
    {{- list $val $sublabel | include "qbittorrent.recurseFlattenMap" -}}
{{- else }}
{{ printf "%s=%v" $sublabel $val | indent 2 }}
{{- end }}
{{- end -}}
{{- end -}}


{{- define "qbittorrent.configData" -}}
{{- range $k, $v := .Values.qbittorrent.config }}
{{ printf "[%s]" (title $k) }}
{{- if and $v (kindIs "map" $v) -}}
    {{- list $v nil | include "qbittorrent.recurseFlattenMap" -}}
{{- end }}
{{- end -}}
{{- end -}}

{{/*
The volume to mount for loki configuration
*/}}
{{- define "qbittorrent.configVolume" -}}
{{- if eq .Values.qbittorrent.configStorageType "Secret" }}
secret:
  secretName: {{ tpl .Values.qbittorrent.externalConfigSecretName . }}
{{- else if eq .Values.qbittorrent.configStorageType "ConfigMap" }}
configMap:
  name: {{ tpl .Values.qbittorrent.externalConfigSecretName . }}
  items:
    - key: "config.xml"
      path: "config.xml"
{{- end }}
{{- end }}
