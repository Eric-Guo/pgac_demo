## Live Demo:

https://pgacdemo.herokuapp.com

## Action Cable demo on PostgreSQL and Windows

Following the [DHH Rails 5: Action Cable Demo](https://medium.com/@dhh/rails-5-action-cable-demo-8bba4ccfc55e) or [Railscast](http://railscasts-china.com/episodes/action-cable-rails-5) but confirm works at Windows!

Need Rails 5.0.0.beta3.

Thanks @maclover7 [PR to enable using PG as storage](https://github.com/rails/rails/pull/22950) and @matthewd [PR to remove EventMachine](https://github.com/rails/rails/pull/23152) [Round 2](https://github.com/rails/rails/pull/23305), it's now possible to starting using ActionCable in Windows.

### Step to setup the PG DB in Windows

[Download](http://www.postgresql.org/download/windows/) and install, recommand PostgreSQL v9.4.5

```bat
psql -U postgres
# or running if in MacOS
# psql -U `whoami` -d postgres
```

```psql
CREATE DATABASE pgac_dev;
GRANT ALL PRIVILEGES ON DATABASE pgac_dev to <current_user>;
```

### Heroku Deploy

```bash
heroku create
git push heroku master
heroku run rake db:migrate
heroku open
```
