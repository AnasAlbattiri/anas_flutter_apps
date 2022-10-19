//https://newsapi.org/v2/everything?q=tesla&apiKey=897cc581d6c34ca2b6c5bbcc1d49262e

import '../../modules/shop_app/login/shop_login.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';
import 'package:firebase_storage/firebase_storage.dart';


void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText (String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token= '';

String uId= '';

final storage = FirebaseStorage.instance;