# IOMETE Community Version Deployment on AWS

Community Version of IOMETE Data-Plane

## 1. Terraform
Reference: https://registry.terraform.io/modules/iomete/data-plane-aws/aws/2.2.0

1. Check `terraform/aws.tf` file, and update the values accordingly.
2. Run terraform

```shell
cd terraform
terraform init --upgrade
terraform apply
```

Once terraform is done, get the EKS cluster config using the following command:
> Note: Update AWS region and EKS cluster name accordingly.
```shell
aws eks update-kubeconfig --region us-east-1 --name lakehouse
```

## 2. Prepare Database

You can bring your own database, or use the one deployed by IOMETE. 

> Note: This mysql database is for testing purpose only. It is not recommended to use it in production. For production, please use your own database that is optimized for production use.

Add `bitnami` helm repo if you haven't done so.
```shell
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

Deploy mysql database, and wait for it to be ready.
```shell
helm upgrade --install -n iomete-system -f mysql/mysql-values.yaml mysql bitnami/mysql
```

Wait for mysql pod to be ready. It takes about ~1 minute

```shell
kubectl get pods -n iomete-system -l app.kubernetes.io/name=mysql
```


## 2. Deploy IOMETE Data Plane

`data-plane-values.yaml` contains the values for IOMETE Data Plane helm chart. 
For default installation, you don't need to change anything in this file. 
But, if you want to customize the installation (for example: you use your own database and different credentials), you can change the values in this file.

Add, `iomete` helm repo if you haven't done so.
```shell
helm repo add iomete https://chartmuseum.iomete.com
helm repo update
```

Deploy IOMETE Data Plane
```shell
helm upgrade --install -n iomete-system iomete-dataplane iomete/iomete-data-plane-community-aws -f data-plane-values.yaml --version 1.6.0
```


Wait for IOMETE Data Plane pods to be ready. It takes about ~6 minutes to get everything ready in the first time installation.
```shell
kubectl get pods -n iomete-system
```


## How to use IOMETE Data Plane

Once, IOMETE Data Plane is deployed, you can access the IOMETE Data Plane UI using the following command:
```shell
kubectl get svc istio-ingress -n istio-system
```

From the output, copy the `EXTERNAL-IP` value, and open it in your browser (for example: http://<EXTERNAL-IP>)

For the first time use username and password from `data-plane-values.yaml` file `adminUser` section. Default values are `admin` and `admin`. On your first login, you will be asked to change the temporary password.




