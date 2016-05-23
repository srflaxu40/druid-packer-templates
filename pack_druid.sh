#!/bin/bash
# Author - John Knepper
# Date   - April 27th, 2016

# USAGE:
# ./pack_druid.sh <DRUID_ROLE> <PG_PASS> <PG_HOST> <ZK_HOST> <TAG_NAME> <AWS KEY> <AWS SECRET KEY> 
#                 <REGION> <SOURCE AMI> <INSTANCE TYPE> <SECURTY GROUP ID> <SUBNET ID> <VAULT FILE PATH> <PACKER PATH> <IAM ROLE NAME>

export RUN_LIST="configure,deploy,test"
export DRUID_ROLE="$1"
export PG_PASS="$2"
export PG_HOST="$3"
export ZK_HOST="$4"
export PACKER_PATH="${14:-/usr/local/bin/}"


${PACKER_PATH}packer build -debug \
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
    -var "IAM_ROLE=${15}" \
    druid_nodes.json
