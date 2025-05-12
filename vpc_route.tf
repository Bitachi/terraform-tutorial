#Public Subnet用 Route Table
resource "aws_route_table" "public_a" {
    #ルートテーブルを構築するVPCのIDを設定
    vpc_id = aws_vpc.vpc.id

    #通信経路の設定
    #vpc_gw.ifにて記述したigwを使用
    #このigwを経由したすべてのIPv4をルーティング
    route {
        gateway_id = aws_internet_gateway.igw.id
        cidr_block = "0.0.0.0/0"
    }

    #タグを設定
    tags = {
        Name = "rtb-pub-a"
    }
}

#パブリックサブネットとルートテーブルを紐付け
resource "aws_route_table_association" "public_a" {
    #紐付けたいサブネットのIDを設定
    #vpc_subnet.tfにて記述したパブリックサブネットのIDを設定
    subnet_id = aws_subnet.public_a.id

    #用意したルートテーブルのIDを設定
    route_table_id = aws_route_table.public_a.id
}


#Pribate Subnet用Route Table

#プライベートサブネット用のルートテーブルを定義
resource "aws_route_table" "private_a" {

    #ルートテーブルを構築するVPCのIDを設定
    vpc_id = aws_vpc.vpc.id

    #通信経路の設定
    #vpc_gw.tfにて記述したNATゲートウェイを利用
    #このNATゲートウェイを経由するすべてのIPv4をルーティング
    route {
        nat_gateway_id = aws_nat_gateway.ngw_pub_a.id
        cidr_block = "0.0.0.0/0"
    }

    #タグを設定
    tags = {
        Name = "rtb-priv-a"
    }
}
#プライベートサブネットとルートテーブルを紐付け
resource "aws_route_table_association" "private_a" {
    #紐付けたいサブネットのIDを設定
    #vpc_subnet_tfにて記述したプライベートサブネットのIDを設定
    subnet_id = aws_subnet.private_a.id

    #用意したルートテーブルのIDを設定
    route_table_id = aws_route_table.private_a.id
}