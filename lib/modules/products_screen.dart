import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/home_model.dart';
import 'package:shopapp/utilities/cubit/shop/cubit.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';
import 'package:shopapp/utilities/shared/theme.dart';

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
              productLayout(data: shopCubit.homeModel!.data)),
        );
      },
    );
  }
}

Widget productLayout({
  required HomeData data,
}) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: data.banners.map((banner) {
              return Image(
                width: double.infinity,
                fit: BoxFit.cover,
                image: NetworkImage(
                  banner.image,
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
          Container(
            height: 5,
            color: Colors.grey[200],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: Colors.grey[200],
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: List.generate(
                data.products.length,
                (index) => productItem(data.products[index]),
              ),
            ),
          ),
          Container(
            height: 5,
            color: Colors.grey[200],
          ),
        ],
      ),
    );

Widget productItem(Product product) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(product.image),
                  ),
                ),
                product.discount != 0
                    ? Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Text(
                          'Offer',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox(),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    alignment: AlignmentDirectional.center,
                    width: 20,
                    height: 20,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        //TODO: add to love
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            height: 50,
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${product.price.round().toString()} LE',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    product.discount != 0
                        ? Text(
                            '${product.oldPrice.round().toString()} LE',
                            style: const TextStyle(
                              fontSize: 9.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
