# Terraform project:

Developed a full network from scratch to efficiently deploy microservices (a central status service, a lighting service, heating service, and authorisation service) for a smart home system using Terraform (AWS Provider).

## Acomplishments:

- Provisioned networking infrastructure using self-made modules,  including VPCs, subnets, IGW and NAT gateways and routing tables
- Configured security groups to control traffic flow between microservices and external systems (HTTP Ingress and Egress, SSH)
- Defined public and private instances to host microservices, with autoscaling policies tailored to their requirements 
- Set up load balancers to distribute incoming traffic, using path based routing 
- Utilised Amazon DynamoDB, a NoSQL database, to store application data



