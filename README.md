## README

Following the [DHH Rails 5: Action Cable Demo](https://medium.com/@dhh/rails-5-action-cable-demo-8bba4ccfc55e) or [Railscast](http://railscasts-china.com/episodes/action-cable-rails-5) but confirm works at Windows!

Need Rails 5.0.0.beta2 or build from [master](https://github.com/Eric-Guo/rails/commits/pgac_test), for those want to build rails gems in windows, need [remove em-hiredis](https://github.com/Eric-Guo/rails/commit/21e834f324233cfb51f012223e747872e5e150a7).

Thanks @maclover7 [PR to enable using PG as storage](https://github.com/rails/rails/pull/22950) and @matthewd [PR to remove EventMachine](https://github.com/rails/rails/pull/23152), it's now possible to starting using ActionCable in Windows.

### Step to setup the PG DB in Windows

[Download](http://www.postgresql.org/download/windows/) and install, recommand PostgreSQL v9.4.5

```bat
psql -U postgres
```

```psql
CREATE USER pgac WITH PASSWORD 'only_need_in_windows';
CREATE DATABASE pgac_dev;
GRANT ALL PRIVILEGES ON DATABASE pgac_dev to pgac;
```
