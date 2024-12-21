resource "aws_dynamodb_table" "bookinventory" {
  name         = "harris-bookinventory"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ISBN"
  range_key    = "Genre"

  attribute {
    name = "ISBN"
    type = "S"
  }

  attribute {
    name = "Genre"
    type = "S"
  }

  tags = {
    Name        = "harris-bookinventory"
  }
}

data "aws_dynamodb_table" "bookinventory" {
  name = aws_dynamodb_table.bookinventory.name
}

output "dynamodb_table_id" {
  value = data.aws_dynamodb_table.bookinventory.id
}