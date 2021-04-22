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

        stage('build') {
            steps {
                echo 'build'
                dir('mingle'){                    
                    sh 'script/build'
                }
            }
        }

	    stage('jruby unit tests') {
		    steps {
                echo 'tests'
                sh 'dropdb mingle_test; createdb mingle_test'
                dir('mingle'){
                    sh 'RAILS_ENV=test FAST_PREPARE=true rake db:migrate test:units --trace'
                }
		    }
	    }

        stage('Deploying') {
            steps {
                sshPublisher(
                    continueOnError: false, failOnError: true,
                    publishers: [
                        sshPublisherDesc(
                            configName: "Tomcat",
                            verbose: true,
                            transfers: [
                                sshTransfer(execCommand: ''' cp /root/tomcat/target/scala-2.13/gitbucket_2.13-4.35.3.war /opt/tomcat/webapps/
                                    cd /opt/tomcat/bin/
				                    ./shutdown.sh
				                    ./startup.sh''', sourceFiles: "**/*.war")]
                                )
                        ]
                    )
                }
            }
    }
}
