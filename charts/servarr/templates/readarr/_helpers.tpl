{{- define "readarr.name" -}}
{{- default "readarr" .Values.readarr.name }}
{{- end -}}

{{/*
readarr common labels
*/}}
{{- define "readarr.labels" -}}
{{ include "servarr.labels" . }}
app.kubernetes.io/component: readarr
{{- end }}

{{/*
readarr selector labels
*/}}
{{- define "readarr.selectorLabels" -}}
{{ include "servarr.selectorLabels" . }}
app.kubernetes.io/component: readarr
{{- end }}

{{/*
readarr priority class name
*/}}
{{- define "readarr.priorityClassName" -}}
{{- $pcn := coalesce .Values.common.priorityClassName .Values.readarr.priorityClassName -}}
{{- if $pcn }}
priorityClassName: {{ $pcn }}
{{- end }}
{{- end }}

{{- define "readarr.port" -}}
{{- default 8989 .Values.readarr.service.port }}
{{- end }}

{{- define "readarr.apiKey" -}}
{{ default (uuidv4 | replace "-" "") .Values.readarr.apiKey }}
{{- end -}}

{{- define "readarr.configData" -}}
<Config>
  <BindAddress>*</BindAddress>
  <Port>{{ .Values.readarr.service.port }}</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <LaunchBrowser>True</LaunchBrowser>
  <ApiKey>{{ include "readarr.apiKey" . }}</ApiKey>
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
{{- define "readarr.configVolume" -}}
{{- if eq .Values.readarr.configStorageType "Secret" -}}
secret:
  secretName: {{ tpl .Values.readarr.externalConfigSecretName . }}
{{- else if eq .Values.readarr.configStorageType "ConfigMap" -}}
configMap:
  name: {{ tpl .Values.readarr.externalConfigSecretName . }}
  items:
    - key: "config.xml"
      path: "config.xml"
{{- end -}}
{{- end -}}
