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
  <LaunchBrowser>False</LaunchBrowser>
  <ApiKey>{{ include "sonarr.apiKey" . }}</ApiKey>
  <AuthenticationMethod>None</AuthenticationMethod>
  <Branch>master</Branch>
  <LogLevel>info</LogLevel>
  <SslCertPath></SslCertPath>
  <SslCertPassword></SslCertPassword>
  <UrlBase></UrlBase>
  <InstanceName>{{ include "sonarr.name" . }}</InstanceName>
  <UpdateMechanism>Docker</UpdateMechanism>
  <AnalyticsEnabled>False</AnalyticsEnabled>
{{- if .Values.sonarr.postgresql.enabled }}
{{ printf "<PostgresUser>%s</PostgresUser>" (default (include "sonarr.name" .) .Values.sonarr.postgresql.username) | indent 2 }}
{{ printf "<PostgresPassword>%s</PostgresPassword>" (default (include "sonarr.name" .) .Values.sonarr.postgresql.password) | indent 2 }}
{{ printf "<PostgresPort>%v</PostgresPort>" (default "5432" .Values.sonarr.postgresql.port) | indent 2 }}
{{ printf "<PostgresHost>%s</PostgresHost>" (default (include "sonarr.name" .) .Values.sonarr.postgresql.host) | indent 2 }}
{{ printf "<PostgresMainDb>%s</PostgresMainDb>" (default (printf "%s-main" (include "sonarr.name" .)) .Values.sonarr.postgresql.database) | indent 2 }}
{{- if .Values.sonarr.postgresql.logdb }}
{{ printf "<PostgresLogDb>%s</PostgresLogDb>" .Values.sonarr.postgresql.logdb | indent 2 }}
{{- end }}
{{- end }}
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

{{/*
The volume to mount for loki configuration
*/}}
{{- define "sonarr.configScript" }}

{{- end }}
