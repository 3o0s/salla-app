import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/home_layout.dart';
import 'package:shopapp/modules/register_screen.dart';
import 'package:shopapp/utilities/cubit/login/cubit.dart';
import 'package:shopapp/utilities/cubit/login/states.dart';
import 'package:shopapp/utilities/network/local/cach_helper.dart';
import 'package:shopapp/utilities/shared/components.dart';
import 'package:shopapp/utilities/shared/variables.dart';
import 'package:shopapp/utilities/shared/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) {
          return LoginCubit();
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocConsumer<LoginCubit, LoginStates>(
                    listener: (context, state) {
                  if (state is LoginSuccessState) {
                    if (state.loginModel.status) {
                      CachHelper.saveData(
                        'token',
                        state.loginModel.data!.token,
                      ).then((value) =>
                          navigateAndReplace(context, const HomeLayout()));
                      showSnack(
                        context,
                        message: state.loginModel.message,
                      );
                    }
                  } else if (state is LoginErrorState) {
                    showSnack(
                      context,
                      message: state.error,
                      state: AppState.error,
                    );
                  }
                }, builder: (context, state) {
                  LoginCubit loginCubit = LoginCubit.getLoginCubit(context);
                  return Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Please Enter Your Email and password!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 30.0),
                        defaultFormFeild(
                          controller: LoginCubit.emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? val) {
                            if (val == null || val == '') {
                              return 'Email Cannot Be Empty';
                            } else {
                              return null;
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormFeild(
                            isPassword: loginCubit.isHidden,
                            controller: LoginCubit.passwordController,
                            type: TextInputType.emailAddress,
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
                            onSubmit: (_) {
                              if (formKey.currentState!.validate()) {
                                loginCubit.userLogin();
                              }
                            },
                            prefix: Icons.lock_outline,
                            suffex: loginCubit.isHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            suffexPressed: () {
                              loginCubit.showPassword();
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          fallback: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          builder: (context) {
                            return extednedButton(
                              text: 'Login',
                              isUpperCase: true,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  loginCubit.userLogin();
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
                              'Don\'t have an account?',
                              overflow: TextOverflow.ellipsis,
                            ),
                            TextButton(
                              child: const Text(
                                'Register',
                                style: TextStyle(color: defaultColor),
                              ),
                              onPressed: () =>
                                  navigateTo(context, const RegisterScreen()),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
