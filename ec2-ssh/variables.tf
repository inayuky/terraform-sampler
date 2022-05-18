# 鍵の名前
# 秘密鍵ファイル名に相当する名前
variable "key_name" {
  type    = string
  default = "ec2_key"
}

# リソース名
# 他のリソースと区別するため設定する
# 簡単のため共通の名前を使用する
variable "resouce_name" {
  type    = string
  default = "sample1"
}
