# Mastodon ansible role

This is an ansible role for installing mastodon on comwork cloud.

We got our own instance here: https://mastodon.comwork.io

## Install PostgreSQL on comwork cloud

Install PostgreSQL [this tutorial](https://doc.cloud.comwork.io/docs/tutorials/dbaas).

Don't forget the backup part with [bucket-backup](https://gitlab.comwork.io/oss/bucket-backup), that's important!

## Init mastodon

Add this role to your infra git repo and add it in the playbook.

The settings to change are [here](./defaults/main.yml). You have to replace all the value containing `changeit` except those three you'll change after the first deployments:

```yaml
mastodon_secret_key: changeit
mastodon_vapid_private_key: changeit
mastodon_vapid_public_key: changeit
```

Run a first deployment (push on your gitops repo), then run this command on the server:

```shell
docker-compose -f docker-compose-mastodon.yml run --rm shell bundle exec rake secret
```

Replace the `mastodon_secret_key` variable with the returned value.

Then:

```shell
docker-compose -f docker-compose-mastodon.yml run --rm shell bundle exec rake mastodon:webpush:generate_vapid_key
```

Replace the `mastodon_vapid_private_key` and `mastodon_vapid_public_key` with the returned values.

Then, run the database migrations:

```shell
docker-compose -f docker-compose-mastodon.yml run --rm shell bundle exec rake db:migrate
```
