import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/favorites_model.dart';
import 'package:shopapp/utilities/cubit/shop/cubit.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';
import 'package:shopapp/utilities/shared/theme.dart';

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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(left: 5, top: 5, right: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 120,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                product.image,
                width: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      product.description,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.grey[400],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          product.price.toString(),
                          maxLines: 2,
                          style: const TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          product.discount != 0
                              ? product.oldPrice.toString()
                              : '',
                          maxLines: 2,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red[200],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            margin: const EdgeInsets.all(5),
            alignment: AlignmentDirectional.center,
            width: 20,
            height: 20,
            child: IconButton(
              splashRadius: 1,
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
    );
  }
}
