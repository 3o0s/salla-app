import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/modules/profile.dart';
import 'package:shopapp/modules/search_screen.dart';
import 'package:shopapp/utilities/cubit/shop/cubit.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';
import 'package:shopapp/utilities/network/local/cach_helper.dart';
import 'package:shopapp/utilities/shared/components.dart';
import 'package:shopapp/utilities/shared/variables.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: ((context, state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            titleSpacing: Theme.of(context).appBarTheme.titleSpacing,
            title: Text(
              'Salla',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            actions: [
              shopCubit.currentIndex == 3
                  ? TextButton(
                      onPressed: () {
                        CachHelper.removeData('token').then(
                          (value) => navigateAndReplace(
                            context,
                            const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    )
                  : const SizedBox(),
              TextButton(
                onPressed: () {
                  navigateTo(context, const SearchScreen());
                },
                child: const Icon(Icons.search),
              ),
              IconButton(
                splashRadius: 1,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                onPressed: () {
                  shopCubit.getUserData();
                  navigateTo(context, const EditScreen());
                },
                icon: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => shopCubit.changeIndex(index),
            items: bottomNavItems,
            currentIndex: shopCubit.currentIndex,
            type: BottomNavigationBarType.fixed,
          ),
          body: bottomScreen[shopCubit.currentIndex],
        );
      }),
    );
  }
}
