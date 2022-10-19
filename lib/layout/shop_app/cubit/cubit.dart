import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app/categories_model.dart';
import 'package:untitled/models/shop_app/change_favourites_model.dart';
import 'package:untitled/models/shop_app/favorites_model.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/modules/shop_app/categories/categories.dart';
import 'package:untitled/modules/shop_app/favourites/favourites.dart';
import 'package:untitled/modules/shop_app/products/products.dart';
import 'package:untitled/modules/shop_app/settings/settings.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio.helper.dart';

import '../../../shared/components/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //printFullText(homeModel.data.banners[0].image);
      homeModel!.data?.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavouriteModel? changeFavouriteModel;

  void changeFavourites(int? id, {int? productId}) {
    favorites[productId!] = !favorites[productId]!;
    emit(ShopChangeFavouritesState());

    DioHelper.postData(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      print(value.data);
      if (!changeFavouriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }

      emit(ShopSuccessChangeFavouritesState(changeFavouriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavouritesState());
    });
  }

  late FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  late ShopLoginModel userData;

  void getUserData() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      printFullText(userData.data!.name!);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      printFullText(userData.data!.name!);

      emit(ShopSuccessUpdateUserState(userData));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
