{{/*
flamarr fullname
*/}}
{{- define "flamarr.name" -}}
{{- default "flamarr" .Values.flamarr.name }}
{{- end -}}

{{/*
flamarr common labels
*/}}
{{- define "flamarr.labels" -}}
{{ include "servarr.labels" . }}
app.kubernetes.io/component: flamarr
{{- end }}

{{/*
flamarr selector labels
*/}}
{{- define "flamarr.selectorLabels" -}}
{{ include "servarr.selectorLabels" . }}
app.kubernetes.io/component: flamarr
{{- end }}
