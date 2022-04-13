Problem startement

You need to develop and deploy a python app that writes a new file to S3 on every execution.
These files need to be maintained only for 24h.
The content of the file is not important, but add the date and time as prefix for your file name.
The name of the buckets should be the following ones for QA and Staging respectively:
qa-FIRSTNAME-LASTNAME-platform-challenge
staging-FIRSTNAME-LASTNAME-platform-challenge
The app will be running as a docker container in a Kubernetes cluster every 5 minutes. There is
a Namespace for QA and a different Namespace for Staging in the cluster. You don’t need to
provide tests but you need to be sure the app will work.

Solution

1. Setup Infra
cd terraform
terraform init
export TF_VAR_cluser_name="some_name"
terraform apply -auto-approve

2. Deploy CronJob
cd kubernetes
helmfile -f app.yaml sync
