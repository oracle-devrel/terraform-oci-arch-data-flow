#!/usr/bin/env python3

import os
import sys

from pyspark import SparkConf
from pyspark.sql import SparkSession, SQLContext
import pyspark.sql.functions as F
from pyspark.sql.functions import isnan, when, count, col
from functools import reduce


def main():

    # The first argument will be the input path.
    INPUT_PATH = sys.argv[1]
    pre, ext = os.path.splitext(INPUT_PATH)

    OUTPUT_PATH = pre + ".parquet"

    # Set up Spark.
    spark_session = get_dataflow_spark_session()
    sql_context = SQLContext(spark_session)

    # Load our data.
    input_dataframe = (
        sql_context.read.option("header", "true")
        .option("multiLine", "true")
        .csv(INPUT_PATH)
    )

    print("\nCount of the missing values in each column:")
    result = input_dataframe.select(
        [count(when(col(c).isNull(), c)).alias(c) for c in input_dataframe.columns]
    )
    print(result.show())

    input_dataframe = input_dataframe.fillna(
        {"director": "No Director", "cast": "No Cast", "country": "Country Unavailable"}
    )
    input_dataframe = input_dataframe.dropna(subset=["date_added", "rating"])

    # Check if missing values are present after cleanup
    print("\nCheck if missing values are present after cleanup....")

    result = input_dataframe.select(
        [count(when(col(c).isNull(), c)).alias(c) for c in input_dataframe.columns]
    )
    print(result.show())

    # Save the results as Parquet.
    input_dataframe.write.mode("overwrite").parquet(OUTPUT_PATH)

    print("\nDone writing Parquet at location " + OUTPUT_PATH)


def get_dataflow_spark_session(
    app_name="DataFlow", file_location=None, profile_name=None, spark_config={}
):
    """
    Get a Spark session in a way that supports running locally or in Data Flow.
    """
    if in_dataflow():
        spark_builder = SparkSession.builder.appName(app_name)
    else:
        # Import OCI.
        try:
            import oci
        except:
            raise Exception(
                "You need to install the OCI python library to test locally"
            )

        # Use defaults for anything unset.
        if file_location is None:
            file_location = oci.config.DEFAULT_LOCATION
        if profile_name is None:
            profile_name = oci.config.DEFAULT_PROFILE

        # Load the config file.
        try:
            oci_config = oci.config.from_file(
                file_location=file_location, profile_name=profile_name
            )
        except Exception as e:
            print("You need to set up your OCI config properly to run locally")
            raise e
        conf = SparkConf()
        conf.set("fs.oci.client.auth.tenantId", oci_config["tenancy"])
        conf.set("fs.oci.client.auth.userId", oci_config["user"])
        conf.set("fs.oci.client.auth.fingerprint", oci_config["fingerprint"])
        conf.set("fs.oci.client.auth.pemfilepath", oci_config["key_file"])
        conf.set(
            "fs.oci.client.hostname",
            "https://objectstorage.{0}.oraclecloud.com".format(oci_config["region"]),
        )
        spark_builder = SparkSession.builder.appName(app_name).config(conf=conf)

    # Add in extra configuration.
    for key, val in spark_config.items():
        spark_builder.config(key, val)

    # Create the Spark session.
    session = spark_builder.getOrCreate()
    return session


def in_dataflow():
    """
    Determine if we are running in OCI Data Flow by checking the environment.
    """
    if os.environ.get("HOME") == "/home/dataflow":
        return True
    return False


if __name__ == "__main__":
    main()