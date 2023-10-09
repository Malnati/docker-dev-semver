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
# Git configuration (Optional)
RUN git config --global user.name "Malnati"
RUN git config --global user.email "ricardomalnati@gmail.com"
RUN git config --global --add safe.directory /com.docker.devenvironments.code

# Configure Git Trailers
RUN echo -e "[trailers]\n\tkey = \"Signed-off-by: \"\n\tvalue = \"Your Name <youremail@example.com>\"" >> /root/.gitconfig

CMD ["npm", "start"]
