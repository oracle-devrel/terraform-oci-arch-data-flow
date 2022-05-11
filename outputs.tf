## Copyright © 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "dataflow_warehouse_bucket_name" {
 value = "${oci_objectstorage_bucket.dataflow_warehouse.name}"
}

output "dataflow_logs_bucket_name" {
 value = "${oci_objectstorage_bucket.dataflow_logs.name}"
}

output "file_uri" {
 value = local.file_uri
}

output "arguments" {
 value = local.arguments
}