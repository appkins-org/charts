{{- define "sonarr.name" }}
{{- default "sonarr" .Values.sonarr.name }}
{{- end }}

{{/*
Sonarr common labels
*/}}
{{- define "sonarr.labels" -}}
{{- include "servarr.labels" . }}
app.kubernetes.io/component: sonarr
{{- end }}

{{/*
Sonarr selector labels
*/}}
{{- define "sonarr.selectorLabels" -}}
{{- include "servarr.selectorLabels" . }}
app.kubernetes.io/component: sonarr
{{- end }}

{{/*
Sonarr priority class name
*/}}
{{- define "sonarr.priorityClassName" }}
{{- $pcn := coalesce .Values.common.priorityClassName .Values.sonarr.priorityClassName }}
{{- default "" $pcn }}
{{- end }}

{{- define "sonarr.port" }}
{{- default 8989 .Values.sonarr.service.port }}
{{- end }}

{{- define "sonarr.apiKey" }}
{{- .Values.sonarr.apiKey | default (uuidv4 | replace "-" "") }}
{{- end }}

{{- define "sonarr.configData" -}}
<Config>
  <BindAddress>*</BindAddress>
  <Port>{{ .Values.sonarr.service.port }}</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <LaunchBrowser>True</LaunchBrowser>
  <ApiKey>{{ include "sonarr.apiKey" . }}</ApiKey>
  <AuthenticationMethod>None</AuthenticationMethod>
  <Branch>master</Branch>
  <LogLevel>info</LogLevel>
  <SslCertPath></SslCertPath>
  <SslCertPassword></SslCertPassword>
  <UrlBase></UrlBase>
  <InstanceName>sonarr</InstanceName>
  <UpdateMechanism>Docker</UpdateMechanism>
  <AnalyticsEnabled>False</AnalyticsEnabled>
</Config>
{{- end }}

{{/*
The volume to mount for loki configuration
*/}}
{{- define "sonarr.configVolume" }}
{{- if eq .Values.sonarr.configStorageType "Secret" }}
secret:
  secretName: {{ tpl .Values.sonarr.externalConfigSecretName . }}
{{- else if eq .Values.sonarr.configStorageType "ConfigMap" }}
configMap:
  name: {{ tpl .Values.sonarr.externalConfigSecretName . }}
  items:
    - key: "config.xml"
      path: "config.xml"
{{- end }}
{{- end }}
