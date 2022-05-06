# terraform-oci-arch-data-flow

Your data resides in different clouds, such as Amazon Web Services S3 or Azure Blob Storage, but you want to analyze it from a common analysis platform. Oracle Cloud Infrastructure Data Flow is a fully managed Spark service that lets you develop and run big data analytics, regardless of where your data resides, without having to deploy or manage a big data cluster. 

These terraform scripts deploy an OCI Data Flow application environment, together with IAM policies and Object Storage buckets.
You can choose to deploy a demo Python Spark application which is described later.

## Terraform Provider for Oracle Cloud Infrastructure
The OCI Terraform Provider is now available for automatic download through the Terraform Provider Registry. 
For more information on how to get started view the [documentation](https://www.terraform.io/docs/providers/oci/index.html) 
and [setup guide](https://www.terraform.io/docs/providers/oci/guides/version-3-upgrade.html).

* [Documentation](https://www.terraform.io/docs/providers/oci/index.html)
* [OCI forums](https://cloudcustomerconnect.oracle.com/resources/9c8fa8f96f/summary)
* [Github issues](https://github.com/terraform-providers/terraform-provider-oci/issues)
* [Troubleshooting](https://www.terraform.io/docs/providers/oci/guides/guides/troubleshooting.html)

## Clone the Module
Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/oracle-devrel/oci-arch-data-flow.git
    cd terraform-oci-arch-data-flow
    ls

## Prerequisites
First off, you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

Secondly, create a `terraform.tfvars` file and populate with the following information:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# Region
region = "<oci_region>"

# Compartment
compartment_ocid = "<compartment_ocid>"

```

For your convenience, there is a template file included.

Deploy:

    terraform init
    terraform plan
    terraform apply

## Destroy the Deployment

When you no longer need the deployment, you can run this command to destroy it:

    terraform destroy

## Demo application

In this Terraform stack, you can choose to deploy the demo Python Spark application which is part of the Oracle LiveLab [_Sample Python Application with OCI Data Flow_](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=844). For this purpose, keep the variable `deploy_demo_application` as `true`.  
The application in question is used to read a sample CSV file from Object Storage, clean the data and save it in Parquet format to Object Storage.

## Architecture

![](./images/oci-dataflow-architecture.png)


## Reference Architecture

- [Analyze data from external object storage sources using Oracle Cloud Infrastructure Data Flow](https://docs.oracle.com/en/solutions/oci-big-data-flow/)
