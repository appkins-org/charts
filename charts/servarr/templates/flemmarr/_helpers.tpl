{{/*
flemmarr fullname
*/}}
{{- define "flemmarr.name" -}}
{{- default "flemmarr" .Values.flemmarr.name }}
{{- end -}}

{{/*
flemmarr common labels
*/}}
{{- define "flemmarr.labels" -}}
{{ include "servarr.labels" . }}
app.kubernetes.io/component: flemmarr
{{- end }}

{{/*
flemmarr selector labels
*/}}
{{- define "flemmarr.selectorLabels" -}}
{{ include "servarr.selectorLabels" . }}
app.kubernetes.io/component: flemmarr
{{- end }}
