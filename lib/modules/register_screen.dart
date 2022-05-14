import 'package:flutter/material.dart';
import 'package:shopapp/utilities/cubit/login/cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Register',
            style: Theme.of(context).textTheme.headline5,
          ),
          titleSpacing: 20),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: ${LoginCubit.emailController.text}'),
            Text('Password: ${LoginCubit.passwordController.text}'),
          ],
        ),
      ),
    );
  }
}
