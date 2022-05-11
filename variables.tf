## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "region" {}
variable "tenancy_ocid" {}
variable "compartment_ocid" {}

variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

variable release {
  default = "1.0"
}

variable deploy_demo_application {
  default = true
}

variable "dataflow_warehouse_bucket_name" {
  default = "dataflow-warehouse"
}
variable "dataflow_warehouse_bucket_access_type" {
  default = ""
}
variable "dataflow_warehouse_bucket_storage_tier" {
  default = ""
}

variable "dataflow_logs_bucket_name" {
  default = "dataflow-logs"
}
variable "dataflow_logs_bucket_access_type" {
  default = ""
}
variable "dataflow_logs_bucket_storage_tier" {
  default = ""
}

variable "dataflow_admins_group_name" {
  default = "dataflow-admins-group"
}
variable "dataflow_admins_group_description" {
  default = "Data Flow Admins group"
}

variable "dataflow_admins_policy_name" {
  default = "dataflow-admins-policy"
}

variable "dataflow_admins_policy_description" {
  default = "Data Flow Admins policy"
}

variable "dataflow_users_group_name" {
  default = "dataflow-users-group"
}

variable "dataflow_users_group_description" {
  default = "Data Flow Users group"
}

variable "dataflow_users_policy_name" {
  default = "dataflow-users-policy"
}

variable "dataflow_users_policy_description" {
  default = "Data Flow Users policy"
}

variable "application_display_name" {
  default = "tf_app"
}

variable "application_driver_shape" {
  default = "VM.Standard2.1"
}

variable "application_executor_shape" {
  default = "VM.Standard2.1"
}

variable "application_file_uri" {
  default = ""
}

variable "arguments" {
  default = [""]
}

variable "application_archive_uri" {
  default = ""
}

variable "application_language" {
  default = "PYTHON"
}

variable "application_num_executors" {
  default = 1
}

variable "application_spark_version" {
  default = "3.0"
}

