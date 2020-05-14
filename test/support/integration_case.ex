defmodule CookpodWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use CookpodWeb.AuthCase
      use PhoenixIntegration
      import Cookpod.Factory
    end
  end
end
