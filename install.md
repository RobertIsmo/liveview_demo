# Phoenix, (SQLite3, Ecto), Tailwind

1. mix archive.install hex phx_new
2. mix phx.new liveview_demo --database sqlite3
3. cd liveview_demo
4. mix ecto.create
5. mix phx.gen.auth Accounts User users
6. mix deps.get
7. mix ecto.migrate
8. mix test

mix.exs
```elixir
      extra_applications: [:logger, :runtime_tools, :os_mon]
```

*run:* iex -S mix phx.server
