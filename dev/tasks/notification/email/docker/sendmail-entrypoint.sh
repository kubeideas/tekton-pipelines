#!/usr/bin/env bash

## variables
DAT=$(date)
FILE_TEMPLATE=""

## Check commands return code
check_cmd_exit() {
  if [ $1 -ne 0 ]; then
    echo ""
    echo "Something went wrong!"
    echo "Please check parameters informed."
    echo ""
    exit 1
  fi
}

## check required environment variables
check_env () {

  env_var_list=$1

  
  for name in ${env_var_list[*]} ; do
    if [ -z "${!name}" ]; then
        echo ""
        echo "Environment variable $name not defined!"
        echo "please check task parameters."
        echo ""
        exit 1
    fi
  done

}

## Replace email template
replace_msg_template () {

  ## check env 
  env_var_list=("GIT_REPO" "GIT_BRANCH" "GIT_COMMIT" "PUSHER_NAME" "PUSHER_EMAIL"
                "PIPELINERUN_NAME" "NAMESPACE" "PIPELINERUN_STATUS" )
  check_env ${env_var_list}

  ## Check pipeline status
  if [ ${PIPELINERUN_STATUS} == "Completed" ] || [ ${PIPELINERUN_STATUS} == "Succeeded" ]; then
    FILE_TEMPLATE="success_template.html"
  else
    FILE_TEMPLATE="failure_template.html"
  fi
  
  sed -i "s|{GIT_REPO}|${GIT_REPO}|g" ./${FILE_TEMPLATE}
  sed -i "s|{GIT_BRANCH}|${GIT_BRANCH}|g" ./${FILE_TEMPLATE}
  sed -i "s|{GIT_COMMIT}|${GIT_COMMIT}|g" ./${FILE_TEMPLATE}
  sed -i "s|{PUSHER_NAME}|${PUSHER_NAME}|g" ./${FILE_TEMPLATE}
  sed -i "s|{PUSHER_EMAIL}|${PUSHER_EMAIL}|g" ./${FILE_TEMPLATE}
  sed -i "s|{PIPELINERUN_NAME}|${PIPELINERUN_NAME}|g" ./${FILE_TEMPLATE}
  sed -i "s|{NAMESPACE}|${NAMESPACE}|g" ./${FILE_TEMPLATE}
  sed -i "s|{PIPELINERUN_STATUS}|${PIPELINERUN_STATUS}|g" ./${FILE_TEMPLATE}
  sed -i "s|{DAT}|${DAT}|g" ./${FILE_TEMPLATE}

}

## send email using smtp method
send_email_smtp (){

  ## check required env 
  env_var_list=("SUBJECT" "SMTP_SERVER" "FROM" "SMTP_AUTH_USER" "SMTP_AUTH_PASSOWRD")
  check_env ${env_var_list}

  echo ""
  echo "Using STMP server to send email notification."
  echo ""
  
  custom_subject=$(echo -e "${SUBJECT}\nContent-Type: text/html;charset=utf-8")

  mailx -v -s "${custom_subject}" \
  -S ssl-verify=ignore \
  -S smtp-auth=login \
  -S smtp=${SMTP_SERVER} \
  -S from=${FROM} \
  -S smtp-auth-user=${SMTP_AUTH_USER} \
  -S smtp-auth-password=${SMTP_AUTH_PASSOWRD} \
  $RECIPIENTS < ${FILE_TEMPLATE}

  check_cmd_exit $?
  
  exit 0    
}

## send email using api method
send_email_api  () {

  ## check requiered env 
  env_var_list=("API_URL" "TOKEN")
  check_env ${env_var_list}

  echo ""
  echo "Using service API to send email notification."
  echo ""

  echo "Must be implemented based on api details"

  check_cmd_exit $?
  
  exit 0
}



## main ##
replace_msg_template

# check required env
check_env "SEND_METHOD"

if [ ${SEND_METHOD^^} == "SMTP" ]; then
  send_email_smtp
else
  send_email_api  
fi