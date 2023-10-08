import 'package:flutter/cupertino.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';

void signOut(BuildContext context) async => CacheHelper.removeData(key: 'token')
    .then((value) => navigateAndFinish(context, ShopLoginScreen()));

void printFullText(String text){
  final pattern = RegExp('.{1800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String? token = '';