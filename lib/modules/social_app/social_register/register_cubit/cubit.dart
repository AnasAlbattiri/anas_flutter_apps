import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/social_register/register_cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{

  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister ({
  required String email,
  required String password,
  required String phone,
  required String name,
})
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user?.email);
      print(value.user?.uid);

      userCreate(
          email: email,
          uId: value.user!.uid,
          phone: phone,
          name: name
      );

    }).catchError((error)
    {
      emit(SocialRegisterErrorState(error.toString()));
    });

  }

  void userCreate({
    required String email,
    required String uId,
    required String phone,
    required String name,
})
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      uId: uId,
      phone: phone,
      email: email,
      image: 'https://img.freepik.com/free-photo/portrait-startled-impressed-man-stares-smartphone-display-cant-believe-own-eyes-gets-shocking-message-opens-mouth-holds-breath-wears-orange-t-shirt-poses-against-green-wall_273609-40059.jpg?w=826&t=st=1662586854~exp=1662587454~hmac=b49731d4229eafbc6bbf0aabf353607db97bc71da444d1d2e6974cc04e23f285',
      bio: 'write your bio ...',
      cover: 'https://img.freepik.com/free-photo/beautiful-tree-middle-field-covered-with-grass-with-tree-line-background_181624-29267.jpg?w=996&t=st=1662639113~exp=1662639713~hmac=dfe7380fe769ad875f6d026063b0616675e43331e3acdf799ef3155866fb80c4',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(SocialCreateUserSuccessState());
    })
        .catchError((error)
    {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }


  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegChangePasswordVisibilityState());
  }
}