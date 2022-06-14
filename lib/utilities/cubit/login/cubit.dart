import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/user_model.dart';
import 'package:shopapp/utilities/cubit/login/states.dart';
import 'package:shopapp/utilities/network/end_points.dart';
import 'package:shopapp/utilities/network/remote/dio_helper.dart';
import 'package:shopapp/utilities/shared/components.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  bool isHidden = true;
  void showPassword() {
    isHidden = !isHidden;
    emit(PasswordVisibleState());
  }

  static LoginCubit getLoginCubit(BuildContext context) =>
      BlocProvider.of(context);

  late UserModel loginModel;

  void userLogin() async {
    emit(LoginLoadingState());

    await DioHelper.postData(path: login, data: {
      'email': emailController.text,
      'password': passwordController.text,
    }).then((value) {
      loginModel = UserModel.fromjson(value.data);
      if (loginModel.status) {
        emit(LoginSuccessState(loginModel));
      } else {
        emit(LoginErrorState(loginModel.message ?? ''));
      }
    }).catchError((err) {
      emit(LoginErrorState('please check your connection'));
    });
  }
}
