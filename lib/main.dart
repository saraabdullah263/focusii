import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/features/provider/parent_test_provider.dart';
import 'package:provider/provider.dart';

void main() {
   runApp(
     ChangeNotifierProvider(
      create: (context) => ParentTestProvider(),
      child: const MyApp(),
    ),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
         fontFamily: 'Exo-Bold',
          scaffoldBackgroundColor: AppColors.primaryColor,
       ),
      
        
      ),
    );
  }
}
