abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopLoadingDataState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {
  ShopErrorState(this.err);
  final String err;
}

class ShopChangeBottomNavState extends ShopStates {}
