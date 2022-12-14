variable "aws_access_key" {
  type        = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
}
variable "aws_region" {
  type        = string
  description = "AWS region"
}
variable "availability_zone" {
  type        = string
  description = "AWS availability zone"
}
variable "instance-ami" {
  type        = string
  description = "EC2 instance AMI"
}
variable "instance_type" {
  type        = string
  description = "The type of instance to start"
}
variable "public-ip" {
  type        = bool
  description = "Enabling automatic public IP assignment on instance launch"
}
variable "cpu_core_count" {
  description = "Sets the number of CPU cores for an instance."
  type        = number
  default     = null
}
variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet"
  type        = number
  default     = null
}
variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = null
}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}