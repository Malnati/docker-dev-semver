# Docker Development Environment for Semantic Versioning and Conventional Commits

## Introduction

This guide aims to help you set up a Docker development environment that enforces Semantic Versioning and Conventional Commits. By following these steps, you'll be able to develop your application within a Docker container, ensuring that you adhere to the conventions specified at [semver.org](https://semver.org) and [conventionalcommits.org](https://www.conventionalcommits.org/en/v1.0.0/).

## Prerequisites

- Docker Desktop installed on a Unix-compatible system
- Visual Studio Code installed
- Git installed

## Step 1: Initialize Docker Dev Environment

1. **Open your terminal and navigate to your project directory.**
    ```bash
    cd path/to/your/project
    ```

2. **Create a `package.json` file with the following content:**
    ```bash
    touch package.json
    ```
    ```json
    {
      "name": "docker-dev-semver",
      "version": "1.0.0",
      "description": "## Introduction",
      "main": "index.js",
      "scripts": {
        "start": "node index.js",
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "keywords": [],
      "author": "",
      "license": "ISC"
    }
    ```

3. **Create an `index.js` file with the following content:**
    ```javascript
    console.log("Hello, world!");
    ```

4. **Create a Dockerfile for your development environment.**
    ```bash
    touch Dockerfile
    ```
    Open the Dockerfile in a text editor and add the following content:
    ```Dockerfile
    # Use an official Node runtime as base image
    FROM node:14

    # Set the working directory in the container
    WORKDIR /usr/src/app

    # Install app dependencies
    COPY package*.json ./
    RUN npm install

    # Install Semantic Versioning and Conventional Commits plugins
    RUN npm install -g semantic-release @commitlint/config-conventional @commitlint/cli commitizen

    # Copy the current directory contents into the container
    COPY . .

    CMD ["npm", "start"]
    ```

5. **Create a `docker-compose.yaml` file.**
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
          dockerfile: Dockerfile
        ports:
          - "3000:3000"
        volumes:
            - ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro
    ```

6. **Build and run your Docker container.**
    ```bash
    docker-compose up --build
    ```

7. **Create a Shareable Docker Dev Environment Link.**
    Generate a shareable link for your Docker Dev Environment like the following:
    ```bash
    https://open.docker.com/dashboard/dev-envs?url=https://github.com/YourUsername/YourRepoName
    ```
    Replace `YourUsername` and `YourRepoName` with your GitHub username and repository name, respectively.
    https://open.docker.com/dashboard/dev-envs?url=https://github.com/Malnati/docker-dev-semver

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

---

## Step 8: Utilize Git Trailers for Metadata

Git Trailers allow you to append metadata to your commit messages, which can be useful for tracking issues, authors, and other information. For more details, refer to the official [Git Trailers documentation](https://git-scm.com/docs/git-interpret-trailers).

1. **Install Git Trailers.**
    Git Trailers are built into Git, so no additional installation is required.

2. **Configure Git Trailers.**
    You can configure Git Trailers in your `.gitconfig` or within the repository's `.git/config` file. Here's an example:
    ```ini
    [trailers]
        key = "Signed-off-by: "
        value = "Your Name <youremail@example.com>"
    ```

3. **Use Git Trailers in Commit Messages.**
    When you make a commit, you can include trailers at the end of your commit message like so:
    ```text
    feat: add new feature

    Signed-off-by: Your Name <youremail@example.com>
    ```

---

## Step 9: Integrate CommitGPT for Automated Commit Messages

[CommitGPT](https://github.com/RomanHotsiy/commitgpt) is a tool that leverages GPT-3 to generate commit messages automatically. This can be particularly useful for maintaining a consistent and descriptive commit history.

1. **Install CommitGPT.**
    To install CommitGPT, you can use npm:
    ```bash
    npm install -g commitgpt
    ```

2. **Configure CommitGPT.**
    After installation, you'll need to set up your GPT-3 API key. You can do this by setting an environment variable:
    ```bash
    export OPENAI_API_KEY="your-openai-api-key"
    ```

3. **Use CommitGPT for Commits.**
    Instead of using `git commit`, you can now use `commitgpt` to generate a commit message automatically:
    ```bash
    commitgpt
    ```

    This will stage all your changes and open an editor with a pre-filled commit message generated by GPT-3.

---

## Step 11: Setting Up Zsh with Autosuggestions in Docker Dev Environment

[Zsh Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) is a plugin for Zsh that suggests commands as you type, based on your command history. This can be particularly useful for speeding up your workflow.

### Install Zsh and Change Default Shell

1. **Update the Dockerfile.**
    Add the following lines to your `Dockerfile-DevEnvironment` to install Zsh:
    ```Dockerfile
    RUN apt-get update && apt-get install -y zsh
    ```

2. **Change Default Shell to Zsh.**
    Add this line to your `Dockerfile-DevEnvironment` to change the default shell to Zsh:
    ```Dockerfile
    SHELL ["/bin/zsh", "-c"]
    ```

### Install Zsh Autosuggestions

1. **Clone the Zsh Autosuggestions Repository.**
    Add the following line to your `Dockerfile-DevEnvironment` to clone the repository:
    ```Dockerfile
    RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    ```

2. **Enable the Plugin.**
    Add the following line to your `Dockerfile-DevEnvironment` to enable the plugin:
    ```Dockerfile
    RUN echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    ```

### Rebuild Docker Image

After making these changes, rebuild your Docker image to apply them:
```bash
docker-compose build
```

---
