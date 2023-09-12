{{- define "prowlarr.name" -}}
{{- default "prowlarr" .Values.prowlarr.name }}
{{- end -}}

{{/*
prowlarr common labels
*/}}
{{- define "prowlarr.labels" -}}
{{ include "servarr.labels" . }}
app.kubernetes.io/component: prowlarr
{{- end }}

{{/*
prowlarr selector labels
*/}}
{{- define "prowlarr.selectorLabels" -}}
{{ include "servarr.selectorLabels" . }}
app.kubernetes.io/component: prowlarr
{{- end }}

{{/*
prowlarr priority class name
*/}}
{{- define "prowlarr.priorityClassName" -}}
{{- $pcn := coalesce .Values.common.priorityClassName .Values.prowlarr.priorityClassName -}}
{{- if $pcn }}
priorityClassName: {{ $pcn }}
{{- end }}
{{- end }}

{{- define "prowlarr.port" -}}
{{- default 8989 .Values.prowlarr.service.port }}
{{- end }}

{{- define "prowlarr.apiKey" -}}
{{ default (uuidv4 | replace "-" "") .Values.prowlarr.apiKey }}
{{- end -}}

{{- define "prowlarr.configData" -}}
<Config>
  <BindAddress>*</BindAddress>
  <Port>{{ .Values.prowlarr.service.port }}</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <LaunchBrowser>True</LaunchBrowser>
  <ApiKey>{{ include "prowlarr.apiKey" . }}</ApiKey>
  <AuthenticationMethod>None</AuthenticationMethod>
  <Branch>master</Branch>
  <LogLevel>info</LogLevel>
  <SslCertPath></SslCertPath>
  <SslCertPassword></SslCertPassword>
  <UrlBase></UrlBase>
  <InstanceName>prowlarr</InstanceName>
  <UpdateMechanism>Docker</UpdateMechanism>
  <AnalyticsEnabled>False</AnalyticsEnabled>
</Config>
{{- end -}}

{{/*
The volume to mount for loki configuration
*/}}
{{- define "prowlarr.configVolume" -}}
{{- if eq .Values.prowlarr.configStorageType "Secret" -}}
secret:
  secretName: {{ tpl .Values.prowlarr.externalConfigSecretName . }}
{{- else if eq .Values.prowlarr.configStorageType "ConfigMap" -}}
configMap:
  name: {{ tpl .Values.prowlarr.externalConfigSecretName . }}
  items:
    - key: "config.xml"
      path: "config.xml"
{{- end -}}
{{- end -}}
