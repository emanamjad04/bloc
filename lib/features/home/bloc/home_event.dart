part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitailEvent extends HomeEvent{}


class HomeProductWishlistButtonClickedEvent extends HomeEvent{
  final ProductDataModel ClickedProduct;

  HomeProductWishlistButtonClickedEvent({required this.ClickedProduct});

}
class HomeProductWishlistButtonClickedEventRemoved extends HomeEvent{
  final ProductDataModel ClickedProduct;

  HomeProductWishlistButtonClickedEventRemoved({required this.ClickedProduct});

}
class HomeProductCartButtonClickedEventRemoved extends HomeEvent{
  final ProductDataModel ClickedProduct;

  HomeProductCartButtonClickedEventRemoved({required this.ClickedProduct});

}

class HomeProductCartButtonClickedEvent extends HomeEvent{
  final ProductDataModel ClickedProduct;

  HomeProductCartButtonClickedEvent({required this.ClickedProduct});

}

class HomeWishlistButtonNavigateEvent extends HomeEvent{

}

class HomeCartButtonNavigateEvent extends HomeEvent{

}