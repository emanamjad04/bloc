import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnbloc/data/wishlist.dart';
import 'package:learnbloc/features/home/bloc/home_bloc.dart';
import 'package:learnbloc/features/home/models/home_products.dart';

class ProductsTile extends StatefulWidget {
  final HomeBloc homeBloc;
  ProductDataModel productDataModel;
  // bool isWishlisted;
   ProductsTile({required this.productDataModel,super.key, required this.homeBloc});

  @override
  State<ProductsTile> createState() => _ProductsTileState();
}

class _ProductsTileState extends State<ProductsTile> {

  bool isWishlisted =false;
  bool isCarted=false;

  @override
  Widget build(BuildContext context) {

    return Stack(

      children:[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black,Colors.white24],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              ),

              borderRadius: BorderRadius.circular(5)
          ),
          margin: EdgeInsets.fromLTRB(50, 10, 60, 10),
          padding: EdgeInsets.all(6),
          child: Container(
            color: Colors.white,
            // margin: EdgeInsets.all(1),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   height: 120,
                //   width: double.infinity,
                //
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           fit: BoxFit.cover,
                //           image: AssetImage('${productDataModel.imageUrl}',)
                //       )
                //   ),
                // ),
                SizedBox(height: 169,),

                Text('${widget.productDataModel.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                Text('${widget.productDataModel.descrip}',
                  style: TextStyle(
                      fontSize: 15
                  ),),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$"+'${widget.productDataModel.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isWishlisted = !isWishlisted;
                                if(isWishlisted){
                                  widget.homeBloc.add(HomeProductWishlistButtonClickedEvent(ClickedProduct: widget.productDataModel));
                                }
                                else{
                                  widget.homeBloc.add(HomeProductWishlistButtonClickedEventRemoved(ClickedProduct: widget.productDataModel));
                                }
                              });


                            },
                            icon: Icon(isWishlisted? Icons.favorite:Icons.favorite_border)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isCarted= !isCarted;
                                if(isCarted){
                                      widget.homeBloc.add(HomeProductCartButtonClickedEvent(ClickedProduct: widget.productDataModel));
                                    }
                                else{
                                  widget.homeBloc.add(HomeProductCartButtonClickedEventRemoved(ClickedProduct: widget.productDataModel));
                                }
                              });
                            },
                            icon: Icon(isCarted? Icons.schedule:Icons.calendar_month_outlined))
                      ],
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
        Positioned(
          left: (widget.productDataModel.id<=2)?135:100,
          top: (widget.productDataModel.id<=2)?-25:-60,
          child: ClipRect(
            child: Image.asset('${widget.productDataModel.imageUrl}',
            height: (widget.productDataModel.id>2)? 350:280,
              fit: BoxFit.contain,
              width: (widget.productDataModel.id>2)? 350:280,
            ),
          ),
        ),

      ]
    );
  }
}
