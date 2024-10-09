import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learnbloc/data/cart.dart';
import 'package:meta/meta.dart';

import '../../home/models/home_products.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartItemRemovedEvent>(cartItemRemovedEvent);

  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) async{
    emit(CartLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(CartSuccessState(products: cart));
  }

  FutureOr<void> cartItemRemovedEvent(CartItemRemovedEvent event, Emitter<CartState> emit) {
    cart.remove(event.clickedProduct);
    emit(CartSuccessState(products: cart));
  }
  }
