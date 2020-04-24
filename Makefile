server:
	iex -S mix phx.server

db:
	docker-compose up
	mix ecto.setup