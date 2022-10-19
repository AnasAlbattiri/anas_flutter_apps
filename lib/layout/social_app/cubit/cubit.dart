import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/message_model.dart';
import 'package:untitled/models/social_app/post_model.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/chats/chats_screen.dart';
import 'package:untitled/modules/social_app/feeds/feeds_screen.dart';
import 'package:untitled/modules/social_app/new_post/new_post.dart';
import '../../../modules/social_app/settings/settings_screen.dart';
import '../../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';


class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;


  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {
      // print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    })
        .catchError((error)
    {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens =
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    SocialSettingsScreen(),
  ];

  List<String> titles =
  [
    'Home',
    'Chats',
    'Posts',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index==1)
    {
      getUsers();
    }
      if(index == 2)
      {
        emit(SocialNewPostState());
      } else
      {
        currentIndex = index;
        emit(SocialChangeBottomNavState());
      }
  }


//Cover & Profile Image

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async
  {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else
    {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }


  File? coverImage;
  Future<void> getCoverImage() async
  {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      emit(SocialProfileCoverPickedSuccessState());
    } else
    {
      print('No image selected');
      emit(SocialProfileCoverPickedErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());
    storage
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value) 
      {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            image: value,
        );
      }).catchError((error)
      {
        emit(SocialUploadProfileImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());
    storage
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value)
    {
      value.ref.getDownloadURL()
          .then((value)
      {
        // emit(SocialUploadProfileCoverSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      })
          .catchError((error)
      {
        emit(SocialUploadProfileCoverErrorState());
      });
    }).catchError((error)
    {
      emit(SocialUploadProfileCoverErrorState());
    });
  }


//   void updateUserImage({
//   @required String name,
//   @required String phone,
//   @required String bio,
// })
//   {
//     emit(SocialUserUpdateLoadingState());
//     if(profileImage != null)
//     {
//       uploadProfileImage();
//     } else if (coverImage != null)
//     {
//       uploadCoverImage();
//     } else if (profileImage != null && coverImage != null)
//     {
//
//     } else
//     {
//       updateUser(
//           name: name,
//           phone: phone,
//           bio: bio
//       );
//     }
//   }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  })
  {
    emit(SocialUserUpdateLoadingState());

    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover??userModel!.cover,
      image: image??userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) 
    {
      getUserData();
    }).catchError((error)
    {
      emit(SocialUserUpdateErrorState());
    });
        
  }

//Create Post + others Post..

  File? postImage;
  Future<void> getPostImage() async
  {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if(pickedFile != null)
    {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else
    {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String datetime,
    required String text,
  })
  {
    emit(SocialCreatePostLoadingState());
    storage
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value)
    {
      value.ref.getDownloadURL()
          .then((value)
      {
        print(value);
        createPost(
            datetime: datetime,
            text: text,
            postImage: value,
        );
      })
          .catchError((error)
      {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String datetime,
    required String text,
    String? postImage,
  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: datetime,
      text: text,
      postImage: postImage??'',
    );
    FirebaseFirestore
        .instance
        .collection('posts')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialCreatePostSuccessState());
    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });

  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];


  void getPosts()
  {
    FirebaseFirestore.instance.collection('posts').get().then((value)
         {
           value.docs.forEach((element)
           {
             element
                 .reference
                 .collection('Likes')
                 .get()
                 .then((value)
             {
               likes.add(value.docs.length);
               comments.add(value.docs.length);
               postsId.add(element.id);
               posts.add(PostModel.fromJson(element.data()));
             })
                 .catchError((error) {});
           });
           emit(SocialGetPostsSuccessState());
         })
        .catchError((error)
        {
          emit(SocialGetPostsErrorState(error.toString()));
        });
  }

  void likePost(String postsId)
  {
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(postsId)
        .collection('Likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    })
        .then((value)
    {
      emit(SocialLikePostSuccessState());
    })
        .catchError((error)
    {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost(String postsId)
  {
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(postsId)
        .collection('Comments')
        .doc(userModel!.uId)
        .set({
      'comment':true,
    })
        .then((value)
    {
      emit(SocialCommentPostSuccessState());
    })
        .catchError((error)
    {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

//get all users

  List<SocialUserModel> users = [];

  void getUsers()
  {
    if(users.length == 0)
    FirebaseFirestore.instance.collection('users').get().then((value)
    {
      value.docs.forEach((element)
      {
        if(element.data()['uId'] != userModel!.uId)
        users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    })
        .catchError((error)
    {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

//chat

  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
})
  {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel!.uId,
    );

    //set my chats
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessagesSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessagesErrorState());
    });

    //set receiver chats
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessagesSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessagesErrorState());
    });
  }

//get chat

List<MessageModel> messages = [];

  void getMessages({
  required String receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }


}