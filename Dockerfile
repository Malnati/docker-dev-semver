# Use an official Node runtime as base image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Install Semantic Versioning and Conventional Commits plugins
RUN npm install -g semantic-release @commitlint/config-conventional @commitlint/cli commitizen

# Install curl and jq
RUN apt-get update && \
    apt-get install -y curl jq

# Git configuration
RUN git config --global user.name "Malnati"
RUN git config --global user.email "ricardomalnati@gmail.com"
RUN git config --global --add safe.directory /com.docker.devenvironments.code

# Configure Git Trailers
RUN echo "[trailers]" >> /root/.gitconfig && \
    echo "    key = \"Signed-off-by: \"" >> /root/.gitconfig && \
    echo "    value = \"Your Name <youremail@example.com>\"" >> /root/.gitconfig

# Copy the current directory contents into the container
COPY . .

CMD ["npm", "start"]
