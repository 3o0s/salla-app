import 'package:flutter/material.dart';

double mediaQuarywidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

int itemCount(BuildContext context) {
  return (mediaQuarywidth(context) - 20) ~/ 220;
}

double paddingWidth(BuildContext context) {
  double x = mediaQuarywidth(context) -
      (itemCount(context) * 220) -
      (itemCount(context) - 1) * 10;
  if (x.isNegative || x == 0) {
    return 10;
  } else {
    return x;
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(paddingWidth(context));
    var gridView = GridView.count(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth(context)),
        crossAxisCount: itemCount(context),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [...wid]);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Register',
            style: Theme.of(context).textTheme.headline5,
          ),
          titleSpacing: 20),
      body: gridView,
      //   Container(
      // padding: EdgeInsets.symmetric(horizontal: 10),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     newMethod(context),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     newMethod(context),
      //   ],
      // ),
      // )
    );
  }
}

Widget t(context) {
  return TextButton(
      onPressed: () {
        print(paddingWidth(context));
      },
      child: Text('data'));
}

String Image = '';
Container newMethod() {
  return Container(
    color: Colors.blue,
    width: 220,
    height: 300,
  );
}

List<Widget> wid = [
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
  newMethod(),
];
