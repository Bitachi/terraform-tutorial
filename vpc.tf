#VPC設定
#AWS上にVPCを構築

resource "aws_vpc" "vpc"{
    #cdir blockを設定
    cidr_block = "10.0.0.0/16"

    #タグを設定
    tags = {
        Name = "dev-vpc"
    }
}