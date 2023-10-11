#!/bin/bash
# Author: Ricardo
# Creation Date: 2023-10-10
# Goal: To test OpenAI API call
# Dependencies: curl, jq

# Set API Key
API_KEY="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"

# Prepare the JSON payload
JSON_PAYLOAD=$(cat <<EOF
{
  "model": "gpt-3.5-turbo-16k",
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant."
    },
    {
      "role": "user",
      "content": "Hello!"
    }
  ]
}
EOF
)

# Make an API call to ChatGPT for analysis
API_RESPONSE=$(curl -s -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "$JSON_PAYLOAD" \
    "https://api.openai.com/v1/chat/completions")

# Output the API response
echo "API Response: $API_RESPONSE"
