npx postgraphile \
  -c postgres://learn_postgraphile:secret_password@localhost/learn_dev \
  --schema learn \
  --append-plugins @graphile-contrib/pg-simplify-inflector,postgraphile-plugin-connection-filter \
  --enhance-graphiql \
  --allow-explain \
  --watch \
  --owner-connection postgres:///learn_dev \
  --default-role learn_anonymous
