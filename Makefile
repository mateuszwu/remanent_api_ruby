start:
	docker-compose up
restart:
	docker-compose restart
bundle:
	docker-compose run --rm web bundle install
db_create:
	docker-compose run --rm web bundle exec rake db:create
db_migrate:
	docker-compose run --rm web bundle exec rake db:migrate
db_seed:
	docker-compose run --rm web bundle exec rake db:seed
