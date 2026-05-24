pipeline {

agent any

parameters {

choice(

name:'ACTION',

choices:['APPLY','DESTROY'],

description:'Terraform operation'

)

}

environment {

AWS_ACCESS_KEY_ID = credentials('aws-creds')

AWS_SECRET_ACCESS_KEY = credentials('aws-creds')

}

stages {

stage('Checkout') {

steps {

git branch:'main',

url:'https://github.com/anay2609/anayterraform.git'

}

}

stage('Terraform Init') {

steps {

sh 'terraform init'

}

}

stage('Validate') {

steps {

sh 'terraform validate'

}

}

stage('Plan') {

when {

expression {

params.ACTION=="APPLY"

}

}

steps {

sh 'terraform plan'

}

}

stage('Apply') {

when {

expression {

params.ACTION=="APPLY"

}

}

steps {

input "Proceed?"

sh 'terraform apply -auto-approve'

}

}

stage('Destroy') {

when {

expression {

params.ACTION=="DESTROY"

}

}

steps {

input "Destroy infrastructure?"

sh 'terraform destroy -auto-approve'

}

}

}

}
