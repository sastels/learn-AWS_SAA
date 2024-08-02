module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 1.6.0"

  repository_force_delete = true
  repository_name         = local.example
  repository_lifecycle_policy = jsonencode({
    rules = [{
      action       = { type = "expire" }
      description  = "Delete all images except a handful of the newest images"
      rulePriority = 1
      selection = {
        countNumber = 3
        countType   = "imageCountMoreThan"
        tagStatus   = "any"
      }
    }]
  })
}

# Build our Image locally with the appropriate name so that we can push 
# our Image to our Repository in AWS. Also, give it a random image tag.
resource "docker_image" "this" {
  count = var.bootstrap ? 1 : 0
  name  = format("%v:%v", module.ecr.repository_url, "latest")

  build { context = "../app" }
}

# Push our container image to our ECR.
resource "docker_registry_image" "this" {
  count         = var.bootstrap ? 1 : 0
  keep_remotely = true # Do not delete old images when a new image is pushed
  name          = resource.docker_image.this[0].name
}
