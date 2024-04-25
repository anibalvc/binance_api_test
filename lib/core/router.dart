import 'package:binance_api_test/views/auth/create_account/create_account_view.dart';
import 'package:binance_api_test/views/auth/login/login_view.dart';
import 'package:binance_api_test/views/graficos/volumen/volumen_view.dart';
import 'package:binance_api_test/views/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../views/home/home_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());

    case SplashPage.route:
      return MaterialPageRoute(builder: (context) => const SplashPage());

    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());

    case CreateAccountView.routeName:
      return MaterialPageRoute(builder: (context) => const CreateAccountView());

    case VolumenView.routeName:
      return MaterialPageRoute(builder: (context) => const VolumenView());

    default:
      return MaterialPageRoute(builder: (context) => const HomeView());
  }
}
