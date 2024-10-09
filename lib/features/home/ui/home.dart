import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnbloc/features/cart/ui/cart.dart';
import 'package:learnbloc/features/home/bloc/home_bloc.dart';
import 'package:learnbloc/features/home/ui/products_tile.dart';
import 'package:learnbloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitailEvent());
    print('initial state emitted');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToWishlistPageActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Wishlist()));
          } else if (state is HomeNavigateToCartPageActionState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Cart()));
          }
          else if(state is HomeProductItemCartedState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment Scheduled')));
          }
          else if(state is HomeProductItemWishlistedState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Wishlisted')));
          }
          else if(state is HomeProductItemwishlistremoved){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item removed from wishlist')));
          }
          else if(state is HomeProductItemcartremoved){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment Cancelled')));
          }

        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              print('Handling TypeA');
              break;
            case HomeSuccessState:
              final successState = state as HomeSuccessState;
              return Scaffold(
                backgroundColor: Colors.white,
                drawer:Drawer(),
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: Icon(Icons.calendar_month_outlined))
                  ],
                ),
                body: Expanded(
                  child: ListView.builder(
                      itemCount: successState.products.length,
                      itemBuilder: (context,index){
                    return ProductsTile(homeBloc:homeBloc,productDataModel: successState.products[index],);
                  }),
                ),
              );
            case HomeErrorState:
              return Scaffold(
                body: Center(
                  child: Text('error'),
                ),
              );

            default:
              return SizedBox();
          }
          ;
        });
  }
}
