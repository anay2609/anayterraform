terraform {

backend "gcs" {

bucket = "terraform-gcp-state-anay"

prefix = "terraform"

}

}
