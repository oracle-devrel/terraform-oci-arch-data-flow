## Copyright © 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_identity_group" "dataflow_admin_group" {
    provider = oci.homeregion
    compartment_id = var.tenancy_ocid
    description = var.dataflow_admins_group_description
    name = var.dataflow_admins_group_name    
}

resource "oci_identity_group" "dataflow_user_group" {
    provider = oci.homeregion
    compartment_id = var.tenancy_ocid
    description = var.dataflow_users_group_description
    name = var.dataflow_users_group_name    
}

resource "oci_identity_policy" "dataflow_admin_policy" {
    provider = oci.homeregion
    compartment_id = var.tenancy_ocid
    description = var.dataflow_admins_policy_description
    name = var.dataflow_admins_policy_name
    statements = [
        "ALLOW GROUP ${var.dataflow_admins_group_name} TO READ buckets IN TENANCY",
        "ALLOW GROUP ${var.dataflow_admins_group_name} TO MANAGE dataflow-family IN TENANCY", 
        "ALLOW GROUP ${var.dataflow_admins_group_name} TO MANAGE objects IN TENANCY WHERE ALL {any {target.bucket.name='${oci_objectstorage_bucket.dataflow_warehouse.name}',target.bucket.name='${oci_objectstorage_bucket.dataflow_logs.name}'}, any {request.permission='OBJECT_CREATE', request.permission='OBJECT_INSPECT'}}",
        "ALLOW GROUP ${var.dataflow_admins_group_name} TO INSPECT tag-namespaces IN TENANCY",
        "ALLOW GROUP ${var.dataflow_admins_group_name} TO READ tag-namespaces IN TENANCY"]
}

resource "oci_identity_policy" "dataflow_user_policy" {
    provider = oci.homeregion
    compartment_id = var.tenancy_ocid
    description = var.dataflow_users_policy_description
    name = var.dataflow_users_policy_name
    statements = [
        "ALLOW GROUP ${var.dataflow_users_group_name} TO READ buckets IN TENANCY",
        "ALLOW GROUP ${var.dataflow_users_group_name} TO USE dataflow-family IN TENANCY",
        "ALLOW GROUP ${var.dataflow_users_group_name} TO MANAGE dataflow-family IN TENANCY WHERE ANY {request.user.id = target.user.id, request.permission = 'DATAFLOW_APPLICATION_CREATE', request.permission = 'DATAFLOW_RUN_CREATE'}",
        "ALLOW GROUP ${var.dataflow_users_group_name} TO INSPECT tag-namespaces IN TENANCY",
        "ALLOW GROUP ${var.dataflow_users_group_name} TO READ tag-namespaces IN TENANCY" ]
}