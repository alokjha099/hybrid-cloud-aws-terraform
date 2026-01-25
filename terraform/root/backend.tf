terraform {
  backend "s3" {
    bucket = "s3-terraform-state-file-bucket-12312"
    key    = "CloudMigration.tfstate"
    region = "ap-south-1"
    dynamodb_table = "alok-youtube-tf-table"
  }
}


