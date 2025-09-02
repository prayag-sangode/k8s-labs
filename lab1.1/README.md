# EKS Cluster Setup with eksctl

This guide describes how to create and manage an Amazon EKS (Elastic Kubernetes Service) cluster using **eksctl**.

---

## Prerequisites

Before running the command, ensure you have the following installed and configured:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (configured with `aws configure`)
- [eksctl](https://eksctl.io/introduction/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

---

## Cluster Creation

Run the following command to create an EKS cluster:

```bash
eksctl create cluster \
  --name my-cluster \
  --region us-east-1 \
  --version 1.33 \
  --nodegroup-name standard-workers \
  --node-type t2.medium \
  --nodes 1 \
  --nodes-min 1 \
  --nodes-max 1 \
  --managed \
  --with-oidc
````

### Command Explanation

* `--name my-cluster` → Name of the EKS cluster.
* `--region us-east-1` → AWS region where the cluster will be created.
* `--version 1.33` → Kubernetes version for the cluster.
* `--nodegroup-name standard-workers` → Name of the worker node group.
* `--node-type t2.medium` → EC2 instance type for worker nodes.
* `--nodes 1` → Desired number of worker nodes.
* `--nodes-min 1` → Minimum number of worker nodes (Auto Scaling).
* `--nodes-max 1` → Maximum number of worker nodes (Auto Scaling).
* `--managed` → Create a **managed node group** (recommended).
* `--with-oidc` → Enables **IAM OIDC provider**, required for fine-grained IAM roles for service accounts (IRSA).

---

## Verification

Once the cluster is created:

1. **Check cluster status**

   ```bash
   eksctl get cluster --region us-east-1
   ```

2. **Update kubeconfig**

   ```bash
   aws eks update-kubeconfig --name my-cluster --region us-east-1
   ```

3. **Verify nodes**

   ```bash
   kubectl get nodes
   ```

---

## View and Save Existing Cluster Config

1. **View existing cluster config in YAML**

   ```bash
   eksctl get cluster --name my-cluster -o yaml
   ```

   Shows cluster metadata, VPC, and node groups.

2. **Save cluster config to a file**

   ```bash
   eksctl get cluster --name my-cluster -o yaml > current-cluster.yaml
   ```

3. **Describe cluster VPC & networking via AWS CLI**

   ```bash
   aws eks describe-cluster \
     --name my-cluster \
     --region us-east-1 \
     --query cluster.resourcesVpcConfig
   ```

   Outputs: VPC ID, subnets, security groups, and endpoint access.

---

## Production Recommendations

* Use **private-only subnets** for worker nodes.
* Deploy **highly available NAT gateways** for outbound traffic.
* Restrict **API server access** using `publicAccessCIDRs`.
* Always **plan CIDR blocks** carefully to avoid overlaps (important for VPC peering or on-prem connectivity).
* Any change to **VPC settings** requires recreating the EKS cluster.

---

## Cleanup

To delete the cluster and all resources created by `eksctl`:

```bash
eksctl delete cluster --name my-cluster --region us-east-1
```

---

## References

* [EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
* [eksctl Documentation](https://eksctl.io/)

