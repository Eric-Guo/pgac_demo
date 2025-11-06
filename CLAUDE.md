# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 7.2 application that implements a **real-time chat application with AI integration** using:
- **Action Cable** with **AnyCable** for WebSocket-based real-time communication
- **Redis** as the pub/sub adapter for broadcasting messages
- **RubyLLM** for AI/LLM integration (supports DeepSeek, Dify, OpenAI, and other providers)
- **Sidekiq** for background job processing
- **SQLite** as the development database

## Quick Start Commands

```bash
# Install dependencies
bundle install

# Start required services
brew services start redis

# Launch all processes (web, AnyCable, WebSocket server, Sidekiq)
overmind start

# Visit http://localhost:3000

# Run tests
bundle exec rails test
```

## Development Commands

```bash
# Run single test file
bundle exec rails test test/models/message_test.rb

# Run Rails server manually (if not using overmind)
bin/rails s -p 3000

# Start Sidekiq manually
bundle exec sidekiq

# Reset database
bin/rails db:drop db:create db:migrate db:seed
```

## Architecture

### Core Flow (app/channels/room_channel.rb:11-14)
1. Client sends message via WebSocket → `RoomChannel#speak`
2. Message saved to database → `Message.create!`
3. `AskForLLMJob` enqueued to Sidekiq (app/sidekiq/ask_for_llm_job.rb:4)
4. `MessageBroadcastJob` broadcasts message to all connected clients (app/models/message.rb:3)
5. LLM processes message asynchronously and responds
6. AI response broadcast to all clients in real-time

### Key Components

**Channels:**
- `app/channels/room_channel.rb` - WebSocket channel handler for real-time chat

**Models:**
- `app/models/message.rb` - Message model, triggers broadcast after create
- `app/models/user.rb` - User model, identifies AI users by `ai_assistant?` method
- `app/models/current.rb` - ActiveSupport::CurrentAttributes for current user context

**Jobs (Sidekiq):**
- `app/sidekiq/ask_for_llm_job.rb` - Processes messages through LLM and streams responses
- `app/sidekiq/message_broadcast_job.rb` - Broadcasts messages to WebSocket clients

**Controllers:**
- `app/controllers/rooms_controller.rb` - Serves chat interface at root path
- `app/controllers/chats_controller.rb` - Handles message cleanup

**Views:**
- `app/views/rooms/show.html.erb` - Main chat interface
- `app/views/messages/_message.html.erb` - Message rendering partial

**Client-Side:**
- `app/assets/javascripts/channels/room.js` - WebSocket client for RoomChannel subscription
- `app/assets/javascripts/cable.js` - Action Cable consumer setup

### Database Schema (db/schema.rb:13-30)
- `messages` table: content (text), user_id (foreign key), conversation_id (string)
- `users` table: fingerprint (string identifier)

## Configuration

### Required Environment Variables
```bash
DEEPSEEK_API_KEY=sk-your-key              # Required for DeepSeek provider
# RubyLLM supports: OPENAI_API_KEY, ANTHROPIC_API_KEY, GEMINI_API_KEY, DIFY_API_KEY, etc.
```

### Key Configuration Files
- `config/cable.yml` - Action Cable adapter configuration (defaults to AnyCable)
- `config/anycable.yml` - AnyCable server settings, HTTP broadcast adapter
- `config/initializers/ruby_llm.rb` - RubyLLM configuration, default model: "deepseek-chat"
- `Procfile.dev` - Overmind process definition for development
- `.overmind.env` - Overmind configuration (disables telemetry, enables public streams)

### LLM Integration (app/sidekiq/ask_for_llm_job.rb:1-27)
- Uses `RubyLLM.chat` for conversation management
- Streams responses to clients via Action Cable (app/sidekiq/ask_for_llm_job.rb:22-23)
- Maintains conversation context across messages
- Splits "think" tags from responses for better display (app/helpers/application_helper.rb:2-29)

## Technical Details

### WebSocket URL
- Local development: `ws://localhost:8080/cable` (AnyCable-Go WebSocket server)
- Production: Configured in `config/anycable.yml:32`

### User Identification
- Users identified by browser fingerprint (via FingerprintJS)
- AI assistant users have `fingerprint` values that don't parse to positive integers (app/models/user.rb:4-6)

### Message Flow
1. User submits message → `room.js:35-38`
2. `RoomChannel#speak` creates user and message
3. `MessageBroadcastJob` broadcasts user message immediately
4. `AskForLLMJob` processes through LLM
5. AI response streamed in chunks to all clients
6. Final message saved with conversation_id

### Testing
- Uses Rails Minitest
- Test files mirror app structure (e.g., `test/models/message_test.rb`)
- Integration tests in `test/integration/`

## Deployment

- Capistrano configuration in `config/deploy.rb` and `Capfile.rb`
- Dockerfile available for containerized deployment
- Sidekiq web interface mounted at `/sidekiq` (config/routes.rb:12)
