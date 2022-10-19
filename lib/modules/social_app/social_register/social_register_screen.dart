import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/shop_app/register/register_cubit/cubit.dart';
import 'package:untitled/modules/shop_app/register/register_cubit/states.dart';
import 'package:untitled/modules/social_app/social_register/register_cubit/cubit.dart';
import 'package:untitled/modules/social_app/social_register/register_cubit/states.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';

class SocialRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(context, SocialLayout());
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
                          'Register now to communicate with friends',
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
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: SocialRegisterCubit.get(context).isPassword,
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
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => deafultButton(
                              text: 'register',
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  SocialRegisterCubit.get(context).userRegister(
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
