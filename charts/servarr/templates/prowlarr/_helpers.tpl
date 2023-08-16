{{/*
Prowlarr fullname
*/}}
{{- define "prowlarr.fullName" -}}
{{- if .Values.prowlarr.name }}
{{- default "prowlarr" .Values.prowlarr.name -}}
{{- else }}
{{ include "servarr.name" . }}-prowlarr
{{- end }}

{{/*
Prowlarr common labels
*/}}
{{- define "prowlarr.labels" -}}
{{ include "servarr.labels" . }}
app.kubernetes.io/component: prowlarr
{{- end }}

{{/*
Prowlarr selector labels
*/}}
{{- define "prowlarr.selectorLabels" -}}
{{ include "servarr.selectorLabels" . }}
app.kubernetes.io/component: prowlarr
{{- end }}
