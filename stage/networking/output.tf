output "subnet_ids" {
  value = tolist(aws_subnet.terra_nets[*].id)
}

output "vpc_id" {
  value = aws_vpc.terra_pc.id
}