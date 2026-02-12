#!/bin/bash

# Create config directory
mkdir -p ~/.picoclaw

# Generate config.json from environment variables
cat <<EOF > ~/.picoclaw/config.json
{
  "agents": {
    "defaults": {
      "workspace": "~/.picoclaw/workspace",
      "model": "\${LLM_MODEL:-glm-4}",
      "max_tokens": \${MAX_TOKENS:-8192},
      "temperature": \${TEMPERATURE:-0.7},
      "max_tool_iterations": \${MAX_TOOL_ITERATIONS:-20}
    }
  },
  "providers": {
    "openrouter": {
      "api_key": "\${OPENROUTER_API_KEY}",
      "api_base": "https://openrouter.ai/api/v1"
    }
    // Add other providers like "gemini": { "api_key": "\${GEMINI_API_KEY}" } as needed
  },
  "tools": {
    "web": {
      "search": {
        "api_key": "\${BRAVE_API_KEY}",
        "max_results": \${MAX_SEARCH_RESULTS:-5}
      }
    }
  },
  "channels": {
    "telegram": {
      "enabled": true,
      "token": "\${TELEGRAM_BOT_TOKEN}"
    }
    // Add other channels like Discord if needed later
  }
}
EOF

# Run PicoClaw in gateway mode
exec ./picoclaw gateway  
