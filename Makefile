.PHONY: build deploy docker
SHELL := /bin/bash
.ONESHELL:

build:
	@echo "Build Application"
	chmod +x gradlew
	./gradlew war

deploy:
	@echo "Deploy Application"
	@echo "Copy the war file to S3"
	aws s3 cp build/libs/*.war s3://$(s3_bucket)/
	@echo "Deploy the application using SSM Run Command"
	aws ssm send-command \
		--document-name "AWS-RunShellScript" \
		--instance-ids "$(instance_id)" \
		--parameters 'commands=["aws s3 cp s3://$(s3_bucket)/helloworld.war /tmp/app.war", "sudo mv /tmp/app.war /webserver/tomcat/webapps/"]' \
		--comment "Deploying application to EC2 instances"
