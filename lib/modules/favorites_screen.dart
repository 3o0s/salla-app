import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/favorites_model.dart';
import 'package:shopapp/utilities/cubit/shop/cubit.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return ListView.builder(
          itemCount: shopCubit.favoritesModel == null
              ? 0
              : shopCubit.favoritesModel!.data.products.length,
          itemBuilder: (context, index) => Favoritebuider(
            product: shopCubit.favoritesModel!.data.products[index],
          ),
        );
      },
    );
  }
}

class Favoritebuider extends StatelessWidget {
  final Product product;
  const Favoritebuider({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 5, right: 5),
      color: Colors.white,
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            product.image,
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    product.name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
