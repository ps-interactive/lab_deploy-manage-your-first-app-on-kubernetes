#!/bin/bash

# Helper function to check command success
check_command() {
    if [ $? -ne 0 ]; then
        echo "AssertionFailedError: $1"
        exit 1
    fi
}

# Test for Step 1, Task 1
TestStep1Task1() {
    kubectl get nodes | grep -E 'minikube.*Ready' > /dev/null
    check_command "Minikube node is not in 'Ready' state."
}

# Test for Step 2, Task 1
TestStep2Task1() {
    if [ ! -f deployment.yaml ]; then
        echo "AssertionFailedError: 'deployment.yaml' file not found."
        exit 1
    fi
    kubectl apply --dry-run=client -f deployment.yaml > /dev/null
    check_command "'deployment.yaml' is not a valid Kubernetes manifest."
    grep 'image: paulbouwer/hello-kubernetes:1.10' deployment.yaml > /dev/null
    check_command "Container image in 'deployment.yaml' is incorrect."
    echo "Excellent! Your deployment.yaml manifest is well-formed and ready to be applied to the cluster."
}

# Test for Step 2, Task 2
TestStep2Task2() {
    REPLICAS=$(kubectl get deployment hello-kubernetes -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
    if [ "$REPLICAS" != "1" ]; then
        echo "AssertionFailedError: Deployment 'hello-kubernetes' does not have 1 ready replica. Found: '$REPLICAS'"
        exit 1
    fi
    echo "Perfect! The application is now deployed, and a Pod is running inside your cluster."
}

# Test for Step 3, Task 1
TestStep3Task1() {
    if [ ! -f service.yaml ]; then
        echo "AssertionFailedError: 'service.yaml' file not found."
        exit 1
    fi
    kubectl apply --dry-run=client -f service.yaml > /dev/null
    check_command "'service.yaml' is not a valid Kubernetes manifest."
    grep 'type: NodePort' service.yaml > /dev/null
    check_command "Service in 'service.yaml' is not of type 'NodePort'."
    echo "Great job! The Service manifest is ready to expose your Deployment."
}

# Test for Step 3, Task 2
TestStep3Task2() {
    URL=$(minikube service hello-kubernetes --url 2>/dev/null)
    check_command "Could not get URL for service 'hello-kubernetes'. Is it running?"
    curl -s --max-time 5 "$URL" | grep 'Hello Kubernetes!' > /dev/null
    check_command "Application at URL '$URL' did not respond correctly."
    echo "Success! Your application is now deployed and accessible from outside the cluster."
}

# Test for Step 4, Task 1 (existence check)
TestStep4Task1() {
    REPLICAS=$(kubectl get deployment hello-kubernetes -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
    if [ -z "$REPLICAS" ] || [ "$REPLICAS" -lt 1 ]; then
        echo "AssertionFailedError: Could not find any ready Pods for deployment 'hello-kubernetes'."
        exit 1
    fi
    echo "Excellent. You've now inspected the detailed state of a Pod, a critical skill for managing Kubernetes applications."
}

# Test for Step 4, Task 2 (existence check)
TestStep4Task2() {
    REPLICAS=$(kubectl get deployment hello-kubernetes -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
     if [ -z "$REPLICAS" ] || [ "$REPLICAS" -lt 1 ]; then
        echo "AssertionFailedError: Could not find any ready Pods for deployment 'hello-kubernetes'."
        exit 1
    fi
    echo "Well done! You can now check the logs from any running container, giving you direct insight into your application's behavior."
}

# Test for Step 5, Task 1
TestStep5Task1() {
    REPLICAS=$(kubectl get deployment hello-kubernetes -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
    if [ "$REPLICAS" != "3" ]; then
        echo "AssertionFailedError: Deployment 'hello-kubernetes' does not have 3 ready replicas. Found: '$REPLICAS'"
        exit 1
    fi
    echo "Fantastic! You've just scaled your application to handle more traffic. Kubernetes automatically distributed and started the new Pods."
}

# Test for Step 5, Task 2
TestStep5Task2() {
    kubectl get deployment hello-kubernetes &> /dev/null
    if [ $? -eq 0 ]; then
        echo "AssertionFailedError: Deployment 'hello-kubernetes' still exists."
        exit 1
    fi
    kubectl get service hello-kubernetes &> /dev/null
    if [ $? -eq 0 ]; then
        echo "AssertionFailedError: Service 'hello-kubernetes' still exists."
        exit 1
    fi
    echo "Excellent work! You've successfully cleaned up your environment, an important final step in the resource lifecycle."
}


# Main execution logic
if [ -n "$1" ]; then
    $1
else
    echo "No test specified."
    exit 1
fi