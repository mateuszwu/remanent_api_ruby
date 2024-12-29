# How to Setup App
- Create DB on render.com
- Attach DB to the app on the Heroku - set db url variable
- Run: `rails db:migrate`, `rails db:seed`

## TODO after each year
- dump db from render.com `pg_dump RENDER_COM_EXTERNAL_DB_URL > db/render_db_dump`
- Save it on a new branch `render_db_dump_YEAR`
- Check for new `products` and add them to the seeds.
```
Product.all.each do |product|
  puts "{ barcode: %{#{product.barcode}}, name: %{#{product.name}}, unit: %{#{product.unit}} },"
end
```

### Restoring DUMPED DB
Run:
- `rails db:drop`
- `rails db:create`
- `psql -h 127.0.0.1 -U postgres -p 5432 -c 'CREATE ROLE delicjusz_remanent_be_user;'`
- `psql -h 127.0.0.1 -U postgres -p 5432 remanent_api_ruby_development < db/render_db_dump`
