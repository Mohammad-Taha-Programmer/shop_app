import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/bottom_nav_cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/bottom_nav_cubit/shop_states.dart';
import 'package:shop_app/shared/styles/colors.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state){},
      builder: (BuildContext context, ShopStates state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (BuildContext context) => builderWidget(ShopCubit.get(context).homeModel!),
            fallback: (BuildContext context)=> const Center(child: CircularProgressIndicator())
        );
      },
    );
  }

  Widget builderWidget(HomeModel model){
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
              items: model.data!.banners.map((e) => Image(image: NetworkImage(e.image), width: double.infinity, fit: BoxFit.cover,)).toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn
              )),
          const SizedBox(height: 10.0),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              children: List.generate(
               model.data!.products.length,
               (index) => buildGridProduct(model.data!.products[index])),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget buildGridProduct(ProductModel model){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                width: double.infinity,
                  height: 200,
                  fit: BoxFit.contain,
                  image: NetworkImage(model.image),

              ),
              if(model.discout != 0)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.1,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      model.price.round().toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if(model.discout !=0)
                    Text(
                      model.oldPrice.round().toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){},
                      icon: const Icon(Icons.favorite_border))
                  ],
                ),
              ],
            ),
          ),
      ],
   ),
    );
 }

}
