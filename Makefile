run:
	docker-compose up

local:
	firebase emulators:start

serve:
	cd functions; npm run serve:local

serve-dev:
	cd functions/src; nodemon -e ts --exec "npm run serve:dev"

build:
	docker-compose up --build

kill:
	docker-compose down

export:
	firebase emulators:export ./data

clean:
	flutter clean