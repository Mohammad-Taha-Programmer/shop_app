import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/bottom_nav_cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/bottom_nav_cubit/shop_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state){},
        builder: (BuildContext context, ShopStates state){
        ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Salla',
              ),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, const SearchScreen());
                }, icon: const Icon(Icons.search))
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int index){
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          );
        },
    );

  }
}
