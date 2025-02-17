defmodule SupermarketWeb.Products.Index do
  @moduledoc """
  Index liveview to work with products
  """
  use Phoenix.LiveView

  alias Supermarket.Orders.CartManager
  alias Supermarket.Products.ProductManager

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       loading: false,
       products: ProductManager.get_all(),
       cart_code: nil,
       error_cart_code: false
     )}
  end

  def handle_event("save_form", %{"cart_code" => name}, socket) do
    if name == "" do
      {:noreply, assign(socket, error_cart_code: true)}
    else
      {:noreply,
       assign(socket, error_cart_code: false, cart_code: name, cart: CartManager.get_cart(name))}
    end
  end

  def handle_event("update_form", %{"cart_code" => _name}, socket) do
    {:noreply, assign(socket, error_cart_code: false)}
  end

  def handle_event("add_product", %{"code" => code}, socket) do
    product_codes =
      socket.assigns.cart.product_codes ++ [code]

    CartManager.update_cart(socket.assigns.cart_code, product_codes)

    {:noreply,
     assign(socket,
       cart: CartManager.get_cart(socket.assigns.cart_code)
     )}
  end
end
