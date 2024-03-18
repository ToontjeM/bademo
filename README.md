# Big Animal demo

## Demo prep

Log in to Big Animal

Make sure the CLI is authenticated against AWS and Azure of you want to use those.

Initialize the environment using `./00-prep.sh`

## Demo flow
### Web UI

Create new cluster

Explain the three cluster option
- Single node – Storage is separate. If the node goes down, a new Postgres node will be spun up and the storage will be attached again
- HA - Critical
- Distributed - In select use cases

Select HA with two replicas

Select AWS 
- Show costs between the three options.

Give name and password
- Explain that the password is used in the connection string later

Explain difference between Oracle compatible and PostgreSQL

Select version

Select region, instance type

Select storage
- Speed is important

Explain networking
- Recommended is Public with access lists

Press Next: DB Configuration

Show the massive amount of parameters you have control over.c
- Explain db_dialect on page 3
- Explain warning signs

Press Next: Backups
- BigAnimal clusters are continuously backed up by BigAnimal. 
- Backups are stored in cloud native storage (S3 or Azure Bob Storage)
- Retention period can be changed, but this results in a higher cloud storage costs.

Create cluster

## CLI
`biganimal cluster create` (interactive)

`cat config_file.yaml`

`biganimal cluster create -F config_file.yaml`

`biganimal cluster show`

(Optional) `biganimal cluster delete --id <put id here>`

## Terraform
`cat resource-rs.tf`

`terraform init`

`terraform plan`

`terraform apply --auto-approve`

`biganimal cluster show`

(Optional) `terraform destroy --auto-approve`

## Demo Cleanup 
Either demo `biganimal cluster delete --id <clusterid>` and  `terraform destroy --auto-approve` manually or run `./99-deprovision.sh` which does it for you.
