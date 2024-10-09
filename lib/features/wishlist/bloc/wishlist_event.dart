part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent{}

class WishlistItemRemovedEvent extends WishlistEvent{
  final ProductDataModel clickedProduct;
  WishlistItemRemovedEvent({ required this.clickedProduct});
}

class WishlistItemRemovedFromHomeEvent extends WishlistEvent{
  final ProductDataModel clickedProduct;
  WishlistItemRemovedFromHomeEvent({ required this.clickedProduct});
}