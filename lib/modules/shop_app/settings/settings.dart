import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        // var model = ShopCubit.get(context).userData;
        // nameController.text = model.data.name;
        // emailController.text = model.data.email;
        // phoneController.text = model.data.phone;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children:
              [
                deafultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                  label: 'Name',
                  prefix: Icons.person,
                ),
                SizedBox(
                  height: 20.0,
                ),
                deafultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'email not be empty';
                    }
                    return null;
                  },
                  label: 'Email Address',
                  prefix: Icons.email,
                ),
                SizedBox(
                  height: 20.0,
                ),
                deafultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'phone must not be empty';
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefix: Icons.phone,
                ),
                SizedBox(
                  height: 20.0,
                ),
                deafultButton(
                  text: 'update',
                  function: ()
                  {
                    if(formKey.currentState!.validate())
                    {
                      ShopCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                deafultButton(
                  text: 'logout',
                  function: ()
                  {
                    signOut(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
