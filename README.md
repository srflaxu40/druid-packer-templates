---

# Running packer with ansible (see packer installation instructions on the web):

* Run the following shell script `pack_druid.sh` like below (with your specific parameters) to pack Druid with Packer:

```
./pack_druid.sh \
overlord \
abc123 \
<PG HOST IP> \
<ZK domain name> \
druid_overlord \
AKIAJ5ZPSECRET \
RbKGATy3CISrMGp/nSECRET \
us-west-1 \
<BASE AMI ID> \
t2.large \
<SECURITY GROUP ID> \
subnet-687069a27 \
/opt/packer/ \
~/.ansible-vault.txt
```

* , And for packing tranquility:

`
./pack_tranquility.sh druid-tranq 52.53.183.198 druid-tranq <AWS KEY> <SECRET KEY> us-west-1 ami-123483 t2.large sg-93aasdf9 subnet-82837 /opt/packer
`

* Note the <PACKER PATH> variable in these example are specific to building packer on Jenkins.  If you were running this locally, you would simply use './'.
* The scripts use the parameters as below.  Please look at each pack_* shell script for more information on USAGE:

```
#!/bin/bash
 
# USAGE:
# ./pack_druid.sh <DRUID_ROLE> <PG_PASS> <PG_HOST> <ZK_HOST> <TAG_NAME> <AWS KEY> <AWS SECRET KEY> 
#                 <REGION> <SOURCE AMI> <INSTANCE TYPE> <SECURITY GROUP ID> <SUBNET ID> <VAULT FILE> <PACKER PATH>

export RUN_LIST="configure,deploy,test"
export DRUID_ROLE="$1"
export PG_PASS="$2"
export PG_HOST="$3"
export ZK_HOST="$4"
export PACKER_PATH="${14:-/usr/local/bin/}"


packer build \
    -var "aws_access_key=$6" \
    -var "aws_secret_key=$7" \
    -var "RUN_LIST=${RUN_LIST}" \
    -var "DRUID_ROLE=${DRUID_ROLE}" \
    -var "PG_PASS=${PG_PASS}" \
    -var "ZK_HOST=${ZK_HOST}" \
    -var "PG_HOST=${PG_HOST}" \
    -var "tag_name=$5" \
    -var "region=$8" \
    -var "source_ami=$9" \
    -var "instance_type=${10}" \
    -var "security_group_id=${11}" \
    -var "subnet_id=${12}" \
    -var "vault_file=${13}" \
    druid_nodes.json
```
