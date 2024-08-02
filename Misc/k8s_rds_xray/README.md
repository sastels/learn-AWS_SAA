## Description

- A web server running in Fargate, storing data in RDS, instrumented with xray 
- copied much of https://erik-ekberg.medium.com/terraform-ecs-fargate-example-1397d3ab7f02

## Usage

```
cd terraform
terraform init
terraform apply
```


Set the variable `bootstrap` to true for the first run (to build and push the docker image)

