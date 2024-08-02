# Create an ECS cluster with Fargate capacity providers

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 4.1.3"

  cluster_name = local.example

  # Allocate 20% capacity to FARGATE and then split
  # the remaining 80% capacity 50/50 between FARGATE
  # and FARGATE_SPOT.
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        base   = 20
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }
}

# Create a task definition for our ECS service

# data "aws_iam_role" "ecs_task_execution_role" { name = "ecsTaskExecutionRole" }
# resource "aws_ecs_task_definition" "this" {
#   container_definitions = jsonencode([{
#     environment : [
#       { name = "NODE_ENV", value = "production" }
#     ],
#     essential    = true,
#     image        = format("%v:%v", module.ecr.repository_url, "latest"),
#     name         = local.container_name,
#     portMappings = [{ containerPort = local.container_port }],
#   }])
#   cpu                      = 256
#   execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
#   family                   = "family-of-${local.example}-tasks"
#   memory                   = 512
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
# }
