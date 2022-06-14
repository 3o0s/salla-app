import 'dart:io';

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
String imageUrl = '';

final phoneNumber = RegExp(r'^[0-9]+$');
GlobalKey<FormState> formKey = GlobalKey<FormState>();
GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

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
