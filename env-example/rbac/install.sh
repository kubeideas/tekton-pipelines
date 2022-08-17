#!/bin/bash


## variables
NAMESPACE=$1



check_args () {

  if [ $# -ne 1 ]
   then
     echo "Invalid arguments!"
     echo "Usage: $(basename $0) <NAMESPACE>"
     echo "Ex: $(basename $0) dev"
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

update_manifests () {

  sed -i "s|namespace:.*|namespace: ${NAMESPACE}|g" ./roles/*
}

apply_manifests (){

  kubectl apply -f ./roles
  check_cmd_exit $?
  echo ""
  echo "RBAC roles and rolebindings applied to Kubernetes."
  echo ""

}



## MAIN ##
check_args $@
update_manifests
apply_manifests

