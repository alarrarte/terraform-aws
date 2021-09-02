# We create 3 users
resource "aws_iam_user" "user1" {
  name = "user1"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_user" "user2" {
  name = "user2"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_user" "user3" {
  name = "user3"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

# We create 3 groups
resource "aws_iam_group" "S3-Support" {
  name = "S3-Support"
}

resource "aws_iam_group" "EC2-Support" {
  name = "EC2-Support"
}

resource "aws_iam_group" "EC2-Admin" {
  name = "EC2-Admin"

}



# We add users to groups


resource "aws_iam_group_membership" "gm-S3-Support" {
  name = "gm-S3-Support"

  users = [
    aws_iam_user.user1.name,
  ]

  group = aws_iam_group.S3-Support.name
}


resource "aws_iam_group_membership" "gm-EC2-Support" {
  name = "gm-S3-Support"

  users = [
    aws_iam_user.user2.name,
  ]

  group = aws_iam_group.EC2-Support.name
}

resource "aws_iam_group_membership" "gm-EC2-Admin" {
  name = "gm-S3-Support"

  users = [
    aws_iam_user.user3.name,
  ]

  group = aws_iam_group.EC2-Admin.name
}