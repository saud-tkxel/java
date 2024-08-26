{{/*
Return the name of the chart.
*/}}
{{- define "mychart.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/*
Return the full name of the release.
*/}}
{{- define "mychart.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}

{{/*
Return the chart version.
*/}}
{{- define "mychart.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

