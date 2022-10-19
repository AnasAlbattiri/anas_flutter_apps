import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/news_layout.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/shop_app/login/shop_login.dart';
import 'package:untitled/modules/shop_app/on_boarding/on_boarding.dart';
import 'package:untitled/modules/social_app/social_login/social_login_screen.dart';
import 'package:untitled/modules/social_app/social_register/social_register_screen.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/dio.helper.dart';
import 'package:untitled/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/social_app/cubit/cubit.dart';
import 'package:desktop_window/desktop_window.dart';


// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
// {
//   print('on background message');
//   print(message.data.toString());
//
//   showToast(text: 'on background message', state: ToastStates.SUCCESS,);
// }

  void main() async
  {
    // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يفتح الابلكيشن
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    var token = await FirebaseMessaging.instance.getToken();

    print(token);


  //
  //   // // foreground fcm
  // FirebaseMessaging.onMessage.listen((event)
  // {
  //   print('on message');
  //   print(event.data.toString());
  //
  //   showToast(text: 'on message', state: ToastStates.SUCCESS,);
  // });
  //
  // // // when click on notification to open app
  // FirebaseMessaging.onMessageOpenedApp.listen((event)
  // {
  //   print('on message opened app');
  //   print(event.data.toString());
  //
  //   showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
  // });
  // //
  // // // background fcm
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;

  uId= CacheHelper.getData(key: 'uId');

  // String token = CacheHelper.getData(key: 'token');
  // print(token);

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  print(onBoarding);

  // if(onBoarding != null)
  // {
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // } else
  // {
  //   widget = OnBoardingScreen();
  // }

  if(uId != null)
  {
    widget = SocialLayout();
  } else
   {
     widget = SocialLoginScreen();
   }

  runApp(MyApp(
      isDark: isDark,
      startWidget: widget,
  ));
 }
class MyApp extends StatelessWidget {

  bool? isDark;
  Widget? startWidget;

  MyApp({
      this.isDark,
      this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( //بعمل ملتي بلوك لأنو راح استخدم البروفايدر في أكثر من مكان
      providers: //بتاخذ لست اوف بلوك بروفايدر
      [
        BlocProvider(create: (context) =>  NewsCubit()..getBusiness()..getSports()..getScience()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeTheme(
        fromShared: isDark!,
     ),),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData(),),
        BlocProvider(create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark ,
            home: startWidget,
          );
        },
      ),
    );

  }
}
