const axios = require('axios');
const fs = require('fs');

// Read the diff logs from a file (Replace with your actual file path)
const diffLogs = fs.readFileSync('/path/to/git-diff-cached-diff.logs', 'utf-8');

// Prepare the JSON payload
const payload = {
  prompt: `Analyze commit for semantic versioning: ${diffLogs}`,
  max_tokens: 50
};

// Make the API call
axios.post('https://api.openai.com/v1/chat/completions', payload, {
  headers: {
    'Authorization': `Bearer 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`,
    'Content-Type': 'application/json'
  }
})
.then(response => {
  const suggestion = response.data.choices[0].text;
  console.log(`Extracted Suggestion: ${suggestion}`);
})
.catch(error => {
  console.error(`API Error: ${error}`);
});
