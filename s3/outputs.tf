output "bucket_name" {
  value = aws_s3_bucket.shankaz-bucket-demo.bucket
}

output "iam_role_name" {
  value = aws_iam_role.ec2-demo-role.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
}
