abstract class ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopDataLoadingDataState extends ShopStates {}

class ShopDataSuccessState extends ShopStates {}

class ShopDataErrorState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopAddedOrRemovedFavState extends ShopStates {}

class ShopsuccessgetFavState extends ShopStates {}

class ShopgetFavErrorState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {}

class ProfileLoadingState extends ShopStates {}

class ProfileSuccessState extends ShopStates {
  ProfileSuccessState();
}

class ChangePasswordSuccessState extends ShopStates {}

class ChangePasswordLoadingState extends ShopStates {}
