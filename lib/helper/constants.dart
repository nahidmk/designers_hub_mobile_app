
final VERSION = '1.0.0';
final ROOT_URL = "http://192.168.0.176:8081";

final GET_ALL_DESIGN = "$ROOT_URL/api/v/${VERSION}/public/designs?page=0&size=10";

final IMAGE_URL = "$ROOT_URL/api/v/${VERSION}";

final GET_ALL_HOME_PAGE_DESIGN = "$ROOT_URL/api/v/${VERSION}/public/homepage-designs";

final GET_DESIGN_BY_ID = "$ROOT_URL/api/v/${VERSION}/public/designs/id/";



//profile

final SIGN_IN_URL = "$ROOT_URL/api/v/$VERSION/public/users/login";
final SIGN_UP_URL = "$ROOT_URL/api/v/$VERSION/public/customers/sign-up/by/phone-number";
final GET_PROFILE_URL = "$ROOT_URL/api/v/$VERSION/secured/users/profile";
final UPDATE_PROFILE_URL = GET_PROFILE_URL;

//order
final ADD_TO_CART = "$ROOT_URL/api/v/$VERSION/orders/customer/cart/update";


//address

final GET_ALL_DELIVERY_ADDRESSES = "$ROOT_URL/api/v/$VERSION/secured/delivery-addresses/customer";
final POST_DELIVERY_ADDRESS = "$ROOT_URL/api/v/$VERSION/secured/delivery-addresses/customer/create";
final UPDATE_DELIVERY_ADDRESS = "$ROOT_URL/api/v/$VERSION/secured/delivery-addresses/customer/update";
final DELETE_DELIVERY_ADDRESS = "$ROOT_URL/api/v/$VERSION/secured/delivery-addresses/customer/delete";
