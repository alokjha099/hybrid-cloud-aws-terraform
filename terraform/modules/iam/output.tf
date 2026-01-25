
output "instance_profile_name" {
  description = "EC2 instance profile name for ASG launch template"
  value = aws_iam_instance_profile.ec2_profile.name
}
