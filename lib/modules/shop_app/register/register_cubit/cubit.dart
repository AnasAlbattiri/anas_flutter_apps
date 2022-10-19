import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/modules/shop_app/login/login_cubit/states.dart';
import 'package:untitled/modules/shop_app/register/register_cubit/states.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio.helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel = true as ShopLoginModel;


  void userRegister ({
  required String email,
  required String password,
  required String phone,
  required String name,
})
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,

        },
    ).then((value)
    {
      print(value.data);
      loginModel= ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error)
    {
      emit(ShopRegisterErrorState(error));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegChangePasswordVisibilityState());
  }
}