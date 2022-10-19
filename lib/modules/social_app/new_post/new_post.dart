import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget
{
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return Scaffold(
          appBar: deafultAppBar(
            context: context,
            title: 'Create Post',
            actions:
            [
              deafultTextButton(
                  text: 'Post',
                  function:()
                  {
                    var now = DateTime.now();

                    if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createPost(
                          datetime: now.toString(),
                          text: textController.text,
                      );
                    } else
                    {
                      SocialCubit.get(context).uploadPostImage(
                          datetime: now.toString(),
                          text: textController.text,
                      );
                    }
                  },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10.0,
                ),
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://scontent.famm6-1.fna.fbcdn.net/v/t39.30808-6/277677392_2315957035214080_8502372395715418509_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=8ovJWOsN7VwAX-F5xln&_nc_ht=scontent.famm6-1.fna&oh=00_AT_v-NXSbq9RfxA34taBKZfusvcr-84LdrUJ7X3lFoahUg&oe=63418AE5'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Anas Albattiri',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 14.0,
                        ),
                      ),

                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind, Anas?',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 150.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,

                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 18.0,
                        child: IconButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
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
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photo',
                              ),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                          '# tag',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}
