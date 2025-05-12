#サブネット設定
#Webサーバ用Public Subnet
resource "aws_subnet" "public_a"{
    #VPCを指定
    vpc_id = aws_vpc.vpc.id
    
    #cdir blockを設定
    cidr_block = "10.0.1.0/24"

    availability_zone = "ap-northeast-1a"

    #このSubnetで起動したEC2インスタンスにパブリックIPを割り当てる
    map_public_ip_on_launch = true

    #タグを設定
    tags = {
        Name = "pub-a"
    }
}

#APサーバ用Private Subnet
resource "aws_subnet" "private_a" {
    #VPCを指定
    vpc_id = aws_vpc.vpc.id
    
    #cdir blockを設定
    cidr_block = "10.0.2.0/24"

    availability_zone = "ap-northeast-1a"

    #タグを設定
    tags = {
        Name = "priv-a"
    }
}