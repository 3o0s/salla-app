import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/catagories_model.dart';
import 'package:shopapp/model/home_model.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';
import 'package:shopapp/utilities/network/end_points.dart';
import 'package:shopapp/utilities/network/remote/dio_helper.dart';
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
    emit(ShopChangeBottomNavState());
  }

// products data loading

  HomeModel? homeModel;
  void getProductsData() {
    emit(ShopDataLoadingDataState());
    DioHelper.getData(
      url: home,
      token: userToken,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

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
      print(categoriesModel!.categoriesData.data[0].image);

      emit(ShopCategoriesSuccessState());
    }).catchError((err) {
      print(err);
    });
  }
}
