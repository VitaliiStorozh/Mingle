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

        /*stage('build & jruby unit tests') {
            steps {
                echo 'build'
                dir('mingle'){                    
                    sh 'script/build'
                    //sh 'java -version'
                    //sh 'ruby -v'
                    //sh 'whereis rake'
                    //sh 'bundle show rake'
                    //sh 'ENV PATH /root/.rbenv/bin:$PATH'
                    //sh 'dropdb mingle_test; createdb mingle_test'
                    //sh 'source /root/.bash_profile'
                    //sh 'rake --version'
                    //sh 'RAILS_ENV=test FAST_PREPARE=true rake db:migrate test:units --trace'
                }
                echo 'Tests SUCCESS'
            }
        }*/

	    stage('jruby unit tests') {
            steps {
                echo 'tes1ts'
                sh 'dropdb mingle_test; createdb mingle_test'
                //sh 'export PATH=$PATH:$HOME/bin:/var/lib/gems/1.8/bin'
                //sh 'whereis rake'
                dir('mingle') {
                    //sh 'rbenv global 3.0.1'
                    //sh 'gem install rake'
                    sh '''#!/bin/bash
                        echo "Who I'm $SHELL"
                        RAILS_ENV=test
                        FAST_PREPARE=true
                        rake db:migrate test:units --trace
                    '''
                }
                echo 'Tests SUCCESS'
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
                                sshTransfer(execCommand: ''' cd /home/vitalii/docker_projects/
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
