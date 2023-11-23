resource "aws_iam_role" "node-role" {
  name = "${var.prefix}-${var.cluster_name}-node-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  role = aws_iam_role.node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  role = aws_iam_role.node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  role = aws_iam_role.node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_eks_node_group" "node-group-1" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = "${var.prefix}-${var.cluster_name}-node-group-1"
  node_role_arn = aws_iam_role.node-role.arn
  subnet_ids = aws_subnet.subnets[*].id
  instance_types = [ "t3.medium" ]

  scaling_config {
    desired_size = var.desired_size
    max_size = var.max_size
    min_size = var.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy
  ]
}

resource "aws_eks_node_group" "node-group-2" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = "${var.prefix}-${var.cluster_name}-node-group-2"
  node_role_arn = aws_iam_role.node-role.arn
  subnet_ids = aws_subnet.subnets[*].id
  instance_types = [ "t3.micro" ]

  scaling_config {
    desired_size = var.desired_size
    max_size = var.max_size
    min_size = var.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy
  ]
}