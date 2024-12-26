import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_mobile/feature/account/account_screen.dart';
import 'package:pos_mobile/feature/authentication/login/login_screen.dart';
import 'package:pos_mobile/feature/authentication/register/register_screen.dart';
import 'package:pos_mobile/feature/cart/cart_screen.dart';
import 'package:pos_mobile/feature/change_password/change_password_screen.dart';
import 'package:pos_mobile/feature/history/history_screen.dart';
import 'package:pos_mobile/feature/home/home_screen.dart';
import 'package:pos_mobile/feature/menu/menu_screen.dart';
import 'package:pos_mobile/feature/navigation/navigation_screen.dart';
import 'package:pos_mobile/feature/notification/notification_screen.dart';
import 'package:pos_mobile/firebase_options.dart';
import 'package:pos_mobile/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'app/bloc/authentication_bloc.dart';
import 'provider/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context)=>AuthenticationBloc()),
        ChangeNotifierProvider(create: (context)=>CartProvider()),
        ChangeNotifierProvider(create: (context)=>TransactionProvider())

      ],
      child: MaterialApp(
        initialRoute: 'login',
        routes: {
          'register' : (context)=>const RegisterScreen(),
          'login' :(context)=>const LoginScreen(),
          'LayoutNavbar' :(context)=>const NavigationScreen()
        },
      ),
      );
  }
}