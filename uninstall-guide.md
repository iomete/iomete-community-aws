# Uninstall Guide

1. Uninstall IOMETE Data Plane
```shell
helm uninstall -n iomete-system iomete-dataplane

# Delete other leftover resources
kubectl delete helmrelease -n iomete-system --all
kubectl delete helmrepositories -n iomete-system --all
```

2. Uninstall mysql database (if you deployed it using helm)

```shell
helm uninstall -n iomete-system mysql
```

3. Uninstall terraform (AWS Infrastructure)

> Note: Manually delete the contents of S3 buckets because AWS doesn't permit the deletion of non-empty buckets. If you don't, the `terraform destroy` command will fail. 
> 1. Find, the lakehouse bucket which is specified in the terraform file (`lakehouse_bucket_name`).
> 2. Find assets bucket which will be prefixed with `{cluster_name}-assets-{random_string}`. You can find the cluster name in the terraform file (`cluster_name`).
> Empty the contents of these buckets. Terraform will delete them.


```shell
cd terraform
terraform destroy
```

