import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learnbloc/data/data.dart';
import 'package:learnbloc/data/wishlist.dart';
import 'package:learnbloc/features/cart/ui/cart.dart';
import 'package:learnbloc/features/home/models/home_products.dart';
import 'package:meta/meta.dart';

import '../../../data/cart.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitailEvent>(homeInitailEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeProductWishlistButtonClickedEvent>(homeProductWishlistButtonClickedEvent);
    on<HomeProductWishlistButtonClickedEventRemoved>(homeProductWishlistButtonClickedEventRemoved);
    on<HomeProductCartButtonClickedEventRemoved>(homeProductCartButtonClickedEventRemoved);
  }



  FutureOr<void> homeWishlistButtonNavigateEvent(HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist page navigate button clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('cart page navigate button clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('cart button clicked');
    cart.add(event.ClickedProduct);
    emit(HomeProductItemCartedState());

  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist button clicked');
    wishlist.add(event.ClickedProduct);
    emit(HomeProductItemWishlistedState());
  }

  FutureOr<void> homeInitailEvent(HomeInitailEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeSuccessState(products: dataa.fruits.map((e)=>ProductDataModel(id: e['id'], name: e['name'], descrip: e['descrip'], price: e['price'], imageUrl: e['imageUrl'])).toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEventRemoved(HomeProductWishlistButtonClickedEventRemoved event, Emitter<HomeState> emit) {
    print('Wishlist button clicked for removing');
    wishlist.remove(event.ClickedProduct);
    emit(HomeProductItemwishlistremoved());
  }

  FutureOr<void> homeProductCartButtonClickedEventRemoved(HomeProductCartButtonClickedEventRemoved event, Emitter<HomeState> emit) {
    print('Wishlist button clicked for removing');
    cart.remove(event.ClickedProduct);
    emit(HomeProductItemcartremoved());
  }
}
