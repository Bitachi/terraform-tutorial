#Webサーバー用 公開鍵設定

data "template_file" "ssh_key" {
    #ローカルに存在するWebサーバ用の公開鍵を読み込み
    template = file("~/.ssh/id_rsa.pub")
}

#EC2キーペアリソースを設定
resource "aws_key_pair" "auth" {
    #Webサーバ用のキーペアを定義
    key_name = "id_rsa.pub"

    # template_fileのWebサーバ用の公開鍵を設定
    public_key = data.template_file.ssh_key.rendered
}