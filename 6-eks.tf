resource "aws_iam_role" "demo" {
    name = "eks-cluster-demo"
    tags = {
      tag-key= "eks-cluster-demo"
    }

    assume_role_policy = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "eks.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    POLICY
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.demo.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "demo" {
  name     = "demo"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.public-eu-north-1a.id,
      aws_subnet.public-eu-north-1b.id,
      aws_subnet.private-eu-north-1a.id,
      aws_subnet.private-eu-north-1b.id
    ]
    endpoint_public_access = true
    endpoint_private_access = true
  }

  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
  
}