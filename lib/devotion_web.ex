defmodule DevotionWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use DevotionWeb, :controller
      use DevotionWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: DevotionWeb
      import ExCell.Controller
      import Plug.Conn
      import DevotionWeb.Router.Helpers
      import DevotionWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/devotion_web/templates",
                        namespace: DevotionWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import ExCell.View
      import DevotionWeb.Router.Helpers
      import DevotionWeb.ErrorHelpers
      import DevotionWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import DevotionWeb.Gettext
    end
  end

  def cell(opts \\ []) do
    quote do
      use ExCell.Cell, namespace: DevotionWeb,
                       adapter: ExCell.Adapters.CellJS

      use Phoenix.View, root: "lib/devotion_web/cells",
      path: ExCell.View.relative_path(__MODULE__, DevotionWeb),
      pattern: "**/*"

      import Phoenix.Controller,
             only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      use Phoenix.HTML

      import DevotionWeb.Router.Helpers
      import DevotionWeb.Gettext

      # Add everything you want to use in the cells
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
