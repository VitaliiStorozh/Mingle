pipeline {
    agent { label 'jruby' }

    stages {
        stage('clone') {
            steps {
                git branch: 'master',
                credentialsId: 'gitlub-ssh-key',
                url: 'git@10.26.0.168:vitalii/mingle.git'
            }
        }

        stage('build & jruby unit tests') {
            steps {
                echo 'build'
                dir('mingle'){                    
                    sh 'script/build'
                }
                echo 'Tests SUCCESS'
            }
        }

	    /*stage('jruby unit tests') {
            steps {
                echo 'tests'
                sh 'dropdb mingle_test; createdb mingle_test'
                dir('mingle'){
                    sh 'RAILS_ENV=test FAST_PREPARE=true rake db:migrate test:units --trace'
                }
                echo 'Tests SUCCESS'
            }
        }*/

        stage('Deploying') {
            steps {
                sshPublisher(
                    continueOnError: false, failOnError: true,
                    publishers: [
                        sshPublisherDesc(
                            configName: "Docker",
                            verbose: true,
                            transfers: [
                                sshTransfer(execCommand: ''' cd /home/vitalii/docker_projects/
				                    docker-compose up -d''')]
                                )
                        ]
                    )
                }
            }
    }
}
