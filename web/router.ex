defmodule Budget.Router do
  use Budget.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Budget do
    pipe_through :browser # Use the default browser stack
    
    get "/", TransactionController, :index
    get "/transactions/new", TransactionController, :new
    post "/transactions", TransactionController, :create
    get "/transactions", TransactionController, :index
    get "/transactions/:id/edit", TransactionController, :edit
    put "/transactions/:id", TransactionController, :update                                                                      
    delete "/transactions/:id", TransactionController, :delete
    get "/transactions_roman", TransactionController, :index_roman
    #resources "/", TransactionController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Budget do
  #   pipe_through :api
  # end
end
