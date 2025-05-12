#AMIの設定

#AMIのデータソースを"amzn2"という名称で作成　
data "aws_ami" "amzn2" {
    #複数の結果が返された場合、最新のAMIを使用
    most_recent = true

    #検索を制限するAMI所有者のリスト
    #今回はAmazon公式が配布しているAMIを指定
    owners = ["amazon"]

    #一つ以上のname, valuesのペアで検索条件を設定
    filter {
        #検索する属性を選択
        #AWSで公開されているイメージの名称からfilter
        name = "name"

        #イメージ名称のうち、以下にマッチするものを抽出
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]

    }
}