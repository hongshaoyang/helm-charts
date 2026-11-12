{{- define "webserver.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "webserver.fullname" -}}
{{- $name := .Chart.Name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "webserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "webserver.labels" -}}
helm.sh/chart: {{ include "webserver.chart" . }}
{{ include "webserver.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "webserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "webserver.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}