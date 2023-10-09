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

# Git configuration (Optional)
RUN git config --global --add safe.directory /com.docker.devenvironments.code

CMD ["npm", "start"]

