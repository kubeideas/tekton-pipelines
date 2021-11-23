#! /bin/bash


# Variables
FILE_TEMPLATE=""
DAT=$(date)

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

replace_msg_template () {

  ## check env 
  env_var_list=("CHANNEL" "GIT_REPO" "GIT_BRANCH" "GIT_COMMIT" "PUSHER_NAME" 
                "PUSHER_EMAIL" "PIPELINERUN_NAME" "NAMESPACE" "PIPELINERUN_STATUS")
  check_env ${env_var_list}

  ## Check pipeline status
  if [ ${PIPELINERUN_STATUS} == "Completed" ] || [ ${PIPELINERUN_STATUS} == "Succeeded" ]; then
    FILE_TEMPLATE="success_template.json"
  else
    FILE_TEMPLATE="failure_template.json"
  fi
  
  sed -i "s|<CHANNEL>|${CHANNEL}|g" ${FILE_TEMPLATE}
  sed -i "s|<GIT_REPO>|${GIT_REPO}|g" ${FILE_TEMPLATE}
  sed -i "s|<GIT_BRANCH>|${GIT_BRANCH}|g" ${FILE_TEMPLATE}
  sed -i "s|<GIT_COMMIT>|${GIT_COMMIT}|g" ${FILE_TEMPLATE}
  sed -i "s|<PUSHER_NAME>|${PUSHER_NAME}|g" ${FILE_TEMPLATE}
  sed -i "s|<PUSHER_EMAIL>|${PUSHER_EMAIL}|g" ${FILE_TEMPLATE}
  sed -i "s|<PIPELINERUN_NAME>|${PIPELINERUN_NAME}|g" ${FILE_TEMPLATE}
  sed -i "s|<PIPELINERUN_STATUS>|${PIPELINERUN_STATUS}|g" ${FILE_TEMPLATE}
  sed -i "s|<NAMESPACE>|${NAMESPACE}|g" ${FILE_TEMPLATE}
  sed -i "s|<DAT>|${DAT}|g" ${FILE_TEMPLATE}
  
}

send_msg () {
  
  ## check required env
  check_env "TOKEN"

  echo ""
  echo " Sending Slack message..."
  echo ""

  curl -s -H "Content-type: application/json; charset=utf-8" \
        --data "@${FILE_TEMPLATE}" \
        -H "Authorization: Bearer ${TOKEN}" \
        -X POST https://slack.com/api/chat.postMessage
  
  check_cmd_exit $?
}


#### main ####
replace_msg_template
send_msg

