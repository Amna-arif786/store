require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "creates a product with its price and displays it" do
    assert_difference("Product.count", 1) do
      post products_url, params: { product: { name: "Widget", price: "19.99" } }
    end

    product = Product.find_by!(name: "Widget")
    assert_equal BigDecimal("19.99"), product.price
    assert_redirected_to product_url(product)

    follow_redirect!
    assert_select "h1", "Widget"
    assert_select "p", "Price: 19.99"

    get products_url
    assert_select "a[href=?]", product_url(product), text: "Widget"
    assert_select "p", "Price: 19.99"
  end
end
