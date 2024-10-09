part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}
class CartInitialEvent extends CartEvent{}

class CartItemRemovedEvent extends CartEvent{
  final ProductDataModel clickedProduct;
  CartItemRemovedEvent({ required this.clickedProduct});
}