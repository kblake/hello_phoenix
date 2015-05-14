defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/users", UserController do
      resources "posts", PostController
    end

    resources "/reviews", ReviewController
  end

  scope "/admin", as: :admin do
    pipe_through :browser

    scope "v1", V1, as: :v1 do
      resources "/reviews", ReviewController
      resources "/images",  ImageController
      resources "/users",   UserController
    end
  end

  socket "/ws", HelloPhoenix do
    channel "rooms:*", RoomChannel
    channel "placess:*", PlaceChannel, via: [WebSocket]
    channel "foods:*", FoodChannel
  end

  socket "/another_ws", HelloPhoenix do
    channel "news:*", NewsChannel
    channel "pets:*", PetChannel
    channel "conversations:*", ConversationChannel, via: [LongPoller]
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloPhoenix do
  #   pipe_through :api
  # end
end
