import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/catagories_model.dart';
import 'package:shopapp/utilities/cubit/shop/cubit.dart';
import 'package:shopapp/utilities/cubit/shop/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(builder: (context, state) {
      final CategoriesModel? model = ShopCubit.get(context).categoriesModel;
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ConditionalBuilder(
            condition: model != null,
            builder: (context) {
              return Categorybuider(
                category: model!.categoriesData.data[index],
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        itemCount: model == null ? 0 : model.categoriesData.data.length,
      );
    });
  }
}

class Categorybuider extends StatelessWidget {
  final Category category;
  const Categorybuider({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(30),
          right: Radius.circular(30),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              category.image,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            category.name,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
