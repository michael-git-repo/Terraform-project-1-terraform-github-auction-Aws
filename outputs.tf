output "instance_public_ip" {
  value       = module.ec2.public_ip
  description = "Public IP from the EC2 module"
}