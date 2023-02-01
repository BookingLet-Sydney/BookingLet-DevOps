resource "aws_ecs_task_definition" "test" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  // path.module -> the path of the module who has this current tf file.
  // path.root  -> the path of where main.tf
  // path.cwd   ->the path of this tf file 
  container_definitions    = templatefile(".///", {
        name   = "${var.prefix}-cont"
        cpu    = 128
        memory = 450
        image  = "${var.image}"
        environmentFiles    = "${var.environment_file_path}"
        container_port      = "${var.container_port}"
    })

  runtime_platform {
    operating_system_family = "WINDOWS_SERVER_2019_CORE"
    cpu_architecture        = "X86_64"
  }
  //task_role
  // task_excution_role

}