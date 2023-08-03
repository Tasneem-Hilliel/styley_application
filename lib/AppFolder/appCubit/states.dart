abstract class AppStates {}

class AppInitialState extends AppStates {}

class GetProductsLoadingState extends AppStates {}

class GetProductsSuccessState extends AppStates {}

class GetProductsErrorState extends AppStates {
  final error;

  GetProductsErrorState(this.error);
}

class SocialGetUserLoadingStates extends AppStates {}

class SocialGetUserSuccessStates extends AppStates {}

class SocialGetUserErrorStates extends AppStates {}

class GetAllCategoriesSuccessStates extends AppStates {}

class shopChangeBottomNavBarState extends AppStates {}

class GetAdsSuccessStates extends AppStates {}

class GetAdsLoadingStates extends AppStates {}

class GetAdsErrorStates extends AppStates {}

class AddToCartSuccessStates extends AppStates {}

class AddToCartLoadingStates extends AppStates {}

class AddToCartErrorStates extends AppStates {}

class GetCartDataSuccessStates extends AppStates {}

class GetCartDataLoadingStates extends AppStates {}

class GetCartDataErrorStates extends AppStates {}

// class AddToFavouritesSuccessStates extends AppStates {

// }class AddToFavouritesLoadingStates extends AppStates {

// }class AddToFavouritesErrorStates extends AppStates {

// }

class GetFavouriteDataSuccessStates extends AppStates {}

class GetFavouriteDataLoadingStates extends AppStates {}

class GetFavouriteDataErrorStates extends AppStates {}

class AddtoFavouriteSuccessStates extends AppStates {}

class AddtoFavouriteLoadingStates extends AppStates {}

class AddtoFavouriteErrorStates extends AppStates {}

class UpdateUserProfileSuccessStates extends AppStates {}

class UpdateUserProfileErrorStates extends AppStates {}

class SearchResultSuccessStates extends AppStates {}

class SearchResultErrorStates extends AppStates {}

class SearchResultLoadingStates extends AppStates {}

class PickedImageSuccessStates extends AppStates {}

class PickedImageErrorStates extends AppStates {}

class IsFinishStates extends AppStates {}

class IsLoadingStates extends AppStates {}
class LogOutSuccessStates extends AppStates {}
// class onBoardChangeSuccessStates extends AppStates {}


class UpdateRatingSuccessStates extends AppStates {}
class UpdateRatingErrorStates extends AppStates {}


class CommentSuccessStates extends AppStates {}

class CommentErrorStates extends AppStates {}

class CommentLoadingStates extends AppStates {}


class GetCommentSuccessStates extends AppStates {}

class GetCommentErrorStates extends AppStates {}

class GetCommentLoadingStates extends AppStates {}

class ChangeFlagState extends AppStates {}
