### To Do:

- [x] After creating first location, redirect to production page
- [x] Allow adding users directly to an event~~
- [x] Rich text event description field

Marketing landing page

## Maybe:

Recurring events?

Postgres cluster cue-db created
Username: postgres
Password: 6bca1b91c39fc85abca07b8e8d0dc42feeed1c0983491185
Hostname: cue-db.internal
Proxy Port: 5432
PG Port: 5433
Save your credentials in a secure place -- you won't be able to see them again!

Monitoring Deployment

1 desired, 1 placed, 1 healthy, 0 unhealthy [health checks: 3 total, 3 passing]
--> v0 deployed successfully

Connect to postgres
Any app within the personal organization can connect to postgres using the above credentials and the hostname "cue-db.internal."
For example: postgres://postgres:6bca1b91c39fc85abca07b8e8d0dc42feeed1c0983491185@cue-db.internal:5432

Now that you've set up postgres, here's what you need to understand: https://fly.io/docs/reference/postgres-whats-next/

Postgres cluster cue-db is now attached to cue
The following secret was added to cue:
DATABASE_URL=postgres://cue:cUCsCvGRd56ogxH@top2.nearest.of.cue-db.internal:5432/cue
Postgres cluster cue-db is now attached to cue
