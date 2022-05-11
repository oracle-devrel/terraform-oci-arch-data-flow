## Copyright © 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

locals {
  warehouse_bucket_uri = "oci://${oci_objectstorage_bucket.dataflow_warehouse.name}@${local.namespace}/"
  logs_bucket_uri      = "oci://${oci_objectstorage_bucket.dataflow_logs.name}@${local.namespace}/"
  file_uri = var.deploy_demo_application ? join("",["${local.warehouse_bucket_uri}","${oci_objectstorage_object.code[0].object}"]) : var.application_file_uri
  arguments = var.deploy_demo_application ? [join("",["${local.warehouse_bucket_uri}","${oci_objectstorage_object.sample_data[0].object}"])] : var.arguments
}

resource "oci_dataflow_application" "tf_application" {
  arguments      = local.arguments
  compartment_id = var.compartment_ocid
  display_name   = var.application_display_name
  driver_shape   = var.application_driver_shape
  executor_shape = var.application_executor_shape
  file_uri       = local.file_uri
  language       = var.application_language
  num_executors  = var.application_num_executors
  spark_version  = var.application_spark_version
  warehouse_bucket_uri = local.warehouse_bucket_uri
  logs_bucket_uri      = local.logs_bucket_uri
}