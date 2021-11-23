#!/bin/bash


## variables
REPOSITORY=$1
VERSION=$2
IMG="${REPOSITORY}/tkncli:v${VERSION}"
TASK_NAME=tkn-purge.yaml


check_args () {

  if [ $# -ne 2 ]
   then
     echo "Invalid arguments!"
     echo "Usage: $(basename $0) <RESPOSITORY> <TKN-CLI-VERSION>"
     echo "Ex: $(basename $0) docker.io/kubeideas 0.21.0"
     exit 2
  fi

}

## Check commands return code
check_cmd_exit() {
  if [ $1 -ne 0 ]; then
    echo ""
    echo "Something went wrong!"
    echo "Please check parameters."
    echo ""
    
    ## clear tmp dir
    clear_tmp

    exit 1
  fi
}



build_image () {

  docker build --rm --build-arg VERSION=${VERSION} -t ${IMG} ./docker
  
  check_cmd_exit $?

  docker scan ${IMG}
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
build_image
update_task_image
apply_task
