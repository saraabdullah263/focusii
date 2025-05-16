import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/api/api_servecis.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/features/auth/data/repos/auth_repo_imp.dart';
import 'package:focusi/features/auth/model_veiw/forget_pasword_cubit/password_cubit.dart';
import 'package:focusi/features/auth/model_veiw/login_cubit/login_cubit.dart';
import 'package:focusi/features/auth/model_veiw/sign_up_cubit/sign_up_cubit.dart';
import 'package:focusi/features/provider/parent_test_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init(); 
  
  final dio = Dio();
  final apiService = ApiServecis(dio);
  final authRepo = AuthRepoImp(dio, apiService: apiService);
   runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParentTestProvider()),
        BlocProvider(create: (_) => SignUpCubit(authRepo)),
        BlocProvider(create: (_)=>LoginCubit(authRepo)),
        BlocProvider(create: (_)=>PasswordCubit(authRepo)),
      ],
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
