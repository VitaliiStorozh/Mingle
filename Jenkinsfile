pipeline {
    agent { label 'jruby' }

    environment {
        PATH = "/root/.rbenv/shims:$PATH"
        }

    stages {
        stage('clone') {
            steps {
                git branch: 'master',
                credentialsId: 'gitlub-ssh-key',
                url: 'git@10.26.0.168:vitalii/mingle.git'
            }
        }

        stage('Build') {
            steps {
                echo 'build'
                dir('mingle'){                    
                    sh 'script/build'
                }
                echo 'Build SUCCESS'
            }
        }

	    stage('Units and Functionals Tests') {
            steps {
                echo 'Tests started!'
                sh 'dropdb mingle_test; createdb mingle_test'
                dir('mingle') {
                    script {
                        try {
                            sh 'RAILS_ENV=test FAST_PREPARE=true rake db:migrate test:units --trace'
                            } catch(err) {
                                echo "I have caught an error!"
                                echo err.getMessage()
                                }
                    }
                echo 'Tests SUCCESS'
                }
            }
        }

        stage('Deploying') {
            steps {
                sshPublisher(
                    continueOnError: false, failOnError: true,
                    publishers: [
                        sshPublisherDesc(
                            configName: "Docker",
                            verbose: true,
                            transfers: [
                                sshTransfer(execCommand: ''' cd /home/vitalii/
                                    git clone http://10.26.0.168:8081/vitalii/mingle_docker.git
                                    cd mingle_docker
                                    docker-compose stop
                                    docker rm -f $(docker ps -aq)
                                    docker rmi -f $(docker images -q)
				                    docker-compose up -d''')]
                                )
                        ]
                    )
                }
            }
    }
}
