
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/modules/shop_app/login/login_cubit/cubit.dart';
import 'package:untitled/modules/shop_app/login/login_cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../register/shop_register.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, states)
        {
          if(states is ShopLoginSuccessState)
          {
            if(states.loginModel.status)
            {
              print(states.loginModel.message);
              print(states.loginModel.data.token);
              CacheHelper.saveData(
                  key: 'token',
                  value: states.loginModel.data.token,
              ).then((value)
              {
                token = states.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else
            {
              print(states.loginModel.message);
              showToast(
                  text: states.loginModel.message,
                  state: ToastStates.ERROR,
              );

            }
          }

        },

        builder: (context, states)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        deafultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        deafultFormField(
                          controller: passwordController,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          type: TextInputType.visiblePassword,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: states is! ShopLoginLoadingState,
                          builder: (context) => deafultButton(
                              text: 'login',
                              function: ()
                              {
                                  if(formKey.currentState!.validate())
                                  {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                    );
                                  }
                              }
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            deafultTextButton(
                                text: 'register',
                                function: ()
                                {
                                  navigateTo(context, ShopRegisterScreen());
                                }
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
