import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/home_model.dart';
import 'package:shopapp/utilities/cubit/shop/cubit.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      // listener: (context, state) {   },
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.homeModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: ((context) =>
              productLayout(banner: shopCubit.homeModel!.data.banners)),
        );
      },
    );
  }
}

Widget productLayout({
  required List<BannerElemet> banner,
}) =>
    Column(
      children: [
        CarouselSlider(
          items: banner.map((e) {
            return Image(
              width: double.infinity,
              fit: BoxFit.cover,
              image: NetworkImage(
                e.image,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            enableInfiniteScroll: true,
            viewportFraction: 1,
            autoPlay: true,
            height: 200,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),
      ],
    );
