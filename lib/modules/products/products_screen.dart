import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/bottom_nav_cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/bottom_nav_cubit/shop_states.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state){},
      builder: (BuildContext context, ShopStates state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (BuildContext context) => productsBuilder(ShopCubit.get(context).homeModel!),
            fallback: (BuildContext context)=> const Center(child: CircularProgressIndicator())
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model){
    return Column(
      children: [
        CarouselSlider(
            items: model.data!.banners.map((e) => Image(image: NetworkImage(e.image), width: double.infinity, fit: BoxFit.cover,)).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn
            )),

      ],
    );
  }
}
