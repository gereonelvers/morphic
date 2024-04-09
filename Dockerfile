# Start with a base image that includes Node.js
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the local project files into the container
COPY . .

# Install bun package manager
RUN curl https://bun.sh/install | bash

# Set the PATH to include the bun binary
ENV PATH="/root/.bun/bin:${PATH}"

# Install the project dependencies
RUN bun i

# Define build-time variables to accept API keys
ARG OPENAI_API_KEY
ARG TAVILY_API_KEY

# Set environment variables from the build arguments
ENV OPENAI_API_KEY=${OPENAI_API_KEY}
ENV TAVILY_API_KEY=${TAVILY_API_KEY}

# Inform Docker that the container listens on port
EXPOSE $PORT

# Command to run the app
CMD ["bun", "dev", "--port", "$PORT"]
