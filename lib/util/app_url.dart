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
  static var wardByTownshipId = '${baseUrl}wards-by-townshipid';
  static var streetByWardId = '${baseUrl}streets-by-wardid';
  static var shopProduct = '${baseUrl}shop-products';
  static var addRequestShopProduct = '${baseUrl}shopkeeper-request';
  static var requestShopkeeper = '${baseUrl}add-shopkeeper';
  static var deliverWarehouseRequest =
      '{baseUrl}delivered-warehouse-request?page=';
  static var companyProfile = '${baseUrl}profile';
  static var invoice = '${baseUrl}invoice';
  static var addWard = '${baseUrl}add-ward';
  static var cityByCountryId = '${baseUrl}cities-by-countryid';
  static var orderByDate = '${baseUrl}ordersByDate?page=';
  static var barcodeScan = '${baseUrl}barcodescan';
  //delete part
  static var deleteCateById = '${baseUrl}delete-category';
  static var deleteSizeById = '${baseUrl}delete-size';
  static var deleteStreetById = '${baseUrl}delete-street';
  static var deleteWardById = '${baseUrl}delete-ward';
  static var deleteCountryId = '${baseUrl}delete-country';
  static var deleteTownshipId = '${baseUrl}delete-township';
  //edit part

  static var editCategory = '${baseUrl}edit-category';
  static var editSize = '${baseUrl}edit-size';
  static var editUser = '${baseUrl}edit-user';
  static var editProduct = '${baseUrl}edit-product';
  static var editDelivery = '${baseUrl}edit-delivery';
  static var editProfile = '${baseUrl}edit-profile';
  static var editCountry = '${baseUrl}edit-country';
  static var editCity = '${baseUrl}edit-city';
  static var editWard = '${baseUrl}edit-ward';
  static var editTownship = '${baseUrl}edit-township';
}
