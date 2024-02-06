class AppUrl {
  static var baseUrl = 'https://mmeasyinvoice.com/api/';
  static var loginEndPoint = '${baseUrl}login';
  static var registerEndPoint = '${baseUrl}register';
  static String orderFilterEndPoint(String filterType) =>
      '${baseUrl}filter-orders/$filterType';

  static var warehouse = '${baseUrl}warehouse';
  static var receivedWarehouseRequest =
      '${baseUrl}received-warehouse-request?page=';

  static var addUser = '${baseUrl}add-user';
  static var getUser = '${baseUrl}users?page=';
  static var getAllCategory = '${baseUrl}categories?page=';
  static var getAllSize = '${baseUrl}sizes?page=';
  static var getAllProduct = '${baseUrl}products?page=';
  static var getAllDelivery = '${baseUrl}all-deliveries?page=';
  static var getCountry = '${baseUrl}countries?page=';
  static var getAllCity = '${baseUrl}cities?page=';
  static var addCategory = '${baseUrl}add-category';
  static var addSize = '${baseUrl}add-size';
  static var addFaulty = '${baseUrl}add-faulty-item';
  static var allFaultyItem = '${baseUrl}faulty-item?page=';
  static var addCountry = '${baseUrl}add-country';
  static var addCity = '${baseUrl}add-city';
  static var getAllTownship = '${baseUrl}townships?page=';
  static var getAllWard = '${baseUrl}wards?page=';
  static var getAllStreet = '${baseUrl}streets?page=';
  static var addDeliveryCompanyName = '${baseUrl}add-delivery-companyname';
  static var addProduct = '${baseUrl}add-product';
  static var productByCategoryId = '${baseUrl}productByCategoryId';
  static var addOrder = '${baseUrl}add-order';
  static var townshipByCityId = '${baseUrl}townships-by-cityid';
}
