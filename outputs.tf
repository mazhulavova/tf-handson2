output "vpc_id"                { value = module.vpc.vpc_id }
output "public_subnet_ids"     { value = module.subnets.public_subnet_ids }
output "private_subnet_ids"    { value = module.subnets.private_subnet_ids }
output "nat_gateway_id"        { value = module.natgw.nat_gateway_id }
output "internet_gateway_id"   { value = module.igw.igw_id }