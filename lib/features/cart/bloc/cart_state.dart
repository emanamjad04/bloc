part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState{}
final class CartInitial extends CartState {}
class CartLoadingState extends CartState{}

class CartSuccessState extends CartState{
  final List<ProductDataModel> products;

  CartSuccessState({required this.products});

}

class CartErrorState extends CartState{}