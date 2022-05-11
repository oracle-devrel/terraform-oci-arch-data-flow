## Copyright © 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

locals {
    namespace = data.oci_objectstorage_namespace.os_namespace.namespace
}

resource "oci_objectstorage_bucket" "dataflow_warehouse" {
    compartment_id = var.compartment_ocid
    name = "${var.dataflow_warehouse_bucket_name}-${random_id.tag.hex}"
    namespace = local.namespace
    access_type = var.dataflow_warehouse_bucket_access_type
    storage_tier = var.dataflow_warehouse_bucket_storage_tier
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_objectstorage_bucket" "dataflow_logs" {
    compartment_id = var.compartment_ocid
    name = "${var.dataflow_logs_bucket_name}-${random_id.tag.hex}"
    namespace = local.namespace
    access_type = var.dataflow_logs_bucket_access_type
    storage_tier = var.dataflow_logs_bucket_storage_tier
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_objectstorage_object" "code" {
    count = var.deploy_demo_application ? 1 : 0
    bucket = oci_objectstorage_bucket.dataflow_warehouse.name
    namespace = local.namespace
    source = "./files/datacleaning.py"
    object = "datacleaning.py"
}

resource "oci_objectstorage_object" "sample_data" {
    count = var.deploy_demo_application ? 1 : 0
    bucket = oci_objectstorage_bucket.dataflow_warehouse.name
    namespace = local.namespace
    source = "./files/netflix_titles.csv"
    object = "netflix_titles.csv"
}