resource"aws_s3_bucket""s"{
        bucket="1fin-bucket"
}

resource "aws_s3_bucket_policy""bp"{
       bucket= aws_s3_bucket.s.id

       policy = <<EOF
{
       "version": "2021-08-06",
       "Statement": [
       {
           "Sid": "AllowIPmix",
           "Effect": "Allow",
           "Principal": "*",
           "Action": "s3:*",
           "Resource": "arn:aws:s3:::1fin-bucket/*"
       }
      ]
}
EOF

}

