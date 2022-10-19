import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/modules/social_app/edit_profile/edit_profile.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/styles/icon_broken.dart';

class SocialSettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var userModel = SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:
            [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: NetworkImage('${userModel!.cover}'),
                              fit: BoxFit.cover,

                            )
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,

                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children:
                [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children:
                        [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            'Posts',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children:
                        [
                          Text(
                            '256',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children:
                        [
                          Text(
                            '10M',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            'Followers',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children:
                        [
                          Text(
                            '64',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            'Following',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children:
                [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: ()
                    {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children:
              //   [
              //     OutlinedButton(
              //         onPressed: ()
              //         {
              //           FirebaseMessaging.instance.subscribeToTopic('announcement');
              //         },
              //         child: Text(
              //           'subscribe',
              //     )),
              //     SizedBox(
              //       width: 20.0,
              //     ),
              //     OutlinedButton(
              //         onPressed: ()
              //         {
              //           FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
              //         },
              //         child: Text(
              //           'unsubscribe',
              //     )),
              //   ],
              // ),
            ],
          ),
        );
      },
    );

  }
}
