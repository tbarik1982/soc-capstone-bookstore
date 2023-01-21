# Capstone-bookstore
casestudy:



You have been Hired Sr. Devops Engineer in Abode Softwares. They want to implement Devops Lifecycle in their company. You have been asked to implement this lifecycle as fast as possible.

Abode Softwares is a product based company, their product is available on this github link.

But migrant GitHub link to azure repo
https://github.com/sog2-app/capstone-bookstore


Following are the specifications of the lifecycle:

1. Git Workflow has to be implemented
2. Code Build should automatically be triggered once commit is made to master branch or develop branch.

If commit is made to master branch, test and push to prod
If commit is made to develop branch, just test the product, do not push to prod


3. The Code should be containerized with the help of a Dockerfile.  The Dockerfile should be built everytime there is a push to azure repo. Use the following pre-built container for your application:
hshar/webapp

The code should reside in '/var/www/html'

4. Once the website is built, you have to design a test-case, which will basically check if the website can be opened or not. If yes, the test should pass. This test has to run in headless mode, on the test server.

5. Since you are setting up the server for the first time, ensure the following file exists on both Test and Prod server in /home/ubuntu/config-management/status.txt. This file will be used by a third party tool.

The content of this file, should be based on whether git is installed or not.

If git is installed => "Git is Installed on this System"
If git is not installed => "Git is not installed on this System"

For improving code readability, ensure you create modules on terraform-Master, to accomplish this task.

Architectural Advice:


1. Create required infra using terraform
2. Trigger jobs using azure devops pipeline.
3. Ensure application deployed in AKS cluster/azure app service plan



