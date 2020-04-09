server:
	iex -S mix.phx.server

db:
	docker-compose up -db
	mix ecto.setup