#!/usr/bin/env sh

## Check commands return code
check_cmd_exit() {
  if [ $1 -ne 0 ]
    then
      echo ""
      echo "Something went wrong!"
      echo "Please check parameters informed."
      echo ""
      exit 1
  fi
}


echo "Adding helm chart repository..." 
helm repo add repo-charts ${CHART_REPO_URL}
check_cmd_exit $?
echo ""      


echo ""  
echo "Searching for helm chart..."    
helm search repo repo-charts/${CHART_NAME} --version ${CHART_VERSION}
check_cmd_exit $?
echo ""  

if [ -z ${HELM_CUSTOM_FILE} ]
  then
    echo ""
    echo "No custom helm file were informed. Default install will be applied."
    echo ""
     helm upgrade --install ${RELEASE} \
    --namespace=${NAMESPACE} \
    --set image.repository=${IMAGE_REPO} \
    --set image.tag=${IMAGE_TAG} \
    --description="${DESCRIPTION}" \
    --history-max=${HISTORY_MAX} \
    repo-charts/${CHART_NAME}
    check_cmd_exit $?
    exit 0
  else
    echo ""
    echo "Using Helm custom file from cloned source repo = [ ${HELM_CUSTOM_FILE} ]"
    echo ""
    helm upgrade --install ${RELEASE} \
    --namespace=${NAMESPACE} \
    --set image.repository=${IMAGE_REPO} \
    --set image.tag=${IMAGE_TAG} \
    --description="${DESCRIPTION}" \
    --history-max=${HISTORY_MAX} \
    -f ${HELM_CUSTOM_FILE} \
    repo-charts/${CHART_NAME}
    check_cmd_exit $?
    
    exit 0
fi