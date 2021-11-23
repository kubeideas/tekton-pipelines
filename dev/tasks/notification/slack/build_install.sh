#!/bin/bash


## variables
REPOSITORY=$1
SLACK_VERSION=$2
IMG="${REPOSITORY}/slack:${SLACK_VERSION}"
TASK_NAME=slack.yaml



check_args () {

  if [ $# -ne 2 ]
   then
     echo "Invalid arguments!"
     echo "Usage: $(basename $0) <RESPOSITORY> <SLACK-VERSION>"
     echo "Ex: $(basename $0) docker.io/kubeideas v0.1.0"
     exit 2
  fi

}

## Check commands return code
check_cmd_exit() {
  if [ $1 -ne 0 ]
    then
      echo ""
      echo "Something went wrong!"
      echo "Please check parameters."
      echo ""
      exit 1
  fi
}

build () {

  docker build --rm -t ${IMG} ./docker
  check_cmd_exit $?

  docker push ${IMG}
  check_cmd_exit $?

}

update_task_image (){
  sed -i "s|image: .*/.*|image: ${IMG}|g" ${TASK_NAME}
  check_cmd_exit $?
  echo ""
  echo "Task [ ${TASK_NAME} ] image updated."
  echo ""
}

apply_task (){
  kubectl apply -f ${TASK_NAME}
  check_cmd_exit $?
  echo ""
  echo "Task [ ${TASK_NAME} ] applied to Kubernetes."
  echo ""
  kubectl get tasks

}


## MAIN ##
check_args $@
build
update_task_image
apply_task