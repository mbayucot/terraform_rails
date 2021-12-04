build:
	docker-compose build

start:
	docker-compose up

restart:
	make stop && make start

stop:
	docker-compose stop

login:
	docker exec -it demo_api bash