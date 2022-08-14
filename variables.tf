
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "location" {
  type    = string
  default = "Central US"
}
variable "environment" {
  type    = string
  default = "dev"
}
