import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/catagories_model.dart';
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
          builder: ((context) => productLayout(
                context,
                homeData: shopCubit.homeModel!.data,
                categoriesData: shopCubit.categoriesModel!.categoriesData,
              )),
        );
      },
    );
  }
}

class CategoriesBuilder extends StatelessWidget {
  final CategoriesData categoriesData;
  const CategoriesBuilder({
    Key? key,
    required this.categoriesData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 105.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            categoryItem(category: categoriesData.data[index]),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10.0,
        ),
        itemCount: categoriesData.data.length,
      ),
    );
  }
}

Widget categoryItem({
  required Category category,
}) =>
    Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              category.image,
            ),
          ),
        ),
        Text(
          category.name,
          maxLines: 1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
Widget productItem(BuildContext context, Product product) => Container(
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
                        ShopCubit.get(context).addOrRemoveFromFav(
                          context,
                          id: product.id,
                        );
                      },
                      icon: Icon(
                        ShopCubit.get(context).fav[product.id]!
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: ShopCubit.get(context).fav[product.id]!
                            ? Colors.red
                            : Colors.grey,
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

Widget productLayout(
  BuildContext context, {
  required CategoriesData categoriesData,
  required HomeData homeData,
}) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        //TODO: remove this container
        color: Colors.grey[200],
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  ShopCubit.get(context).getFavorites();
                },
                child: Text('fave')),
            CarouselSlider(
              items: homeData.banners.map((banner) {
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
            ConditionalBuilder(
              condition: ShopCubit.get(context).categoriesModel != null,
              builder: (context) => CategoriesBuilder(
                categoriesData: categoriesData,
              ),
              fallback: (context) {
                return const SizedBox(
                  height: 110,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Container(
              height: 5,
              color: Colors.grey[200],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: const Color.fromARGB(117, 238, 238, 238),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: List.generate(
                  homeData.products.length,
                  (index) => productItem(context, homeData.products[index]),
                ),
              ),
            ),
            Container(
              height: 5,
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
