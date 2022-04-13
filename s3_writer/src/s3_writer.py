import boto3
import os
import argparse
from datetime import *

parser = argparse.ArgumentParser()
parser.add_argument('--bucket', action='store', type=str, required=True)
args = parser.parse_args()

s3_bucket=args.bucket
timestamp=datetime.today().strftime("%Y%m%d_%H%M%S")
file=f"file_{timestamp}"

s3 = boto3.client('s3')

try:
    s3.put_object(Bucket=s3_bucket,Key=file)
    print(f"file {file} has uploaded to bucket {s3_bucket} successfully")
except Exception as error:
    print(f"Failed to upload file {file}.. {error}")

