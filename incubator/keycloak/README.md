# Keycloak

## Installation
**Note**: Check the Makefile for additional env vars that need setting, e.g.:
* HOSTED_ZONE - the domain name to create subdomain for this kapp, 
  e.g. `example.com`

### Local installation
When running against a local provider, no AWS resources will be created. Use
the following to install locally:
```
PROVIDER=local APPROVED=true make install
``` 

Add the Minikube cluster IP to `/etc/hosts`:
```
echo $(minikube ip) keycloak.localhost | sudo tee -a /etc/hosts
```

Then go to `https://keycloak.localhost`.

### AWS installation
Installing onto an AWS Kubernetes cluster will create an RDS database. The size
of the instance will depend on the environment. E.g. to install using the dev
settings, first export your AWS credentials to the shell then run:
```
PROVIDER=aws APPROVED=false make install \
  tf-opts='-var-file=vars/defaults.tfvars -var-file=vars/dev.tfvars'
PROVIDER=aws APPROVED=true make install \
  tf-opts='-var-file=vars/defaults.tfvars -var-file=vars/dev.tfvars'
```
The first command will make Terraform plan its operations, and the second 
invocation will apply it.

## Usage
After installation using the settings in this kapp, retrieve the 
randomly-generated admin password by running:
```
kubectl get secret --namespace keycloak keycloak-http -o jsonpath="{.data.password}" | base64 --decode; echo
```
The default username is `admin`.

**Note**: Make sure to change the password to prevent anyone who can run the 
above from gaining admin.
