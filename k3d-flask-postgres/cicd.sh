#!/bin/bash

# Configuration
NAMESPACE="default"
DEPLOYMENT_NAME="flask-todo"
IMAGE_NAME="danielcristh0/flask-todo"
IMAGE_TAG="1.1"

# Function to update deployment
update_deployment() {
    echo "Updating deployment..."

    # Update the deployment with new image
    kubectl set image deployment/${DEPLOYMENT_NAME} \
        ${DEPLOYMENT_NAME}=${IMAGE_NAME}:${IMAGE_TAG} \
        -n ${NAMESPACE}

    # Optionally, trigger a restart of all pods (useful if you want a fresh restart)
    kubectl rollout restart deployment/${DEPLOYMENT_NAME} -n ${NAMESPACE}

    # Wait for rollout to complete
    kubectl rollout status deployment/${DEPLOYMENT_NAME} \
        -n ${NAMESPACE} \
        --timeout=300s
}
# Function to verify deployment
verify_deployment() {
    echo "Verifying deployment..."

    # Check if pods are running
    READY_PODS=$(kubectl get pods -l app=${DEPLOYMENT_NAME} \
        -n ${NAMESPACE} \
        -o jsonpath='{.items[].status.containerStatuses[].ready}' | \
        tr ' ' '\n' | grep -c "true")

    if [ "$READY_PODS" -gt 0 ]; then
        echo "Deployment verified successfully!"
        return 0
    else
        echo "Deployment verification failed!"
        return 1
    fi
}

# Main deployment process
echo "Starting deployment process..."
update_deployment
verify_deployment