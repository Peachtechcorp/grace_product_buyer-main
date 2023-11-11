import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_product_buyer/app/pages/auth/login.dart';
import 'package:grace_product_buyer/app/pages/home_page/home_page.dart';
import 'package:grace_product_buyer/app/pages/loading/loading.dart';
import 'package:grace_product_buyer/app/providers/agent_provider.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/providers/cart_provider.dart';
import 'package:grace_product_buyer/app/providers/category_provider.dart';
import 'package:grace_product_buyer/app/providers/home_provider.dart';
import 'package:grace_product_buyer/app/providers/notification_provider.dart';
import 'package:grace_product_buyer/app/providers/order_provider.dart';
import 'package:grace_product_buyer/app/providers/product_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (BuildContext context) => ProductProvider(
            Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (BuildContext context, AuthProvider auth,
                  ProductProvider? product) =>
              ProductProvider(auth),
        ),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => AgentProvider()),
        ChangeNotifierProxyProvider<AuthProvider, CategoryProvider>(
          create: (BuildContext context) => CategoryProvider(
            Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (BuildContext context, AuthProvider auth,
                  CategoryProvider? product) =>
              CategoryProvider(auth),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grace Product Buyer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: page,
      ),
      home: const Router(),
    );
  }
}

class Router extends StatelessWidget {
  const Router({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        switch (auth.status) {
          case AuthStatus.uninitialized:
            return const LoadingPage();
          case AuthStatus.authenticated:
            return const HomePage();
          case AuthStatus.unaunthenticated:
            return const LoginPage();
          default:
            return const LoginPage();
        }
      },
    );
  }
}
