#EIP (Elastic IP)の設定

#EIPを"ngw-pub-a"という名称で作成
resource "aws_eip" "ngw_pub_a" {
    #EIPがVPCにあるかどうか
    vpc = true

    #タグを設定
    tags = {
        Name = "ngw_pub_a"
    }

}