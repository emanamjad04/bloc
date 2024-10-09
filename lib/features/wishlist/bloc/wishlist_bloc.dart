import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learnbloc/data/data.dart';
import 'package:learnbloc/data/wishlist.dart';
import 'package:learnbloc/features/home/bloc/home_bloc.dart';
import 'package:learnbloc/features/home/ui/home.dart';
import 'package:learnbloc/features/home/ui/products_tile.dart';
import 'package:meta/meta.dart';

import '../../home/models/home_products.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
   on<WishlistInitialEvent>(wishlistInitialEvent);
   on<WishlistItemRemovedEvent>(wishlistItemRemovedEvent);
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) async{
    emit(WishlistLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(WishlistSuccessState(products: wishlist));
  }

  FutureOr<void> wishlistItemRemovedEvent(WishlistItemRemovedEvent event, Emitter<WishlistState> emit) {
    wishlist.remove(event.clickedProduct);
    emit(WishlistSuccessState(products: wishlist));
  }


}
