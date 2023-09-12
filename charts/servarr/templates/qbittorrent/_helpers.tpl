{{- define "qbittorrent.name" -}}
{{- default "qbittorrent" .Values.qbittorrent.name }}
{{- end -}}

{{/*
qbittorrent common labels
*/}}
{{- define "qbittorrent.labels" -}}
{{ include "servarr.labels" . }}
app.kubernetes.io/component: qbittorrent
{{- end }}

{{/*
qbittorrent selector labels
*/}}
{{- define "qbittorrent.selectorLabels" -}}
{{ include "servarr.selectorLabels" . }}
app.kubernetes.io/component: qbittorrent
{{- end }}

{{/*
qbittorrent priority class name
*/}}
{{- define "qbittorrent.priorityClassName" -}}
{{- $pcn := coalesce .Values.common.priorityClassName .Values.qbittorrent.priorityClassName -}}
{{- if $pcn }}
priorityClassName: {{ $pcn }}
{{- end }}
{{- end }}

{{- define "qbittorrent.port" -}}
{{- default 8000 .Values.qbittorrent.service.port }}
{{- end }}

{{- define "qbittorrent.apiKey" -}}
{{ default (uuidv4 | replace "-" "") .Values.qbittorrent.apiKey }}
{{- end -}}

{{- define "qbittorrent.configData" -}}
[AutoRun]
enabled=false
program=

[Locking]
locked=false

[BitTorrent]
Session\DefaultSavePath=/downloads/
Session\Port=6881
Session\QueueingSystemEnabled=true
Session\TempPath=/downloads/

[LegalNotice]
Accepted=true

[Meta]
MigrationVersion=4

[Network]
PortForwardingEnabled=false

[Preferences]
Connection\PortRangeMin=6881
Connection\UPnP=false
Downloads\SavePath=/downloads/
Downloads\TempPath=/downloads/
WebUI\Address=*
WebUI\Port={{ include "qbittorrent.port" . }}
WebUI\ServerDomains=*
WebUI\AlternativeUIEnabled=true
WebUI\RootFolder=/data/vuetorrent
WebUI\HostHeaderValidation=false
WebUI\CSRFProtection=false
WebUI\CustomHTTPHeadersEnabled=false
WebUI\AuthSubnetWhitelistEnabled=true
WebUI\AuthSubnetWhitelist=10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 0.0.0.0/0
{{- end -}}

{{/*
The volume to mount for loki configuration
*/}}
{{- define "qbittorrent.configVolume" -}}
{{- if eq .Values.qbittorrent.configStorageType "Secret" -}}
secret:
  secretName: {{ tpl .Values.qbittorrent.externalConfigSecretName . }}
{{- else if eq .Values.qbittorrent.configStorageType "ConfigMap" -}}
configMap:
  name: {{ tpl .Values.qbittorrent.externalConfigSecretName . }}
  items:
    - key: "config.xml"
      path: "config.xml"
{{- end -}}
{{- end -}}
