## Action Cable Demo on AnyCable

### Steps to Set Up the Database

[Download](http://www.postgresql.org/download/windows/) and install PostgreSQL.

```bat
psql -U postgres
# or running if in MacOS
# psql -U `whoami` -d postgres
```

```psql
CREATE DATABASE pgac_dev;
GRANT ALL PRIVILEGES ON DATABASE pgac_dev to <current_user>;
```

### Install AnyCable using Homebrew

```bash
brew install anycable-go
```
