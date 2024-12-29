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
