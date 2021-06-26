
import 'package:designers_hub_modile_app/Provider/order_provider.dart';
import 'package:designers_hub_modile_app/Provider/delivery_address_provider.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Provider/home_page_design_provider.dart';
import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/Provider/tab_provider.dart';
import 'package:designers_hub_modile_app/Screen/home_screen.dart';
import 'package:designers_hub_modile_app/Service/delivery_address_service.dart';
import 'package:designers_hub_modile_app/Service/design_service.dart';
import 'package:designers_hub_modile_app/Service/home_page_desing_service.dart';
import 'package:designers_hub_modile_app/Service/oder_service.dart';
import 'package:designers_hub_modile_app/Service/profile_service.dart';
import 'package:designers_hub_modile_app/Theme/custom_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';


import 'package:flutter/material.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => DesignService());
  GetIt.I.registerLazySingleton(() => HomePageDesignService());
  GetIt.I.registerLazySingleton(() => ProfileService());
  GetIt.I.registerLazySingleton(() => DeliveryAddressService());
  GetIt.I.registerLazySingleton(() => OrderService());

}

void main(){
  setupLocator();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => DesignProvider(),
          ),
          ChangeNotifierProvider(
              create: (_)=> HomePageDesignProvider(),
          ),
          ChangeNotifierProvider(
              create: (_)=>ProfileProvider()
          ),
          ChangeNotifierProvider(
              create: (_)=>TabProvider()
          ),
          ChangeNotifierProvider(
              create: (_)=>DeliveryAddressProvider()
          ),
          ChangeNotifierProvider(
              create: (_)=>OrderProvider()
          ),
        ],
        child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigationKey,
      title: "Designer's Hub",
      theme: CustomTheme(context),
      home: HomeScreen(),
    );
  }
}
