#Webサーバー設定

#同ディレクトリ内のweb.sh.tlをterraformで扱えるようdata化
data "template_file" "web_shell"{
    template = file("${path.module}/web.sh.tpl")
}

#Webサーバの構築
resource "aws_instance" "web" {
    #[ami.tf]のamiを参照
    ami = data.aws_ami.amzn2.id

    #インスタンスタイプ
    instance_type = "t2.micro"

    #keypair.tfの鍵を参照
    key_name = aws_key_pair.auth.id

    #iam.tfのプロファイルを参照
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

    #vpc_subnet.tfを参照
    subnet_id = aws_subnet.public_a.id

    #vpc_sg.tfを参照
    vpc_security_group_ids = [aws_security_group.pub_a.id]

    #EBSのパラメータを設定
    root_block_device {
        #ボリュームの種類としてgp2を設定
        volume_type = "gp2"

        #ボリュームの容量を設定
        #単位はGiB
        volume_size = 8

        #インスタンス削除時にボリュームを合わせて削除
        delete_on_termination = true
    }

    #タグを設定
    tags = {
        Name = "web-instance"
    }

    #初めにdata化したweb.sh.tplを参照
    user_data = base64encode(data.template_file.web_shell.rendered)
}

######################################################################
# APサーバー設定
######################################################################

#同ディレクトリ内のweb.sh.tlをterraformで扱えるようdata化
data "template_file" "ap_shell"{
    template = file("${path.module}/ap.sh.tpl")
}

#APサーバの構築
resource "aws_instance" "ap" {
    #[ami.tf]のamiを参照
    ami = data.aws_ami.amzn2.id

    #インスタンスタイプ
    instance_type = "t2.micro"

    #keypair.tfの鍵を参照
    key_name = aws_key_pair.auth_priv.id

    #iam.tfのプロファイルを参照
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

    #vpc_subnet.tfを参照
    subnet_id = aws_subnet.private_a.id

    #vpc_sg.tfを参照
    vpc_security_group_ids = [aws_security_group.priv_a.id]

    #EBSのパラメータを設定
    root_block_device {
        #ボリュームの種類としてgp2を設定
        volume_type = "gp2"

        #ボリュームの容量を設定
        #単位はGiB
        volume_size = 8

        #インスタンス削除時にボリュームを合わせて削除
        delete_on_termination = true
    }

    #タグを設定
    tags = {
        Name = "ap-instance"
    }

    #初めにdata化したap.sh.tplを参照
    user_data = base64encode(data.template_file.ap_shell.rendered)
}