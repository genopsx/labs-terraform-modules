#!/bin/bash
echo "This is beginning of init-steps script ---------------------"
echo "Terraform output running"
echo "PWD"
pwd
ORIG_DIR=$(pwd)
echo "ORIG_DIR=${ORIG_DIR}"
echo -e "TF_DIR=${TF_DIR}"
echo "cd {TF_DIR}"
cd "${TF_DIR}" || exit
echo "PWD"
pwd
echo "ls -al"
ls -al
# Declare and assign separately
OUTPUT_EFS_ACCESS_POINT_ID="$(terraform output -raw efs_access_point_id)"
export OUTPUT_EFS_ACCESS_POINT_ID
echo -e "OUTPUT_EFS_ACCESS_POINT_ID=${OUTPUT_EFS_ACCESS_POINT_ID}"
echo "terraform output json"
terraform output -json
terraform output -json >>"${ORIG_DIR}/terraform_output.json"
echo "terraform ouput json > jq"
terraform output -json | jq -r ".efs_access_point_id.value"
echo "testing PSQL version - already installed in image"
psql --version
echo "WHICH PSQL"
which psql
echo "cd ORIG_DIR > pwd"
cd "${ORIG_DIR}" || exit
pwd
echo "cat terraform_output.json"
cat terraform_output.json
echo "This is end of init-steps script -------------------------"
