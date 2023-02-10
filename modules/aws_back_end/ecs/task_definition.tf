resource "aws_ecs_task_definition" "app" {
  family = "${var.prefix}-${terraform.workspace}"
  //A unique name for your task definition.
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  //Amount (in MiB) of memory used by the task. 
  //If the requires_compatibilities is FARGATE this field is required.
  cpu = 256
  //Number of cpu units used by the task. 。
  //If the requires_compatibilities is FARGATE this field is required.

  // path.module -> the path of the module who has this current tf file.
  // path.root  -> the path of where main.tf
  // path.cwd   ->the path of this tf file 
  container_definitions = templatefile("${path.module}/container_definition.tftpl", {
    container_name = "${var.prefix}-${terraform.workspace}-container"
    image_uri      = var.image_uri
    //cpu                  = 128
    //This field is optional for tasks using the Fargate launch type
    memoryReservation = 400
    containerPort     = var.containerPort
    env_s3_arn           = var.env_s3_arn
    task-definition-name = "${var.prefix}-${terraform.workspace}"
  })

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  task_role_arn =  var.task_role_arn
  // this execution task policy contains role_task role to read s3
  #task_role_arn      = "arn:aws:iam::820599146567:role/ecsTaskExecutionRole"
  execution_role_arn = var.execution_role_arn
  #execution_role_arn = "arn:aws:iam::820599146567:role/ecsTaskExecutionRole"

  tags = {
    "Name " = "${var.prefix}-${terraform.workspace}"
  }

}
