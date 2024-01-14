{{/*
Expand the name of the chart.
*/}}
{{- define "servarr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "servarr.fullname" }}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "servarr.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "servarr.labels" -}}
helm.sh/chart: {{ include "servarr.chart" . }}
{{ include "servarr.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "servarr.selectorLabels" -}}
app.kubernetes.io/name: {{ include "servarr.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "servarr.serviceAccountName" }}
{{- if .Values.serviceAccount.create }}
{{- default (include "servarr.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for ingress.
*/}}
{{- define "servarr.ingress.apiVersion" }}
  {{- if and (.Capabilities.APIVersions.Has "networking.k8s.io/v1") (semverCompare ">= 1.19-0" .Capabilities.KubeVersion.Version) }}
      {{- print "networking.k8s.io/v1" }}
  {{- else if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1" }}
    {{- print "networking.k8s.io/v1beta1" }}
  {{- else }}
    {{- print "extensions/v1beta1" }}
  {{- end }}
{{- end }}

{{- define "servarr.components" }}
{{- range $key, $val := pick .Values "sonarr" "radarr" "lidarr" "readarr" "prowlarr" }}
{{- if or $val.enabled (eq $key "prowlarr") }}
{{ $key }}:
  {{ toYaml $val | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{- define "servarr.postgresql.userPassword" }}
{{- default (uuidv4 | replace "-" "") .Values.global.postgresql.auth.password }}
{{- end }}

{{- define "servarr.postgresql.adminPassword" }}
{{- default (uuidv4 | replace "-" "") .Values.global.postgresql.auth.postgresPassword }}
{{- end }}

{{- define "servarr.postgresql.sonarrPassword" }}
{{- default "admin" .Values.sonarr.postgresql.password }}
{{- end }}

{{- define "servarr.downloadclient" }}
downloadclient:
- name: qBittorrent
  enable: true
  protocol: torrent
  priority: 2
  removeCompletedDownloads: true
  removeFailedDownloads: true
  fields:
  - name: host
    value: qbittorrent.media.svc.cluster.local
  - name: port
    value: 8080
  - name: username
    value: admin
  - name: password
    value: adminadmin
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


{{- define "servarr.flemmarrSection" -}}
{{- $v := first . -}}
{{- $k := last . -}}
{{- $k }}:
  server:
    address: http://{{ $k }}.media.svc.cluster.local
    port: {{ $v.service.port }}
  {{- with omit $v.config "enabled" }}
  config:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $v.rootfolder }}
  rootfolder:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{ include "servarr.downloadclient" $ | nindent 2 }}
{{- end }}
