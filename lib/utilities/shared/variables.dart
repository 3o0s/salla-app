import 'package:flutter/material.dart';
import 'package:shopapp/modules/categories_screen.dart';
import 'package:shopapp/modules/favorites_screen.dart';
import 'package:shopapp/modules/products_screen.dart';
import 'package:shopapp/modules/settings.dart';

String? userToken;

enum AppState {
  success,
  error,
  warning,
}

String base64codedimage = '';
String imageUrl =
    'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg';

final phoneNumber = RegExp(r'^[0-9]+$');
GlobalKey<FormState> formKey = GlobalKey<FormState>();
GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
GlobalKey<FormState> profileDataFormKey = GlobalKey<FormState>();
GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

List<Widget> bottomScreen = const [
  ProductScreen(),
  CategoriesScreen(),
  FavoritesScreen(),
  SettingsScreen(),
];

List<BottomNavigationBarItem> bottomNavItems = const [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Product',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.apps_rounded),
    label: 'Gategory',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_border),
    label: 'Favorites',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings_outlined),
    label: 'Settings',
  ),
];
