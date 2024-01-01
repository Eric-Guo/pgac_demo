## Action Cable Demo on AnyCable

### Install AnyCable & Redis using Homebrew

```bash
brew install anycable-go redis
```

### Running

```bash
brew services start redis
overmind start -f Procfile.dev
```

### Testing

```bash
acli --url=ws://localhost:8080/cable --channel=RoomChannel
\p speak message:from_console_test
^d
```
