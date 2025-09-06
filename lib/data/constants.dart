class Endpoints {
  static const baseUrl = "https://watchstore.sasansafari.com$versionRoute";
  static const versionRoute = "/public/api/v1";
  static const sendSms = "$baseUrl/send_sms";
  static const checkSmsCode = "$baseUrl/check_sms_code";
  static const register = "$baseUrl/register";
  static const productByBrand = "$baseUrl/products_by_brand/";
  static const productByCategory = "$baseUrl/products_by_category/";
  static const productBySearch = "$baseUrl/all_products/";
  static const home = "$baseUrl/home";
  static const productDetails = "$baseUrl/product_details/";
  static const userCart = "$baseUrl/user_cart";
  static const addToCart = "$baseUrl/add_to_cart";
  static const removeFromCart = "$baseUrl/remove_from_cart";
  static const deleteFromCart = "$baseUrl/delete_from_cart";
  static const totalCartPrice = "$baseUrl/total_cart_price";
  static const getProfileInfo = "$baseUrl/profile";
  static const getUserAddresses = "$baseUrl/user_addresses";
  static const getReceivedOrders = "$baseUrl/user_received_orders";
  static const getProcessingOrders = "$baseUrl/user_processing_orders";
  static const getCanceledOrders = "$baseUrl/user_cancelled_orders";
  static const getBrands = "$baseUrl/brands";
  static const payment = "$baseUrl/payment";
}

// class ProductSortRoutes {
//   static const newestProducts = "/newest_products";
//   static const cheapestProducts = "/cheapest_products";
//   static const mostExpensiveProducts = "/most_expensive_products";
//   static const mostViewedProducts = "/most_viewed_products";
// }
