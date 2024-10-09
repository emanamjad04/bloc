part of 'home_bloc.dart';

@immutable
sealed class HomeState {}
abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeSuccessState extends HomeState{
  final List<ProductDataModel> products;
  HomeSuccessState({
    required this.products,
});
}

class HomeErrorState extends HomeState{}

class HomeProductItemwishlistremoved extends HomeActionState{}
class HomeProductItemcartremoved extends HomeActionState{}

class HomeNavigateToWishlistPageActionState extends HomeActionState{}

class HomeNavigateToCartPageActionState extends HomeActionState{}

//for snackbar

class HomeProductItemCartedState extends HomeActionState{}
class HomeProductItemWishlistedState extends HomeActionState{}