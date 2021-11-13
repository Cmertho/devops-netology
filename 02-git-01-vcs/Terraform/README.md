Благодаря файлу .gitignore будут проигнорировано следующее


1. все файлы в каталоге .terraform
2. все файлы заканчивающиеся расширением .tfstate 
3. все файлы называющиеся crash.log
4. все файлы с расширением .tfvars
5. файлы которые называются override.tf и override.tf.json, а так же файлы которые заканчиваются на _override.tf.json и _override.tf
6. так же файлы .terraformrc и terraform.rc