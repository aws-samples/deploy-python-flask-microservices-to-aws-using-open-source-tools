# The CIDR block for the VPC to create.
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

# A boolean flag to enable/disable DNS support in the VPC.  Defaults true.
variable "vpc_dns_support" {
  description = "Should DNS support be enabled for the VPC?"
  type        = bool
  default     = true
}

# A boolean flag to enable/disable DNS hostnames in the VPC.  Defaults true.
variable "vpc_dns_hostnames" {
  description = "Should DNS hostnames support be enabled for the VPC?"
  type        = bool
  default     = true
}

# A list of allowed availability zones.
variable "availability_zone" {
  description = "A list of allowed availability zones."
  type        = list(any)
  default     = ["us-east-1a", "us-east-1c"]
}

# A boolean flag to map the public IP on launch for public subnets.  Defaults true.
variable "map_public_ip" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  type        = bool
  default     = true
}

# The CIDR block for the public subnet.  This block should be a range within the above VPC CIDR.
variable "public_cidr_1" {
  description = "The CIDR block for the first public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

# The CIDR block for the public subnet.  This block should be a range within the above VPC CIDR.
variable "public_cidr_2" {
  description = "The CIDR block for the second public subnet."
  type        = string
  default     = "10.0.2.0/24"
}

# The CIDR block for the first private subnet.  This block should be a range within the above VPC CIDR.
variable "private_cidr_1" {
  description = "The CIDR block for the first private subnet."
  type        = string
  default     = "10.0.3.0/24"
}

# The CIDR block for the second private subnet.  This block should be a range within the above VPC CIDR.
variable "private_cidr_2" {
  description = "The CIDR block for the second private subnet."
  type        = string
  default     = "10.0.4.0/24"
}

# This variable defines the desired number of instances to launch in the ECS cluster.
variable "desired_capacity" {
  description = "Number of instances to launch in the ECS cluster."
  type        = number
  default     = 1
}

# This variable defines the maximum number of instances to launch in the ECS cluster.
variable "maximum_capacity" {
  description = "Maximum number of instances that can be launched in the ECS cluster."
  type        = number
  default     = 5
}

# This variable defines the instance type.
variable "instance_type" {
  description = "EC2 instance type for ECS launch configuration."
  type        = string
  default     = "m5.large"
}

# This variables defines the ECS service name.
variable "service_name" {
  description = "The name for the ECS service."
  type        = string
  default     = "flask-docker"
}

# This variable defines the ECR image URL.
variable "ecs_image_url" {
  description = "The desired ECR image URL."
  type        = string
}

# This variable defines the name for the DynamoDB table used by the container app.
variable "dynamodb_table_name" {
  description = "The desired DynamoDB table name."
  type        = string
  default     = "musicTable"
}
