import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnbloc/features/home/bloc/home_bloc.dart';
import 'package:learnbloc/features/home/ui/home.dart';
import 'package:learnbloc/features/home/ui/products_tile.dart';
import 'package:learnbloc/features/wishlist/bloc/wishlist_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listenWhen: (previous,current)=> current is WishlistActionState,
          buildWhen:(previous,current)=> current is! WishlistActionState ,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch(state.runtimeType){
              case WishlistSuccessState:
                final successState = state as WishlistSuccessState;
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    leading: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios)),
                  ),
                  body: ListView.builder(
                    itemCount: successState.products.length,
                      itemBuilder: (context,index){
                        return  Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,

                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('${successState.products[index].imageUrl}',)
                                    )
                                ),
                              ),
                              SizedBox(height: 5,),

                              Text('${successState.products[index].name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),),
                              Text('${successState.products[index].descrip}',
                                style: TextStyle(
                                    fontSize: 15
                                ),),

                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("RS. "+'${successState.products[index].price}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),),
                                  IconButton(
                                      onPressed: () {
                                        wishlistBloc.add(WishlistItemRemovedEvent(clickedProduct:successState.products[index]));
                                      },
                                      icon: Icon(Icons.favorite))
                                ],
                              ),

                            ],
                          ),
                        );
                  }),
                );
              default:
                return SizedBox();
            }
          },
        );
  }
}
