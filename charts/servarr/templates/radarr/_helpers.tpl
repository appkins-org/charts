{{- define "radarr.name" -}}
{{- default "radarr" .Values.radarr.name }}
{{- end -}}

{{/*
radarr common labels
*/}}
{{- define "radarr.labels" -}}
{{ include "servarr.labels" . }}
app.kubernetes.io/component: radarr
{{- end }}

{{/*
radarr selector labels
*/}}
{{- define "radarr.selectorLabels" -}}
{{ include "servarr.selectorLabels" . }}
app.kubernetes.io/component: radarr
{{- end }}

{{/*
radarr priority class name
*/}}
{{- define "radarr.priorityClassName" -}}
{{- $pcn := coalesce .Values.common.priorityClassName .Values.radarr.priorityClassName -}}
{{- if $pcn }}
priorityClassName: {{ $pcn }}
{{- end }}
{{- end }}

{{- define "radarr.port" -}}
{{- default 8989 .Values.radarr.service.port }}
{{- end }}

{{- define "radarr.apiKey" -}}
{{ default (uuidv4 | replace "-" "") .Values.radarr.apiKey }}
{{- end -}}

{{- define "radarr.configData" -}}
<Config>
  <BindAddress>*</BindAddress>
  <Port>{{ .Values.radarr.service.port }}</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <LaunchBrowser>True</LaunchBrowser>
  <ApiKey>{{ include "radarr.apiKey" . }}</ApiKey>
  <AuthenticationMethod>None</AuthenticationMethod>
  <Branch>master</Branch>
  <LogLevel>info</LogLevel>
  <SslCertPath></SslCertPath>
  <SslCertPassword></SslCertPassword>
  <UrlBase></UrlBase>
  <InstanceName>{{ $key }}</InstanceName>
  <UpdateMechanism>Docker</UpdateMechanism>
  <AnalyticsEnabled>False</AnalyticsEnabled>
</Config>
{{- end -}}

{{/*
The volume to mount for loki configuration
*/}}
{{- define "radarr.configVolume" -}}
{{- if eq .Values.radarr.configStorageType "Secret" -}}
secret:
  secretName: {{ tpl .Values.radarr.externalConfigSecretName . }}
{{- else if eq .Values.radarr.configStorageType "ConfigMap" -}}
configMap:
  name: {{ tpl .Values.radarr.externalConfigSecretName . }}
  items:
    - key: "config.xml"
      path: "config.xml"
{{- end -}}
{{- end -}}
