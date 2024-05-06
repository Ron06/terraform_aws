variable "host_os" {
  type        = string
  default     = "linux"
  description = "my os"
}

## Alert email receiver
variable "alert_email_id" {
  description = "Email id to send alerts to "
  type        = string
  default     = file(".env")["MY_EMAIL"] # from .env
}