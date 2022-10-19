import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_app/register/register_cubit/cubit.dart';
import 'package:untitled/modules/shop_app/register/register_cubit/states.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login/login_cubit/cubit.dart';
import '../login/login_cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state)
        {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value)
              {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, ShopLayout());
              });
            } else
            {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );

            }
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
            ),
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        deafultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your user name';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
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
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          onSubmit: (value)
                          {

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
                        deafultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your phone number';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => deafultButton(
                              text: 'register',
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),

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
