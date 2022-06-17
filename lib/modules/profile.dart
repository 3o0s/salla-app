import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/utilities/cubit/shop/cubit.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';
import 'package:shopapp/utilities/shared/components.dart';
import 'package:shopapp/utilities/shared/variables.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Edit profile',
              style: TextStyle(fontSize: 25),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: IconButton(
                                onPressed: () async {
                                  shopCubit.pickImage().then((value) {
                                    base64codedimage = value;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: profileDataFormKey,
                        child: Column(
                          children: [
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
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: defaultFormFeild(
                                    validate: (String? val) {
                                      if (val == null || val == '') {
                                        return 'Last Name Cannot Be Empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: lastNameController,
                                    label: 'Last name',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormFeild(
                              validate: (String? val) {
                                if (val == null || val == '') {
                                  return 'Email Adress Cannot Be Empty';
                                } else {
                                  return null;
                                }
                              },
                              controller: emailController,
                              label: 'Email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormFeild(
                              validate: (String? val) {
                                if (val == null || val == '') {
                                  return 'Phone Number Cannot Be Empty';
                                } else {
                                  return null;
                                }
                              },
                              controller: phoneController,
                              label: 'Phone number',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ConditionalBuilder(
                              condition: true,
                              fallback: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              builder: (context) {
                                return extednedButton(
                                  text: 'Edit Data',
                                  isUpperCase: true,
                                  function: () {
                                    if (profileDataFormKey.currentState!
                                        .validate()) {
                                      ShopCubit.get(context)
                                          .updateUserProfile(context);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  separator(),
                  Form(
                    key: changePasswordFormKey,
                    child: Column(
                      children: [
                        defaultFormFeild(
                          isPassword: true,
                          controller: passwordController,
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
                          label: 'Current Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultFormFeild(
                          isPassword: true,
                          controller: newPasswordController,
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
                          label: 'NewPassword',
                          onSubmit: (_) {},
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        extednedButton(
                          text: 'Change Password',
                          isUpperCase: true,
                          color: Colors.red,
                          function: () {
                            if (changePasswordFormKey.currentState!
                                .validate()) {
                              shopCubit.changePassword(context);
                            }
                            //TODO: change
                            // ShopCubit.get(context).updateUserProfile(context);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ), //here
            ),
          ),
        );
      },
    );
  }
}
