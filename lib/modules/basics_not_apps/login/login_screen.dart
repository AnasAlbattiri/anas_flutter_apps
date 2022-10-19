import 'package:flutter/material.dart';
import 'package:untitled/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey ,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  deafultFormField(
                   controller: emailController,
                    label: 'Email',
                    prefix: Icons.email,
                    onSubmit: (){},
                    onChange: (){},
                    type: TextInputType.emailAddress,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                      return null;
                    },


                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  deafultFormField(
                    controller: passwordController,
                    label: 'Pssword',
                    prefix: Icons.lock,
                    onSubmit: (){},
                    onChange: (){},
                    type: TextInputType.visiblePassword,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                        {
                          return 'password must not be empty';
                        }
                      return null;
                    },
                    isPassword: isPassword,
                    suffixPressed: ()
                    {
                      setState(()
                      {
                        isPassword = !isPassword;
                      });
                    },
                    suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  deafultButton(
                  text: 'login',
                  function: ()
                  {
                    if(formKey.currentState!.validate())
                    {
                      print(emailController.text);
                      print(passwordController.text);
                    }
                  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  deafultButton(
                    text: 'Register',
                    function: ()
                    {
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    isUpperCase: false,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}