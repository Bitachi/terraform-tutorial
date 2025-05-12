#Webサーバが端末のグローバルIPからSSH/SFTPとHTTPを受け入れるSG設定

#WebサーバがSSHとHTTPを受け入れるSGの設定
resource "aws_security_group" "pub_a" {
    #セキュリティグループ名を設定
    name = "sg_pub_a"

    #セキュリティグループを構築するVPCのIDを設定
    vpc_id = aws_vpc.vpc.id

    #タグを設定
    tags = {
        Name = "sg-pub-a"
    }
}

#Webサーバから出ていく通信の設定
resource "aws_security_group_rule" "egress_pub_a" {
    #このリソースが通信を受け入れる設定であることを定義
    type = "egress"

    #ポートの範囲設定
    #すべてのトラフィックを許可
    from_port = 0
    to_port = 0

    #プロトコル設定
    #以下はすべてのIPv4トラフィックを許容する
    protocol = "-1"

    #許可するIPの範囲
    #すべてのIPv4トラフィックを許容する
    cidr_blocks = ["0.0.0.0/0"]

    #このルールを付与するセキュリティグループを設定
    security_group_id = aws_security_group.pub_a.id
}

#SSH/SFTPを受け入れる設定
resource "aws_security_group_rule" "ingress_pub_a_22" {
    #このリソースが通信を受け入れる設定であることを定義
    #ingressを設定
    type = "ingress"

    #ポートの公開範囲
    from_port = 22
    to_port = 22
    #プロトコルはTCP
    protocol = "tcp"

    #許可するIPの範囲を設定
    #自身のグローバルIPを記入
    cidr_blocks = ["133.32.130.0/32"]

    #このルールを付与するセキュリティグループを設定
    security_group_id = aws_security_group.pub_a.id
}

#HTTPを受け入れる設定
resource "aws_security_group_rule" "ingress_pub_a_80" {
    #このルールが通信を受け入れる設定であることを定義
    #ingressを設定
    type = "ingress"

    #ポートの範囲設定
    from_port = 80
    to_port = 80

    #プロトコルはtcpを設定
    protocol = "tcp"

    #許可するIPの範囲を設定
    #自身のグローバルIPを記入
    cidr_blocks = ["133.32.130.0/32"]

    #このルールを付与するセキュリティグループを設定
    security_group_id = aws_security_group.pub_a.id
}

#APサーバがWebサーバからVPC内ぶIPを利用しSSHを受け入れるSG設定
#APサーバがWebサーバからSSHを受け入れるSGの設定
resource "aws_security_group" "priv_a" {
    #セキュリティグループ名を設定
    name = "sg_priv_a"

    #セキュリティグループを構築するVPCのIDを設定
    vpc_id = aws_vpc.vpc.id

    #タグを設定
    tags = {
        Name = "sg-priv-a"
    }
}

#出ていく通信の設定
resource "aws_security_group_rule" "egress_priv_a" {
    #このリソースが通信を受け入れる設定であることを定義
    type = "egress"

    #ポートの範囲設定
    #すべてのトラフィックを許可
    from_port = 0
    to_port = 0

    #プロトコル設定
    #以下はすべてのIPv4トラフィックを許容する
    protocol = "-1"

    #許可するIPの範囲
    #すべてのIPv4トラフィックを許容する
    cidr_blocks = ["0.0.0.0/0"]

    #このルールを付与するセキュリティグループを設定
    security_group_id = aws_security_group.priv_a.id
}

#SSHを受け入れる設定
resource "aws_security_group_rule" "ingress_priv_a_22" {
    #このリソースが通信を受け入れる設定であることを定義
    #ingressを設定
    type = "ingress"

    #ポートの公開範囲
    from_port = 22
    to_port = 22
    #プロトコルはTCP
    protocol = "tcp"

    #許可するIPの範囲を設定
    #Webサーバを配置しているサブネットのCIDRを指定
    #cidr_blocks = ["10.0.1.0/24"]
    cidr_blocks = [aws_subnet.public_a.cidr_block]

    #このルールを付与するセキュリティグループを設定
    security_group_id = aws_security_group.priv_a.id
}