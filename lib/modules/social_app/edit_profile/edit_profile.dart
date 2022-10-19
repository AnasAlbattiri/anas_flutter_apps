import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/styles/icon_broken.dart';

import '../../../shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var userModel = SocialCubit.get(context).userModel;
        late var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;



        nameController.text = userModel!.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;

        return Scaffold(
          appBar: deafultAppBar(
            context: context,
            title: 'Edit Profile',
            actions:
            [
              deafultTextButton(
                  text: 'Update',
                  function: ()
                  {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                    );
                  }
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:
                [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 150.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    image: DecorationImage(
                                      image: coverImage == null ? NetworkImage('${userModel.cover}') : FileImage(coverImage) as ImageProvider,
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
                                        SocialCubit.get(context).getCoverImage();
                                      },
                                      icon: Icon(
                                        IconBroken.Camera,
                                        size: 16.0,
                                      ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: profileImage == null ? NetworkImage('${userModel.image}') : FileImage(profileImage) as ImageProvider,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 18.0,
                                child: IconButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage !=null)
                  Row(
                    children:
                    [
                      if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            deafultButton(
                                text: 'upload profile',
                                function: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            deafultButton(
                                text: 'upload cover',
                                function: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                  );
                                },
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage !=null)
                    SizedBox(
                    height: 20.0,
                  ),
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
                      prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  deafultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  deafultFormField(
                    controller: phoneController,
                    type: TextInputType.text,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
