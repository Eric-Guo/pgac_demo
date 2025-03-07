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

### Testing in Browser

Visit [https://play.anycable.io/](https://play.anycable.io/) and type `wss://pgac.redwoodjs.cn:3334/cable`.

### Deploy consume

About 300MB memory
