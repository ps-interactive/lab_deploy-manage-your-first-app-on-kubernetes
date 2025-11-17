
# Guided: Task Manager Application in JavaScript and TypeScript
Here you'll find the checks for the objectives you find in the lab instructions. Wait until the lab instructions tell you to run the check before proceeding.
{% steps %}
## Objective Checks
{% step title="Task 3.1: Define Base Image and Working Directory" %}
{% task %}
The first step in creating a Docker image is defining its foundation. In the `Dockerfile`, you need to specify a base image and set up the container's filesystem.

*   **Base Image (`FROM`):** Every `Dockerfile` must start with a `FROM` instruction. This specifies the parent image from which you are building. For a Java application, a base image containing a Java Development Kit (JDK) is required for compilation. We'll use `eclipse-temurin:21-jdk-noble`, which is a good starting point.
*   **Working Directory (`WORKDIR`):** The `WORKDIR` instruction sets the working directory for any subsequent `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, and `ADD` instructions. This helps keep your `Dockerfile` clean and organized.

Your task is to add these two instructions to the `Dockerfile`.
{% check type="command" query="bash runTest.sh TestStep3Task1" %}

{% feedback pattern=".*" type="success" %}
Excellent! The foundation of the Dockerfile is now set.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
Not quite. Make sure your Dockerfile includes both a `FROM` instruction for `eclipse-temurin:21-jdk-noble` and a `WORKDIR` instruction set to `/app`.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="Task 3.2: Copy Source Code and Compile" %}
{% task %}
With the base image and working directory set up, the next step is to get your application code into the image and compile it
*   **Copying Files (`COPY`):** The `COPY` instruction is used to copy files or directories from your host machine (the build context) into the container's filesystem. You'll need to copy all the project files into the `/app` directory you defined earlier.
*   **Running Commands (`RUN`):** The `RUN` instruction executes commands in a new layer on top of the current image. You will use it to invoke the Java compiler (`javac`) to compile your source code into bytecode (`.class` files).

Your task is to add the `COPY` and `RUN` instructions to build your application inside the image.
{% check type="command" query="bash runTest.sh TestStep3Task2" %}

{% feedback pattern=".*" type="success" %}
Great job! The application code is now copied and compiled within the image.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
Almost there. Ensure you have a `COPY . .` instruction to copy the files and a `RUN` instruction that correctly compiles the `SimpleWebServer.java` file.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="Task 3.3: Expose Port and Define Run Command" %}
{% task %}
The final step for our initial `Dockerfile` is to tell Docker how to run the compiled application and how to allow network traffic to it.
*   **Exposing Ports (`EXPOSE`):** The `EXPOSE` instruction informs Docker that the container listens on the specified network ports at runtime. It functions as a type of documentation between the person who builds the image and the person who runs the container. Our Java application listens on port 8080.
*   **Default Command (`CMD`):** The `CMD` instruction provides the default command to execute when a container is run from the image. For our application, this involves using the `java` command to run the main class.

Your task is to add the `EXPOSE` and `CMD` instructions to make your image runnable.
{% check type="command" query="bash runTest.sh TestStep3Task3" %}

{% feedback pattern=".*" type="success" %}
Perfect! Your first Dockerfile is complete and ready to be built.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
Check your instructions carefully. You need to `EXPOSE` port 8080 and provide the correct `CMD` to execute the compiled Java class.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}
{% step title="Task 5.1: Name the Build Stage" %}
{% task %}
Now we'll begin refactoring our `Dockerfile` to use a multi-stage build. The first step is to officially name our existing set of instructions as the 'build' stage.

By adding `AS build` to the first `FROM` instruction, you create a named stage. This allows later stages to refer back to this stage and copy artifacts from it. This is the foundation of a multi-stage build, clearly separating the environment used for compiling from the one used for running.
{% check type="command" query="bash runTest.sh TestStep5Task1" %}

{% feedback pattern=".*" type="success" %}
Excellent! You've officially created the 'build' stage.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
Not quite. You just need to modify the first `FROM` line by adding `AS build` at the end.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="Task 5.2: Define the Final Runtime Stage" %}
{% task %}
The goal of a multi-stage build is to have a small final image. To achieve this, we'll create a new, second stage that is based on a much smaller image. Instead of the full JDK, we only need the Java Runtime Environment (JRE) to run our compiled code.\n\nYour task is to define this new final stage.
*   Add a new `FROM` instruction using the `eclipse-temurin:21-jre-noble` image. This image is significantly smaller because it doesn't include the compiler and other development tools.
*   Set the `WORKDIR` for this new stage to `/app`.
{% check type="command" query="bash runTest.sh TestStep5Task2" %}

{% feedback pattern=".*" type="success" %}
Perfect! The lightweight final stage is now defined.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
Almost. Make sure you add a new `FROM eclipse-temurin:21-jre-noble` instruction and also set the `WORKDIR` for this new stage.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}

{% step title="Task 5.3: Copy Artifact and Set Final Command" %}
{% task %}
The new stage is empty. We need to copy the compiled application from the `build` stage into our new, final stage. We also need to tell this stage how to run the application.
*   **`COPY --from`**: Use a special version of the `COPY` instruction to copy files *from another stage*. You need to copy the compiled `SimpleWebServer.class` file from the `build` stage into the current stage.
*   **Final `CMD`**: Redefine the `CMD` for this final stage. The command is similar to before, but the classpath might be different depending on where you copy the class file.

Complete the `Dockerfile` by adding these final instructions.
{% check type="command" query="bash runTest.sh TestStep5Task3" %}

{% feedback pattern=".*" type="success" %}
Perfect! Your first Dockerfile is complete and ready to be built.
{% /feedback %}

{% feedback pattern="AssertionFailedError:" type="error" %}
Congratulations! You have successfully created an optimized, multi-stage Dockerfile for a Java application.
{% /feedback %}
{% /check %}
{% /task %}
{% /step %}
{% /steps %}