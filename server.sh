npx postgraphile \
  -c postgres:///learn_dev \
  --schema learn \
  --append-plugins @graphile-contrib/pg-simplify-inflector,postgraphile-plugin-connection-filter \
  --enhance-graphiql \
  --allow-explain \
  --watch 
