import 'package:cubit_test/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    debugPrint('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();
      case DashboardScreen.routeName:
        return DashboardScreen.route();
      case NfcScreen.routeName:
        return NfcScreen.route();
      // case DeliveryTimeScreen.routeName:
      //   return DeliveryTimeScreen.route();
      // case FilterScreen.routeName:
      //   return FilterScreen.route();
      // // case HomeScreen.routeName:
      // //   return HomeScreen.route();
      // case LocationScreen.routeName:
      //   return LocationScreen.route();
      // case RestaurantDetailsScreen.routeName:
      //   return RestaurantDetailsScreen.route(
      //       restaurant: settings.arguments as Restaurant);
      // case RestaurantListingScreen.routeName:
      //   return RestaurantListingScreen.route(
      //       restaurants: settings.arguments as List<Restaurant>);
      // case VoucherScreen.routeName:
      //   return VoucherScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('error'),
        ),
      ),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
