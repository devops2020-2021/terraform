provider"aws"{
        region="us-east-2"
        access_key="AKIAZT7N25P22S5WO5MM"
        secret_key="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"
}

resource"aws_iam_user""sshan_user"{
        name="sshan"
}

resource"aws_iam_group""group"{
        name="S3group"
}

resource"aws_iam_group_membership""team"{
        name="S3group-membership"

        users=[
          aws_iam_user.sshan_user.name,
        ]

        group=aws_iam_group.group.name
}

resource"aws_s3_bucket""s"{
        bucket="ssv-bucket"
}

resource "aws_iam_policy" "s3_policy"{
        name = "s3_policy"

        policy = <<EOF
{
          "version": "2021-08-06",
          "Statement": [
          {
                "Action": "s3:*",
                "Effect": "Allow",
                "Resource": "arn:aws:s3:::ssv-bucket"
          }
         ]
        }
        EOF
}

resource"aws_iam_group_policy_attachment""s3_attachment"{
        group = aws_iam_group.group.name
        policy_arn = aws_iam_policy.s3_policy.arn
}
