pipeline {

agent any

environment {

AWS_ACCESS_KEY_ID = credentials('aws-creds')

}

stages {

stage('Terraform Init') {

steps {

sh '''
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_USR

export AWS_SECRET_ACCESS_KEY=$AWS_ACCESS_KEY_ID_PSW

terraform init
'''

}

}

stage('Validate') {

steps {

sh 'terraform validate'

}

}

stage('Plan') {

steps {

sh '''
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_USR

export AWS_SECRET_ACCESS_KEY=$AWS_ACCESS_KEY_ID_PSW

terraform plan
'''

}

}

stage('Apply') {

steps {

input "Deploy?"

sh '''
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_USR

export AWS_SECRET_ACCESS_KEY=$AWS_ACCESS_KEY_ID_PSW

terraform apply -auto-approve
'''

}

}

}

}
