#!/bin/sh

role_arn=$ROLE_ARN
role_session_name=$ROLE_SESSION_NAME

creds=$(aws sts assume-role \
  --role-arn $role_arn \
  --role-session-name $role_session_name)

aws_access_key_id=$(echo $creds | jq -r '.Credentials.AccessKeyId')
aws_secret_access_key=$(echo $creds | jq -r '.Credentials.SecretAccessKey')
aws_session_token=$(echo $creds | jq -r '.Credentials.SessionToken')

echo ::set-env name=AWS_ACCESS_KEY_ID::$aws_access_key_id
echo ::set-env name=AWS_SECRET_ACCESS_KEY::$aws_secret_access_key
echo ::set-env name=AWS_SESSION_TOKEN::$aws_session_token
