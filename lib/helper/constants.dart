
final VERSION = '1.0.0';
// final ROOT_URL = "http://192.168.0.176:8081";
final ROOT_URL = "http://13.82.95.231:8080";

final PUBLIC_API_URL = '$ROOT_URL/api/v/$VERSION/public';
final SECURED_API_URL = '$ROOT_URL/api/v/$VERSION/secured';

final GET_ALL_DESIGN = "$PUBLIC_API_URL/designs?page=0&size=10";

final IMAGE_URL = "$ROOT_URL/api/v/${VERSION}";

final GET_ALL_HOME_PAGE_DESIGN = "$PUBLIC_API_URL/homepage-designs";

final GET_DESIGN_BY_ID = "$PUBLIC_API_URL/designs/id/";



//profile

final SIGN_IN_URL = "$PUBLIC_API_URL/users/login";
final SIGN_UP_URL = "$PUBLIC_API_URL/customers/sign-up/by/phone-number";
final GET_PROFILE_URL = "$ROOT_URL/api/v/$VERSION/secured/users/profile";
final UPDATE_PROFILE_URL = GET_PROFILE_URL;

//order
final CART_UPDATE = "$SECURED_API_URL/orders/customer/cart/update";
final PLACE_ORDER = "$SECURED_API_URL/orders/customer/create";
final GET_ALL_ORDER = "$SECURED_API_URL/orders";
final GET_ORDER_BY_ID = "$SECURED_API_URL/orders/";


//address

final GET_ALL_DELIVERY_ADDRESSES = "$SECURED_API_URL/delivery-addresses/customer";
final POST_DELIVERY_ADDRESS = "$SECURED_API_URL/delivery-addresses/customer/create";
final UPDATE_DELIVERY_ADDRESS = "$SECURED_API_URL/delivery-addresses/customer/update";
final DELETE_DELIVERY_ADDRESS = "$SECURED_API_URL/delivery-addresses/customer/delete";
