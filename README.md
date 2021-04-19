# Deploy Python Flask API to AWS Using Open Source Tools
---

In this post, we will demonstrate how to build and deploy an API running in a microservice architecture. 
The project we will create addresses how to build and deploy an API to the AWS Cloud. Specifically, we will deploy a Python Flask REST API that will allow users to post their favorite artists and songs from the 90’s to DynamoDB. We will containerize our Flask application and deploy it to Elastic Container Service (ECS). In addition to explaining how to configure an API, we will cover how to automate the deployment of AWS Services using Terraform. We will also walk through some basic testing of the API we create using SOAP API. 

# Motivation
---

Data has become the language of business. Organizations leverage data to better understand and deliver value to their Customers. As a result, there is a growing need in many Organizations for flexible patterns that can be leveraged to develop new applications and functionality to interact with their data. APIs, or Application Program Interfaces, are a utility which can help to enable organizations to continuously deliver customer value. API’s have grown in popularity as organizations have been increasingly designing their applications as microservices. The microservice model configures an application as a suite of small services. Each service runs its own processes and is independently deployable. API’s work in conjunction with microservices as they can be leveraged to connect services together, provide a programmable interface for developers to access data, and provide connectivity to existing legacy systems. 

# AWS Services Used
---

Let’s review the AWS services we are deploying with this project.

