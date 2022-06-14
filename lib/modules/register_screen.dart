import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/home_layout.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/utilities/cubit/register/cubit.dart';
import 'package:shopapp/utilities/cubit/register/states.dart';
import 'package:shopapp/utilities/network/local/cach_helper.dart';
import 'package:shopapp/utilities/shared/components.dart';
import 'package:shopapp/utilities/shared/variables.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.registerModel.status) {
            CachHelper.saveData(
              'token',
              state.registerModel.data!.token,
            ).then((value) {
              userToken = state.registerModel.data!.token;
              navigateAndReplace(context, const HomeLayout());
              showSnack(
                context,
                message:
                    'Hello ${state.registerModel.data!.name.split(' ')[0]}',
              );
            });
          } else {
            showSnack(
              state: AppState.warning,
              context,
              message: state.registerModel.message,
            );
          }
        } else if (state is RegisterErrorState) {
          showSnack(
            context,
            state: AppState.error,
            message: state.error,
          );
        }
      }, builder: (context, state) {
        RegisterCubit registerCubit = RegisterCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Please Enter Your Information!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                            child: defaultFormFeild(
                              controller: firstNameController,
                              label: 'First Name',
                              validate: (String? val) {
                                if (val == null || val == '') {
                                  return 'First Name Cannot Be Empty';
                                } else {
                                  return null;
                                }
                              },
                              prefix: null,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: defaultFormFeild(
                              controller: lastNameController,
                              label: 'Last name',
                              validate: (String? val) {
                                if (val == null || val == '') {
                                  return 'Last name Cannot Be Empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormFeild(
                        label: 'Email Adress',
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? val) {
                          if (val == null || val == '') {
                            return 'Email Cannot Be Empty';
                          } else if (val.length < 6) {
                            return 'Email Is too Short';
                          } else {
                            return null;
                          }
                        },
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormFeild(
                        controller: passwordController,
                        type: TextInputType.text,
                        validate: (String? val) {
                          if (val == null || val == '') {
                            return 'Password Cannot Be Empty';
                          } else if (val.length < 6) {
                            return 'Password Is too Short';
                          } else {
                            return null;
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormFeild(
                        controller: phoneController,
                        type: TextInputType.number,
                        validate: (String? val) {
                          if (val == null || val == '') {
                            return 'Phone Number Cannot Be Empty';
                          } else if (!phoneNumber
                                  .hasMatch(phoneController.text) ||
                              phoneController.text.length < 11) {
                            return 'Phone Number Is Not Valid';
                          } else {
                            return null;
                          }
                        },
                        label: 'Phone number',
                        onSubmit: (_) {
                          if (registerFormKey.currentState!.validate()) {
                            registerCubit.userRegister();
                          }
                        },
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        fallback: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        builder: (context) {
                          return extednedButton(
                            text: 'Register',
                            isUpperCase: true,
                            function: () {
                              if (registerFormKey.currentState!.validate()) {
                                registerCubit.userRegister();
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Do you have an account?',
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextButton(
                            child: const Text(
                              'Login',
                            ),
                            onPressed: () => navigateTo(
                              context,
                              const LoginScreen(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
