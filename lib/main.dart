import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  String? token = CacheHelper.getData(key: 'token');
  Widget widget;
  if(onBoarding){
    if(token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }else{
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(onBoarding: onBoarding, startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onBoarding, required this.startWidget});
  final bool onBoarding;
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (BuildContext context) => ShopLoginCubit())],
      child: BlocConsumer<ShopLoginCubit, ShopStates>(
        listener: (BuildContext context, ShopStates state){},
        builder: (BuildContext context, ShopStates state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            title: 'Shop App',
            home: startWidget,
          );
        },
      ));
  }
}