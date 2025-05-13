# EC2用 IAM Roleの定義

#instance_prfileが参照するIAMを作成
resource "aws_iam_role" "ec2_role" {
    #AWS上での名称を入力
    name = "ec2-role"

    #IAMロールのディレクトリ分けのような機能
    #今回はデフォルトの/を使用
    path = "/"
    #EC2が他のリソースへ一時的にアクセスするassume_role_policyを設定
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    EOF
}
#aws_iam_instance_profileが参照するiam_roleを選択
resource "aws_iam_instance_profile" "ec2_profile" {
    #AWS上での名称を入力
    name = "ec2-profile"

    #aws_iam_roleで作成したIAM Roleを参照
    role = aws_iam_role.ec2_role.name
}