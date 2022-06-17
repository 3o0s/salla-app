import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/catagories_model.dart';
import 'package:shopapp/model/favorites_model.dart';
import 'package:shopapp/model/home_model.dart';
import 'package:shopapp/model/user_model.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';
import 'package:shopapp/utilities/network/end_points.dart';
import 'package:shopapp/utilities/network/remote/dio_helper.dart';
import 'package:shopapp/utilities/shared/components.dart';
import 'package:shopapp/utilities/shared/variables.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState()) {
    getProductsData();
    getCategoriesData();
    getUserData();
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
      categoriesModel = CategoriesModel.fromJson(response.data);

      emit(ShopCategoriesSuccessState());
    }).catchError((err) {});
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    DioHelper.getData(url: favorites, token: userToken).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopsuccessgetFavState());
    }).catchError((error) {
      emit(ShopgetFavErrorState());
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
      if (value.data['status']) {
        final String message = value.data['message'];
        final bool isfav = message == 'Added Successfully';
        fav[id] = isfav ? true : false;
        getFavorites();
        emit(ShopAddedOrRemovedFavState());
        showSnack(
          context,
          state: isfav ? AppState.success : AppState.warning,
          message: message,
        );
      }
    }).catchError((err) {});
  }

  UserModel? usermodel;
  void getUserData() {
    emit(ShopDataLoadingDataState());
    DioHelper.getData(
      url: profile,
      token: userToken,
    ).then((value) {
      usermodel = UserModel.fromjson(value.data);
      firstNameController.text = usermodel!.data!.name.split(' ')[0];
      lastNameController.text = usermodel!.data!.name.split(' ')[1];
      phoneController.text = usermodel!.data!.phone;
      emailController.text = usermodel!.data!.email;
      imageUrl = usermodel!.data!.image;
      emit(ShopDataSuccessState());
    }).catchError((err) {
      emit(ShopDataErrorState());
    });
  }

  void updateUserProfile(context) {
    emit(ProfileLoadingState());

    DioHelper.putData(
      updateProfile,
      token: userToken,
      data: {
        'name': '${firstNameController.text} ${lastNameController.text}',
        'phone': phoneController.text,
        'email': emailController.text,
        'image': base64codedimage,
      },
    ).then((value) {
      emit(ProfileSuccessState());
      showSnack(context, message: 'Updated Successfully');
      getUserData();
    }).catchError((error) {
      showSnack(
        context,
        state: AppState.error,
        message: 'Something went error!',
      );
    });
  }

  Future<String> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      Uint8List bytes = File(result.files.single.path!).readAsBytesSync();
      return base64Encode(bytes);
    } else {
      return '';
    }
  }

  Uint8List base64ToImage(String base64) {
    return base64Decode(base64.split(',').last);
  }

  void changePassword(context) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
      token: userToken,
      path: modifyPassword,
      data: {
        "current_password": passwordController.text,
        "new_password": newPasswordController.text,
      },
    ).then((value) {
      emit(ChangePasswordSuccessState());
      if (value.data['status']) {
        showSnack(context, message: value.data['message']);
      } else {
        showSnack(
          context,
          state: AppState.error,
          message: value.data['message'],
        );
      }
    });
  }
}
