apply:
	cd terraform/cluster-provisioning; terraform apply -auto-approve

destroy:
	cd terraform/cluster-provisioning; terraform destroy -auto-approve

config:
	ansible-playbook -i hosts/inventory ansible/main.yaml