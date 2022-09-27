variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "location" {
  type        = string
  description = "RG location in Azure"
}

variable "storage_account_name" {
  type        = string
  description = "Storage Account name in Azure"
}

variable "storage_account_name_function" { 
    type     = string 
    description   = "function Storage Account name in Azure"
}

variable "images_container_name" {
  type        = string
  description = "Storage Container name in Azure"
}

variable "thumbnail_container_name" {
  type        = string
  description = "Storage Container name in Azure"
}

variable "function_app_name" {
  type    = string
  default = ""
}

variable "language" {
  type    = string
  default = ""
}

variable "function_app_function" {
  type    = string
  default = ""
}

variable "event_delivery_schema" {
  type    = string
  default = ""
}

variable "image_resizer_eventsub" {
  type    = string
  default = ""
}

variable "blob_account_replication_type" {
  type    = string
  default = ""
}
variable "blob_storage_account_tier" {
  type    = string
  default = ""
}

variable "function_storage_account_tier" {
  type    = string
  default = ""
}
variable "function_account_replication_type" {
  type    = string
  default = ""
}
variable "company" {
  type    = string
  default = ""
}
variable "env" {
  type    = string
  default = ""
}

variable "sku_name" {
  type = string
  description = ""
  
}

variable "os_type" {
  type = string
  description = ""
  
}

variable "asp_name" {
  type = string
  description = ""
}

variable "webapp_repo_url" {
  type = string
  description = ""
  
}

variable "images_container_access_type" {
  type = string
  description = ""
  
}
variable "thumbnail_container_access_type" {
  type = string
  description = ""
  
}
variable "image_resizer_webapp" {
  type = string
  description = ""
  
}

variable "webapp_repo_branch" {
  type = string
  description = ""
  
}