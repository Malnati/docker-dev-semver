# Docker Development Environment for Semantic Versioning and Conventional Commits

## Introduction

This guide aims to help you set up a Docker development environment that enforces Semantic Versioning and Conventional Commits. By following these steps, you'll be able to develop your application within a Docker container, ensuring that you adhere to the conventions specified at [semver.org](https://semver.org) and [conventionalcommits.org](https://www.conventionalcommits.org/en/v1.0.0/).

## Prerequisites

- Docker Desktop installed on your MacBook Air M2
- Visual Studio Code installed
- Git installed

## Step 1: Initialize Docker Dev Environment

1. **Open your terminal and navigate to your project directory.**
    ```bash
    cd path/to/your/project
    ```

2. **Create a Dockerfile for your development environment.**
    ```bash
    touch Dockerfile-DevEnvironment
    ```
    Open the Dockerfile-DevEnvironment in a text editor and add the following content:
    ```Dockerfile
    # Use an official Node runtime as base image
    FROM node:14

    # Set the working directory in the container
    WORKDIR /usr/src/app

    # Install app dependencies
    COPY package*.json ./
    RUN npm install

    # Install Semantic Versioning and Conventional Commits plugins
    RUN npm install -g semantic-release @commitlint/{config-conventional,cli} commitizen

    # Copy the current directory contents into the container
    COPY . .
    ```

3. **Create a `docker-compose.yaml` file.**
    ```bash
    touch docker-compose.yaml
    ```
    Open the `docker-compose.yaml` in a text editor and add the following content:
    ```yaml
    version: "3.7"
    services:
      app:
        build:
          context: .
          dockerfile: Dockerfile-DevEnvironment
        ports:
          - "3000:3000"
        volumes:
            - ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro
    ```

---

## Step 2: Launch VSCode Dev Environment

1. **Open Docker Desktop.**
    Navigate to the Dev Environments tab.

2. **Create a New Dev Environment.**
    Click on the "New Environment" button and select your project directory where the `docker-compose.yaml` and `Dockerfile-DevEnvironment` are located.

3. **Launch VSCode.**
    Once the environment is created, click on the "Open in VSCode" button. This will launch Visual Studio Code with the remote container extension, connecting it to your Docker container.

---

## Step 3: Install Dependencies Inside Docker Container

1. **Open Terminal in VSCode.**
    Once VSCode is connected to your Docker container, open a new terminal window inside VSCode. This terminal will be running inside your Docker container.

2. **Install Dependencies.**
    Run the following command to install the dependencies specified in your `package.json`:
    ```bash
    npm install
    ```

---

## Step 4: Configure Semantic Versioning and Conventional Commits

1. **Initialize Commitizen.**
    ```bash
    commitizen init cz-conventional-changelog --save-dev --save-exact
    ```

2. **Configure Commitlint.**
    Create a `commitlint.config.js` file and add the following content:
    ```javascript
    module.exports = {extends: ['@commitlint/config-conventional']};
    ```

3. **Set up Husky Hooks.**
    Add the following hooks to your `package.json`:
    ```json
    "husky": {
      "hooks": {
        "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
      }
    }
    ```

---

## Step 5: Integrate with ChatGPT API

1. **Install ChatGPT SDK.**
    ```bash
    npm install chatgpt-sdk
    ```

2. **Configure ChatGPT.**
    Add your ChatGPT API keys and other configurations as environment variables or within your application code.

---

## Step 6: Publish Docker Image to Docker Hub

1. **Log in to your Docker Hub account.**
    ```bash
    docker login
    ```

2. **Tag your Docker image.**
    ```bash
    docker tag local-image-name:tagname new-repo-name:tagname
    ```

3. **Push the Docker image to your Docker Hub repository.**
    ```bash
    docker push new-repo-name:tagname
    ```

---

## Step 7: Share Dev Environment

1. **Generate Shareable Link.**
    If the "Share" button is not available in Docker Desktop, you can create a manual link:
    ```bash
    https://open.docker.com/dashboard/dev-envs?url=https://github.com/Malnati/docker-dev-semver
    ```

2. **Update GitHub Repository.**
    Add this shareable link to your GitHub repository