*VPC* - [Amazon Virtual Private Cloud](https://aws.amazon.com/vpc/?vpc-blogs.sort-by=item.additionalFields.createdDate&vpc-blogs.sort-order=desc) (Amazon VPC) is a service that lets you launch AWS resources in a logically isolated virtual network that you define.  Terraform creates a VPC containing an Internet gateway, two public subnets, two private subnets, routes, and a NAT gateway.  This allows for a secure networking implementation for the service environment.    

*EC2* - [Amazon Elastic Compute Cloud](https://aws.amazon.com/ec2/?ec2-whats-new.sort-by=item.additionalFields.postDateTime&ec2-whats-new.sort-order=desc) (Amazon EC2) is a web service that provides secure, resizable compute capacity in the cloud.  ECS is used to provide instances running in an autoscaling group (ASG) for the ECS cluster.  This allows the cluster to respond to scaling rulesets designed to allow the cluster to ‘grow’ or ‘shrink’ based on workload demands.

*ECS* - [Amazon Elastic Container Service](https://aws.amazon.com/ecs/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc&ecs-blogs.sort-by=item.additionalFields.createdDate&ecs-blogs.sort-order=desc) (Amazon ECS) allows you to easily run, scale, and secure Docker container applications on AWS.  ECS is used to provide an ECS cluster to run the service.  The service is created and managed through an ECS task definition.  The task definition describes the service configuration for the containers hosting the service.  

*ECR* - [Amazon Elastic Container Registry](https://aws.amazon.com/ecr/) (Amazon ECR) is an AWS managed container image registry service that is secure, scalable, and reliable.  ECR is used to store the container image pushed from Docker.  The ECS task definition references this image URL to deliver the service.

*ALB -* [Application Load Balancer](https://aws.amazon.com/elasticloadbalancing/application-load-balancer/) (ALB) is an Elastic Load Balancer which provides layer 7 content based traffic routing to targets in AWS.  The ALB is configured through Terraform to target the ASG and provides health monitoring for the service endpoint.

*DynamoDB* - [Amazon DynamoDB](https://aws.amazon.com/dynamodb/) (Amazon DynamoDB) is a key-value and document database that delivers single-digit millisecond performance at any scale.  A DynamoDB table is created by Terraform as a backend for the delivered API.  API requests can read or write to the DynamoDB table to illustrate an application data flow and operational functionality for a running service.

*CloudWatch* - [Amazon CloudWatch](https://aws.amazon.com/cloudwatch/) (Amazon CloudWatch) is a monitoring and observability service built for DevOps engineers, developers, site reliability engineers (SREs), and IT managers to provide data and actionable insights to monitor your applications, respond to system-wide performance changes, optimize resource utilization, and get a unified view of operational health.  Scaling rulesets provisioned by Terraform are referenced for autoscaling purposes.  Alert metrics provide threshold based triggers to scale the autoscaling groups as needed to meet workload demands. 

# How To Use?
---

To deploy this project, follow the step by step instructions found here.
## Terraform ECS Cluster with Autoscaling Group
---

This Terraform template is designed to define a set of specific modules that will perform the following tasks:

- Define the desired state configuration for security, resources, and configurations for delivering defined elements using Infrastructure as Code concepts
- Separate security configurations, cluster configurations, and bootstrapping processes into source control managed definitions making them reusable, defined, and flexible
- Provide a functional process whereby an ECS cluster with these defined dependencies can be effectively leveraged and quickly delivered

## Dependencies
---

This module has dependencies or requirements in order to successfully deliver the desired state.  These dependencies include the following:

- An AWS account is required
- An execution role or IAM key is required for authentication with the AWS account
- An Elastic Container Repository containing the reference image
## Summary
---

This module is designed to provide a comprehensive deployment solution for ECS including the following component configurations:

- Virtual Private Cloud - public and private subnets, routes, and a NAT gateway
- Elastic Compute Cloud - autoscaling configuration
- Elastic Container Service - cluster configuration
- Elastic Container Service - task definition
- Application Load Balancer - load balancer configuration
- Amazon DynamoDB - table configuration
- Amazon Cloudwatch - alert metrics defined

**Please read the rest of this document prior to leveraging this Terraform template for platform delivery.**

# Index
---

[Usage](#usage)
[Variables](#variables)

## Provider Dependencies
---

This Terraform code was tested on Terraform 0.14.7 using AWS provider 3.30.0.    

## Usage
---
### Pre-Deployment Testing and Validation
---
In order to evaluate the modules for syntax issues and validate the modules for consistency with the style guide, the following tasks are recommended prior to deploying from this template into an environment:

#### Run a Terraform FMT
---
Terraform *FMT* is used to check the formatting of a Terraform file to ensure that it meets suggested formatting according to the Terraform style guide.  By default, Terraform *FMT* will rewrite Terraform configuration files to meet the style guide.  

To run a Terraform *FMT* check, run the following command from the root module directory:  ***"terraform fmt -recursive"***

If you do not wish Terraform to overwite any files on execution, run the command with the following switches: ***"terraform fmt -check -recursive"***

See the link here for more information: [Terraform FMT](https://www.terraform.io/docs/commands/fmt.html)

---
#### Run a Terraform Validate
---

Terraform validate is used to validate that Terraform configuration files in a module are syntactically correct, referantially consistent, and consistently parameterized.  The Terraform validate command is helpful as a step in evaluating modules prior to execution as it will display errors within this scope.  

To run a Terraform validate check, run the following command from the root module directory: ***"terraform validate"***

Terraform validate can also be run to output to JSON files for use in pipelines, audit trails, and other third party automation tools.  To output a Terraform validate to JSON, run the following command: ***"terraform validate -json > validate.json"***

See the link here for more information: [Terraform Validate](https://www.terraform.io/docs/commands/validate.html)

#### Run a Terraform Plan
---

Terraform *plan* is used to create an execution plan.  Because Terraform is an orchestration tool used to automate resource delivery in various environments, a Terraform plan action is provided to allow administrators the ability to review the expected changes to an environment.  Terraform plan will show which resources are being added, changed, or destroyed based on the provided variable inputs passed to the modules during execution.  Terraform plan is an ideal instrument for change control processes, audit trails, and general administrative awareness of environment changes.

To run a Terraform *plan*, execute the following command from the root module directory:  ***"terraform plan"***

If you wish to run a Terraform *apply* using a set of static variables or environment specific inputs, Terraform *plan* allows a plan output using a variables file input.  To view the expected changes when using a .TFVARS file input, run the following command: ***"terraform plan -var-file=%VARIABLES_FILE_PATH_HERE%"***

You can also output a Terraform *plan* for later reference or pipe it to an out file.  To view other commands available for use when executing a Terraform *plan* action, see the link here for more information: [Terraform Plan](https://www.terraform.io/docs/commands/plan.html)

### Deployment
---

#### Run a Terraform Apply
---

Terraform *apply* is the command used to change a desired target state for an environment.  Apply will prompt for changes made to an environment prior to deployment.  The response for this action may be automated using a switch at the time of execution.

To run a Terraform *apply*, execute the following commands from the root module directory:  ***"terraform apply"***

For environment separation with TFVARS file use, a Terraform *apply* may be executed as follows:  ***"terraform apply -auto-approve -var-file=%SOME_ENVIRONMENT_VAR_FILE%"***

To see other available commands for Terraform *apply* and their usage, see the link here for more information: [Terraform Apply](https://www.terraform.io/docs/commands/apply.html)

#### Run a Terraform Destroy
---

Terraform *destroy* is the command used to destroy an environment based on the information in the state file.

To run a Terraform destroy action, run the following command from the root module directory: ***"terraform destroy"***

To see other uses of the Terraform destroy command, see the link here for more information: [Terraform Destroy](https://www.terraform.io/docs/commands/destroy.html)

## Module Reference
---

This module provides a layer of sequencing and directs the orchestration for the delivery of resources accordingly.  This module leverages sub-modules to define the desired state configuration for the infrastructure.  The root module is intended to configure the resources described in the summary above with flexibility to allow deployments into different environments.

#### Variables
---

**vpc_cidr**<br/>

The CIDR block for the VPC.<br/>
Input Type = ***string***<br/>
Default Value = ***10.0.0.0/16***<br/>
<br/>

**vpc_dns_support**<br/>

Should DNS support be enabled for the VPC?<br/>
Input Type = ***boolean***<br/>
Default Value = ***true***<br/>
<br/>

**vpc_dns_hostnames**<br/>

Should DNS hostnames support be enabled for the VPC?<br/>
Input Type = ***boolean***<br/>
Default Value = ***true***<br/>
<br/>

**Availability_zone**<br/>

A list of allowed availability zones.<br/>
Input Type = ***string***<br/>
Default Value = ***us-east-1a, us-east-1c***<br/>
<br/>

**map_public_ip**<br/>

Specify true to indicate that instances launched into the subnet should be a assigned a public IP address.<br/>
Input Type = ***boolean***<br/>
Default Value = ***true***<br/>
<br/>

**public_cidr_1**<br/>

The CIDR block for the first public subnet.<br/>
Input Type = ***string***<br/>
Default Value = ***10.0.1.0/24***<br/>
<br/>

**public_cidr_2**<br/>

The CIDR block for the second public subnet.<br/>
Input Type = ***string***<br/>
Default Value = ***10.0.2.0/24***<br/>
<br/>

**private_cidr_1**<br/>

The CIDR block for the first private subnet.<br/>
Input Type = ***string***<br/>
Default Value = ***10.0.3.0/24***<br/>
<br/>

**private_cidr_2**<br/>

The CIDR block for the second private subnet.<br/>
Input Type = ***string***<br/>
Default Value = ***10.0.4.0/24***<br/>
<br/>

**desired_capacity**<br/>

Number of instances to launch in the ECS cluster<br/>
Input Type = ***number***<br/>
Default = ***1***<br/>
<br/>

**maximum_capacity**<br/>

Maximum number of instances that can be launched in the ECS cluster.<br/>
Input Type = ***number***<br/>
Default Value = ***5***<br/>
<br/>

**instance_type**<br/>

EC2 instance type for ECS launch configuration.<br/>
Input Type = ***string***<br/>
Default Value = ***m5.large***<br/>
<br/>

**service_name**<br/>

The name for the ECS service.<br/>
Input Type = ***string***<br/>
<br/>

**ecs_image_url**<br/>

The desired ECR image url.<br/>
Input Type = ***string***<br/>
<br/>

**dynamo_table_name**<br/>

The desired DynamoDB table name.<br/>
Input Type = ***string***<br/>
Default Value = ***musicTable***<br/>
<br/>

### Security
---

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

### License
---

This library is licensed under the MIT-0 License. See the [LICENSE](LICENSE) file.
