
# Guided: Task Manager Application in JavaScript and TypeScript
Here you'll find the checks for the objectives you find in the lab instructions. Wait until the lab instructions tell you to run the check before proceeding.
{% steps %}
## Objective Checks
{% step title="TestStep2Task1" %}
{% task %}
{% check type="command" query="bash runTest.sh TestStep2Task1" %}
{% feedback pattern=".*" type="success" %}
Excellent! Your `deployment.yaml` manifest is well-formed and ready to be applied to the cluster.
{% /feedback %}
{% feedback pattern="AssertionFailedError:" type="error" %}
The `deployment.yaml` file is missing or has incorrect content. Make sure it defines a valid Deployment with the correct name, labels, and container image.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="TestStep2Task2" %}
{% task %}
{% check type="command" query="bash runTest.sh TestStep2Task2" %}

{% feedback pattern=".*" type="success" %}
Perfect! The application is now deployed, and a Pod is running inside your cluster.
{% /feedback %}
{% feedback pattern="AssertionFailedError:" type="error" %}
The `hello-kubernetes` Deployment doesn't seem to be running correctly. Make sure you applied the `deployment.yaml` file and that the Pod has started without errors.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="TestStep3Task1" %}
{% task %}
{% check type="command" query="bash runTest.sh TestStep3Task1" %}

{% feedback pattern=".*" type="success" %}
Great job! The Service manifest is ready to expose your Deployment.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
The `service.yaml` file is missing or incorrect. Ensure it defines a Service of type `NodePort` and that its selector correctly targets the `app: hello-kubernetes` label.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="TestStep3Task2" %}
{% task %}
{% check type="command" query="bash runTest.sh TestStep3Task2" %}

{% feedback pattern=".*" type="success" %}
Success! Your application is now deployed and accessible from outside the cluster.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
The application cannot be reached. Make sure you've applied the `service.yaml` manifest and are using the correct URL from the `minikube service` command.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="TestStep4Task1" %}
{% task %}
{% check type="command" query="bash runTest.sh TestStep4Task1" %}

{% feedback pattern=".*" type="success" %}
Excellent. You've now inspected the detailed state of a Pod, a critical skill for managing Kubernetes applications.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
This task is for exploration, but to pass the check, make sure you run `kubectl describe pod` on the correct Pod name.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="TestStep4Task2" %}
{% task %}
{% check type="command" query="bash runTest.sh TestStep4Task2" %}

{% feedback pattern=".*" type="success" %}
Well done! You can now check the logs from any running container, giving you direct insight into your application's behavior.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
This task is for exploration, but to pass the check, make sure you run `kubectl logs` on the correct Pod name.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="TestStep5Task1" %}
{% task %}
{% check type="command" query="bash runTest.sh TestStep5Task1" %}

{% feedback pattern=".*" type="success" %}
Fantastic! You've just scaled your application to handle more traffic. Kubernetes automatically distributed and started the new Pods.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
The Deployment doesn't have 3 replicas. Make sure you ran the `kubectl scale` command correctly for the `hello-kubernetes` deployment.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="TestStep5Task2" %}
{% task %}
{% check type="command" query="bash runTest.sh TestStep5Task2" %}

{% feedback pattern=".*" type="success" %}
Excellent work! You've successfully cleaned up your environment, an important final step in the resource lifecycle.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
It looks like some resources still exist. Make sure you ran `kubectl delete` using both the `service.yaml` and `deployment.yaml` files.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% /steps %}