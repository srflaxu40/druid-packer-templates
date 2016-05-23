#!/bin/bash
# Author - John Knepper
# Date   - April 27th, 2016

# USAGE:
# ./pack_tranquility.sh <TRANQ_ROLE> <ZK_HOST> <TAG_NAME> <AWS KEY> <AWS SECRET KEY> 
#                 <REGION> <SOURCE AMI> <INSTANCE TYPE> <SECURITY_GROUP_ID> <SUBNET ID> <PACKER PATH>
#                 <DRUID_ROLE> <IAM ROLE NAME>

export RUN_LIST="configure,deploy,test"
export TRANQ_ROLE="$1"
export ZK_HOST="$2"
export PACKER_PATH="${11:-/usr/local/bin/}"


${PACKER_PATH}packer build -debug \
    -var "aws_access_key=$4" \
    -var "aws_secret_key=$5" \
    -var "RUN_LIST=${RUN_LIST}" \
    -var "TRANQ_ROLE=${TRANQ_ROLE}" \
    -var "ZK_HOST=${ZK_HOST}" \
    -var "tag_name=$3" \
    -var "region=$6" \
    -var "source_ami=$7" \
    -var "instance_type=${8}" \
    -var "security_group_id=${9}" \
    -var "subnet_id=${10}" \
    -var "druid_role=${12}" \
    -var "druid_role=${13}" \
    tranquility_nodes.json

