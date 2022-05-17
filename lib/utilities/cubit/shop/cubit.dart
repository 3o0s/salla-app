import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/catagories_model.dart';
import 'package:shopapp/model/favorites_model.dart';
import 'package:shopapp/model/home_model.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';
import 'package:shopapp/utilities/network/end_points.dart';
import 'package:shopapp/utilities/network/remote/dio_helper.dart';
import 'package:shopapp/utilities/shared/components.dart';
import 'package:shopapp/utilities/shared/variables.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState()) {
    getProductsData();
    getCategoriesData();
  }
  static ShopCubit get(context) => BlocProvider.of(context);
//Bottom navigation bar
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    if (index == 2) {
      getFavorites();
    }
    emit(ShopChangeBottomNavState());
  }

// products data loading
  Map<int, bool> fav = {};
  HomeModel? homeModel;
  void getProductsData() {
    emit(ShopDataLoadingDataState());
    DioHelper.getData(
      url: home,
      token: userToken,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        fav.addAll(
          {
            element.id: element.inFavorites,
          },
        );
      }
      emit(ShopDataSuccessState());
    }).catchError((err) {
      emit(ShopDataErrorState());
    });
  }

  //categories
  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: getCategories).then((response) {
      categoriesModel = CategoriesModel.fromJson(catmodel);

      emit(ShopCategoriesSuccessState());
    }).catchError((err) {
      print(err);
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    DioHelper.getData(url: favorites, token: userToken).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
    }).catchError((error) {
      print(error);
    });
  }

  void addOrRemoveFromFav(context, {required int id}) {
    DioHelper.postData(
      path: favorites,
      token: userToken,
      data: {
        'product_id': id,
      },
    ).then((value) {
      print(value.data);
      if (value.data['status']) {
        final String message = value.data['message'];
        final bool isfav = message == 'Added Successfully';
        fav[id] = isfav ? true : false;
        emit(ShopAddedOrRemovedFavState());
        showSnack(
          context,
          state: isfav ? AppState.success : AppState.warning,
          message: message,
        );
      }
    }).catchError((err) {
      print(err);
    });
  }
}


/*

{"status":true,"message":"Added Successfully","data":
{"id":65226,"product":
{"id":54,"price":11499,"old_price":12499,"discount":8,"image":"https://student.valuxapps.com/storage/uploads/products/1615441020ydvqD.item_XXL_51889566_32a329591e022.jpeg"}}}

*/