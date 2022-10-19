abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

//get user
class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}

//get all users
class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates
{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

//get posts
class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;

  SocialGetPostsErrorState(this.error);
}

//like post
class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates
{
  final String error;

  SocialLikePostErrorState(this.error);
}

//comment post
class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates
{
  final String error;

  SocialCommentPostErrorState(this.error);
}

//others
class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

//Upload Image & Cover
class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialProfileCoverPickedSuccessState extends SocialStates {}

class SocialProfileCoverPickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadProfileCoverSuccessState extends SocialStates {}

class SocialUploadProfileCoverErrorState extends SocialStates {}

//update user
class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

//create post
class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//chat

class SocialSendMessagesSuccessState extends SocialStates {}

class SocialSendMessagesErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}



