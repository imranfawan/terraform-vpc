output "vpc_id" {
  value       = "${aws_vpc.vpc.id}"
  description = "The ID of eks the VPC"
}

output "subnet_pvt_id_1a" {
  value       = "${aws_subnet.private-subnet-1a.id}"
  description = "The ID of the pvt subnet in zone 1a"
}

output "subnet_pvt_id_1b" {
  value       = "${aws_subnet.private-subnet-1b.id}"
  description = "The ID of the pvt subnet in zone 1b"
}

output "subnet_pvt_id_1c" {
  value       = "${aws_subnet.private-subnet-1c.id}"
  description = "The ID of the pvt subnet in zone 1c"
}

output "subnet_pub_id_1a" {
  value       = "${aws_subnet.public-subnet-1a.id}"
  description = "The ID of the pub subnet in zone 1c"
}

output "subnet_pub_id_1b" {
  value       = "${aws_subnet.public-subnet-1b.id}"
  description = "The ID of the pub subnet in zone 1c"
}

output "subnet_pub_id_1c" {
  value       = "${aws_subnet.public-subnet-1c.id}"
  description = "The ID of the pub subnet in zone 1c"
}
