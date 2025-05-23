#インターネットゲートウェイ

#VPCインターネットゲートウェイを作成
resource "aws_internet_gateway" "igw" {
    #作成するVPC IDを設定
    vpc_id = aws_vpc.vpc.id

    #タグを設定
    tags = {
        Name = "igw"
    }
}

#NATゲートウェイ

#VPC NATゲートウェイを作成
resource "aws_nat_gateway" "ngw_pub_a" {
    #NATゲートウェイに関連づけるElastic IP Addressの割り当てID
    allocation_id = aws_eip.ngw_pub_a.id

    #NATゲートウェイを配置するサブネットのサブネットID
    subnet_id = aws_subnet.public_a.id

    #タグを設定
    tags = {
        Name = "ngw-pub-a"
    }
}