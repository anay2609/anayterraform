terraform {

required_providers {

google = {

source = "hashicorp/google"

version = "~> 5.0"

}

}

}

provider "google" {

credentials = file("terraform-gcp.json")

project = var.project

region = var.region

zone = var.zone

}
