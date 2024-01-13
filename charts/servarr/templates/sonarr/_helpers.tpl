{{- define "sonarr.name" }}
{{- default "sonarr" .Values.sonarr.name }}
{{- end }}

{{- define "sonarr.configName" }}
{{- default (printf "%s-config" (include "sonarr.name" .)) .Values.sonarr.externalConfigSecretName }}
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
{{- $name := (include "sonarr.name" .) -}}
{{- with .Values.sonarr }}
<Config>
  <BindAddress>*</BindAddress>
  <Port>{{ .service.port }}</Port>
  <SslPort>9898</SslPort>
  <EnableSsl>False</EnableSsl>
  <LaunchBrowser>False</LaunchBrowser>
  <ApiKey>{{ include "sonarr.apiKey" $ }}</ApiKey>
  <AuthenticationMethod>None</AuthenticationMethod>
  <Branch>master</Branch>
  <LogLevel>info</LogLevel>
  <SslCertPath></SslCertPath>
  <SslCertPassword></SslCertPassword>
  <UrlBase></UrlBase>
  <InstanceName>{{ $name }}</InstanceName>
  <UpdateMechanism>Docker</UpdateMechanism>
  <AnalyticsEnabled>False</AnalyticsEnabled>
{{- if .postgresql.enabled }}
  {{- with .postgresql }}
  <PostgresUser>{{ default $name .username }}</PostgresUser>
  <PostgresPassword>{{ default $name .password }}</PostgresPassword>
  <PostgresPort>{{ default "5432" .port }}</PostgresPort>
  <PostgresHost>{{ default $name .host }}</PostgresHost>
  <PostgresMainDb>{{ default (printf "%s-main" $name) .database }}</PostgresMainDb>
  {{- if .logdb }}
  <PostgresLogDb>{{ .logdb }}</PostgresLogDb>
  {{- end }}
  {{- end }}
{{- end }}
</Config>
{{- end }}
{{- end }}

{{- define "sonarr.flemmarrData" -}}
{{- with .Values.sonarr }}
sonarr:
  server:
    address: localhost
    port: {{ .service.port }}
  {{- with .config }}
  config:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .rootfolder }}
  rootfolder:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  downloadclient:
    - name: qBittorrent
      enable: true
      protocol: torrent
      priority: 2
      removeCompletedDownloads: true
      removeFailedDownloads: true
      fields:
      - name: host
        value: qbittorrent.{{ $.Release.Namespace }}.svc.cluster.local
      - name: port
        value: 8080
      - name: username
        value: username
      - name: password
        value: password
      - name: tvCategory
        value: tv
      - name: recentTvPriority
        value: 0
      - name: olderTvPriority
        value: 0
      - name: initialState
        value: 0
      - name: sequentialOrder
        value: false
      - name: firstAndLast
        value: false
      implementation: QBittorrent
      configContract: QBittorrentSettings
{{- end }}
{{- end }}

{{/*
The volume to mount for loki configuration
*/}}
{{- define "sonarr.configVolume" -}}
{{- if eq .Values.sonarr.configStorageType "Secret" -}}
secret:
  secretName: {{ include "sonarr.configName" . }}
{{- else if eq .Values.sonarr.configStorageType "ConfigMap" -}}
configMap:
  name: {{ include "sonarr.configName" . }}
  items:
    - key: "config.xml"
      path: "config.xml"
    - key: "config.yml"
      path: "config.yml"
{{- end }}
{{- end }}

{{/*
The volume to mount for loki configuration
*/}}
{{- define "sonarr.configScript" }}

{{- end }}
