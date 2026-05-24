terraform {

backend "s3" {

bucket="terraform-anay-state"

key="ec2/prod.tfstate"

region="ap-south-1"

dynamodb_table="terraform-lock"

}

}
