import Config

if Mix.env() == :dev do
  config(:gen_chatting_mnesia, node_env: :dev)
end
