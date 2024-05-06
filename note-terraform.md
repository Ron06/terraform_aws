## install awscli
configure aws credenttials in cli `aws config`
enter the keys needed

## Terraform Commands
> terraform init - build the IAC
> terraform plan - check the code
> terraform apply - run the code
> terraform destory - destroy the iinfrastructure
> *-auto-approve* - continue w/o "yes"
> terraform fmt - auto format
> terraform apply 

All `.tf` file consider same file when running as long as in the same directory

providers.tf = initialize what provider you are usin eg. gcp, aws
[terraform providers docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

main.tf = deploy your vpc resources
[vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)

## State
[Terraform state](https://developer.hashicorp.com/terraform/language/state)
* can not edit manually

- `terraform state list` to access the state use CLI 
- `terraform state show aws_vpc.mtc_vpc` to see
- `terraform show`  see the whole state

## terraform destroy
destroy anything that are created
`terraform destroy`

## subnet and referencing other resources
for ec2 deployment
    using `terraform state show aws_vpc.mtc_vpc.id`

## internet gateway
[internet gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)

## route table
- main
[route table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)

## Resource: aws_route_table_association

Provides a resource to create an association between a route table and a subnet or a route table and an internet gateway or virtual private gateway.[rt_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)


## aws security group
- main
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

## AMI datasource
-datasource
go to ec2 instances select the ami code the search it into ec2>images> once it searched copy the owner code

## key pair
- main
use to ssh the ec2

on terminal
`ssh-keygen -t ed25519` more secured keypare
copy the location and enter the keypare in the last ex. /home/ronnel/.ssh/name-here
`$HOME/.ssh` show the key code

* use terraform fuction on [file path](https://developer.hashicorp.com/terraform/language/functions/file) to locate the ssh 

# EC2 deployment

## instance
[aws_intance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

# user data
- docker ready to go
userdata.tpl = use as template

### access the ec2 instance on cli
get the public_key on the tf.state
`ssh -i ~/.ssh/auth-name ubuntu@public-ip-address` creating ssh file to access instance in cli (devnode-key)


## allow VS code to connect to EC2 instance via SSH Config Scripts

on vs code install remote-ssh extension
create the ssh file `ssh-cofig.tpl` as template
use [provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)
- local-exec

after configuring these run `terraform apply -replace aws_instance.dev_node`

after we can access in vs code remote ssh...


# variables
## Variable Definition Precedence
The above mechanisms for setting variables can be used together in any combination. If the same variable is assigned multiple values, Terraform uses the last value it finds, overriding any previous values. Note that the same variable cannot be assigned multiple values within a single source.

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

1. Environment variables
2. The `terraform.tfvars` file, if present.
3. The `terraform.tfvars.json` file, if present.
4. Any `.auto.tfvars` or *`.auto.tfvars.json files`, processed in lexical order of their filenames.
5. Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by an HCP Terraform workspace.)

[variables](https://developer.hashicorp.com/terraform/language/values/variables)

# output
[Output](https://developer.hashicorp.com/terraform/language/values/outputs) values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.

use `terraform apply -refresh-only` 