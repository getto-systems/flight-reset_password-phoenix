defmodule FlightResetPassword.Router do
  use FlightResetPassword.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FlightResetPassword do
    pipe_through :api
  end
end
