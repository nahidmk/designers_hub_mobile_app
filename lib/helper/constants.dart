
final VERSION = '1.0.0';
final ROOT_URL = "http://13.82.95.231:8080";

final GET_ALL_DESIGN = "$ROOT_URL/api/v/${VERSION}/public/designs?page=0&size=10";

final IMAGE_URL = "http://13.82.95.231:8080/api/v/${VERSION}";

final GET_ALL_HOME_PAGE_DESIGN = "$ROOT_URL/api/v/${VERSION}/public/homepage-designs";

final GET_DESIGN_BY_ID = "$ROOT_URL/api/v/${VERSION}/public/designs/id/";



//profile

final SIGN_IN_URL = "$ROOT_URL/api/v/$VERSION/public/users/login";

final SIGN_UP_URL = "$ROOT_URL/api/v/$VERSION/public/customers/sign-up/by/phone-number";

final GET_PROFILE_URL = "$ROOT_URL/api/v/$VERSION/secured/users/profile";
