npx postgraphile \
  -c postgres:///learn_dev \
  --schema learn \
  --append-plugins @graphile-contrib/pg-simplify-inflector \
  --enhance-graphiql \
  --allow-explain \
  --watch 
