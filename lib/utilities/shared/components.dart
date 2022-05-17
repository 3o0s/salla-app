import 'package:flutter/material.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/utilities/network/local/cach_helper.dart';
import 'package:shopapp/utilities/shared/theme.dart';
import 'package:shopapp/utilities/shared/variables.dart';

Color messageColor(AppState state) {
  switch (state) {
    case AppState.success:
      return Colors.green;
    case AppState.warning:
      return Colors.yellowAccent;
    case AppState.error:
      return Colors.red;
  }
}

void showSnack(
  context, {
  required String message,
  AppState state = AppState.success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: messageColor(state),
  ));
}

// void showBottomToast(
//   context, {
//   required String message,
//   AppState state = AppState.success,
// }) {
//   showToast(
//     message,
//     backgroundColor: messageColor(state),
//     context: context,
//     reverseAnimation: StyledToastAnimation.none,
//     animation: StyledToastAnimation.none,
//   );
// }
void signout(BuildContext context) {
  CachHelper.removeData('token');
  navigateAndReplace(context, const LoginScreen());
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}

void navigateAndReplace(BuildContext context, Widget widget) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}

Widget separator() => Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 1,
        color: Colors.black12,
      ),
    );
Widget extednedButton({
  required String text,
  bool isUpperCase = false,
  required Function() function,
  Color? color = defaultColor,
  Color? textColor = Colors.white,
  double radius = 5,
  double width = double.infinity,
  double height = 40,
}) =>
    Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      width: width,
      height: height,
      child: TextButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
        onPressed: function,
      ),
    );

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String? value) validate,
  Function(String value)? onSubmit,
  Function(String value)? onChange,
  Function()? suffexPressed,
  Function()? prefixPressed,
  Function()? onTap,
  required String label,
  required IconData prefix,
  IconData? suffex,
  bool isPassword = false,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
          label: Text(label),
          prefixIcon: IconButton(
            icon: Icon(prefix),
            onPressed: prefixPressed,
          ),
          suffixIcon: suffex != null
              ? IconButton(
                  onPressed: suffexPressed,
                  icon: Icon(suffex),
                )
              : null,
          border: const OutlineInputBorder()),
    );
