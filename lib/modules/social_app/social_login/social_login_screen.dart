import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/social_app/social_register/social_register_screen.dart';
import '../../../layout/social_app/social_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state)
        {
          if(state is SocialLoginErrorState)
          {
            showToast(text: state.error,
                state: ToastStates.ERROR,
            );
          }

          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value)
            {
              navigateAndFinish(
                context,
                SocialLayout(),
              );
            });
          }
        },

        builder: (context, state)
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
                          'Login now to communicate with friends',
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
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                          isPassword:  SocialLoginCubit.get(context).isPassword,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              // SocialLoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
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
                          condition: state is!  SocialLoginLoadingState,
                          builder: (context) => deafultButton(
                              text: 'login',
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
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
                                  navigateTo(context,  SocialRegisterScreen());
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
