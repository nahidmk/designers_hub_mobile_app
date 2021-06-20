
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Provider/home_page_design_provider.dart';
import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/Service/design_service.dart';
import 'package:designers_hub_modile_app/Service/home_page_desing_service.dart';
import 'package:designers_hub_modile_app/Service/profile_service.dart';
import 'package:designers_hub_modile_app/Theme/custom_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';

import '../Screen/home_screen.dart';
import 'package:flutter/material.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => DesignService());
  GetIt.I.registerLazySingleton(() => HomePageDesignService());
  GetIt.I.registerLazySingleton(() => ProfileService());
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
