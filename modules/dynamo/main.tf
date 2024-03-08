resource "aws_dynamodb_table" "dynamo_table" {
    count  = 2
  name           = var.table_name[count.index]
  billing_mode   = "PAY_PER_REQUEST"

#   hash key is a primary key
  hash_key       = var.hash_key
  attribute {
    name = var.hash_key
    type = var.hash_key_type
    }

  tags = {
    Name        = var.table_name[count.index]
  }
}

resource "aws_dynamodb_table" "dynamo_table_auth" {
  name           = "dynamo_table_auth"
  billing_mode   = "PAY_PER_REQUEST"

#   hash key is a primary key
  hash_key       = var.hash_key
  attribute {
    name = var.hash_key
    type = var.hash_key_type
    }

  tags = {
    Name        = "dynamo_table_auth"
  }
}

