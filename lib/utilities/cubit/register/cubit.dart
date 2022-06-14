import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/register_model.dart';
import 'package:shopapp/utilities/cubit/register/states.dart';
import 'package:shopapp/utilities/network/remote/dio_helper.dart';
import 'package:shopapp/utilities/shared/components.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) {
    return BlocProvider.of(context);
  }

  late RegisterModel registerModel;
  void userRegister() {
    emit(RegisterLoadingState());

    DioHelper.postData(
      path: 'register',
      data: {
        'name': '${firstNameController.text} ${lastNameController.text}',
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
      },
    ).then((value) {
      registerModel = RegisterModel.fromjson(value.data);

      if (registerModel.status) {
        emit(RegisterSuccessState(registerModel));
      } else {
        emit(RegisterSuccessState(registerModel));
      }
    }).catchError((error) {
      emit(RegisterErrorState('please check your connection'));
    });
  }
}
