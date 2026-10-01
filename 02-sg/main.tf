module "sg" {
    count = length(var.sg_names)
    source = "git::https://github.com/urstrulywin/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = replace(var.sg_names[count.index], "_", "-")
}