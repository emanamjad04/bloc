import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnbloc/features/cart/bloc/cart_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listenWhen: (previous,current)=> current is CartActionState,
      buildWhen:(previous,current)=> current is! CartActionState ,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch(state.runtimeType){
          case CartSuccessState:
            final successState = state as CartSuccessState;
            return Scaffold(
              appBar: AppBar(
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
                                    cartBloc.add(CartItemRemovedEvent(clickedProduct:successState.products[index]));

                                  },
                                  icon: Icon(Icons.schedule))
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
