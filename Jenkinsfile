pipeline {

    agent any

    environment {

        AWS_ACCESS_KEY_ID = credentials('aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')

    }

    stages {

        stage('Checkout') {

            steps {

                git branch: 'main',
                url:'https://github.com/anay2609/anayterraform.git'

            }

        }

        stage('Terraform Init') {

            steps {

                sh '''
                terraform init
                '''

            }

        }

        stage('Validate') {

            steps {

                sh '''
                terraform validate
                '''

            }

        }

        stage('Plan') {

            steps {

                sh '''
                terraform plan
                '''

            }

        }

        stage('Apply') {

            steps {

                sh '''
                terraform apply -auto-approve
                '''

            }

        }

    }

}
