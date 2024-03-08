resource "aws_ecs_cluster" "ecs_cluster" {
  count = var.create_cluster ? 1 : 0
  name  = var.cluster_name
}
resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = "${var.cluster_name}-ecs-capacity-provider-zeroc-${var.environment}"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.asg.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_capacity_providers" {
  cluster_name = var.cluster_name

  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
  }
}
