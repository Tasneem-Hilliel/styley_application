import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:chat_app/widgets/product_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/constants.dart';
// import 'package:chat_app/models/categoriesModel.dart';
// import 'package:chat_app/models/homeModel.dart';
// import 'package:chat_app/screens/item_scr.dart';
// import 'package:chat_app/shop_cubit/cubit.dart';
import 'package:chat_app/widgets/navigator.dart';

class WomenScreen extends StatelessWidget {
  var searchController = TextEditingController();

  // List<String> categories = ["Women","Men","Kids",];

  // set up the buttons

  Future delay() async {
    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).womenProducts;
        return Scaffold(
          body: ConditionalBuilder(
              condition: AppCubit.get(context).womenProducts != null,
              builder: (context) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Container(
                      //       height: 100,
                      //     )),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      Container(
                        color: Colors.white,
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1 / 1.46,
                          children: List.generate(
                              AppCubit.get(context).womenProducts!.length,
                              (index) {
                            return productBuilder(cubit![index], context);   }),
                        ),
                      )
                    ],
                  ),
                );
              },
              fallback: (context) =>
                  Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}

// Widget productsBuilder(homeModel model, categoriesModel category_Model, context,
//     searchController) {
//   return SingleChildScrollView(
//     physics: BouncingScrollPhysics(),
//     child: Column(
//       children: [
//         Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 100,
//               )),
       
//         SizedBox(
//           height: 15,
//         ),
//         Container(
//           color: Colors.white,
//           child: GridView.count(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             crossAxisCount: 2,
//             mainAxisSpacing: 1,
//             crossAxisSpacing: 1,
//             childAspectRatio: 1 / 1.46,
//             children: List.generate(AppCubit.get(context).MenCategory!.length,
//                 (index) {
//               return InkWell(
//                 onTap: () {
//                   // navigateTo(context, itemScreen(products));
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       alignment: AlignmentDirectional.bottomStart,
//                       children: [
//                         Image(
//                           image: products.image != null
//                               ? NetworkImage(Cubit)
//                               : NetworkImage(
//                                   "https://media.istockphoto.com/id/1335247217/vector/loading-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=jARr4Alv-d5U3bCa8eixuX2593e1rDiiWnvJLgHCkQM="),
//                           width: double.infinity,
//                           height: 150,
//                           // fit: BoxFit.cover,
//                         ),
//                         if (products.discount != 0)
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 5,
//                             ),
//                             color: Colors.red,
//                             child: Text(
//                               "DISCOUNT",
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             products.name.toString(),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(fontSize: 14, height: 1.4),
//                           ),
//                           if (products.name!.length <= 25)
//                             SizedBox(
//                               height: 20,
//                             ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               if (products.discount != 0)
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "${products.oldPrice}",
//                                       style: TextStyle(
//                                           decoration:
//                                               TextDecoration.lineThrough,
//                                           fontSize: 12,
//                                           height: 1.4,
//                                           color: Colors.grey),
//                                     ),
//                                     // Text(
//                                     //   " (${products.discount}%)",
//                                     //   style: TextStyle(fontSize: 12, color: Colors.red),
//                                     // ),
//                                   ],
//                                 ),
//                               SizedBox(
//                                 width: 6,
//                               ),
//                               Text(
//                                 products.price.toString(),
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     height: 1.4,
//                                     color: MainColor,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Spacer(),
//                               IconButton(
//                                   onPressed: () {
//                                     shopCubit
//                                         .get(context)
//                                         .changeFavorites(products.id!);
//                                   },
//                                   icon: Icon(
//                                     Icons.favorite_border,
//                                     size: 12,
//                                     color: shopCubit
//                                             .get(context)
//                                             .inFavourites![products.id]!
//                                         ? Colors.red
//                                         : header,
//                                   ))
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         )
//       ],
//     ),
//   );
// }

// Widget categoryBuilder(DataModel data) {
//   return SizedBox(
//     width: 85,
//     child: Column(
//       children: [
//         CircleAvatar(
//           radius: 31,
//           backgroundColor: MainColor,
//           child: CircleAvatar(
//             radius: 30,
//             backgroundImage: NetworkImage(data.image.toString()),
//           ),
//         ),
//         Text(
//           data.name.toString(),
//           maxLines: 1,
//           style: TextStyle(overflow: TextOverflow.ellipsis),
//         )
//       ],
//     ),
//   );
// }

// Widget productGridBuilder(Products products, context) {
//   return InkWell(
//     onTap: () {
//       navigateTo(context, itemScreen(products));
//     },
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(
//           alignment: AlignmentDirectional.bottomStart,
//           children: [
//             Image(
//               image: products.image != null
//                   ? NetworkImage(products.image.toString())
//                   : NetworkImage(
//                       "https://media.istockphoto.com/id/1335247217/vector/loading-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=jARr4Alv-d5U3bCa8eixuX2593e1rDiiWnvJLgHCkQM="),
//               width: double.infinity,
//               height: 150,
//               // fit: BoxFit.cover,
//             ),
//             if (products.discount != 0)
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 5,
//                 ),
//                 color: Colors.red,
//                 child: Text(
//                   "DISCOUNT",
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 products.name.toString(),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(fontSize: 14, height: 1.4),
//               ),
//               if (products.name!.length <= 25)
//                 SizedBox(
//                   height: 20,
//                 ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   if (products.discount != 0)
//                     Row(
//                       children: [
//                         Text(
//                           "${products.oldPrice}",
//                           style: TextStyle(
//                               decoration: TextDecoration.lineThrough,
//                               fontSize: 12,
//                               height: 1.4,
//                               color: Colors.grey),
//                         ),
//                         // Text(
//                         //   " (${products.discount}%)",
//                         //   style: TextStyle(fontSize: 12, color: Colors.red),
//                         // ),
//                       ],
//                     ),
//                   SizedBox(
//                     width: 6,
//                   ),
//                   Text(
//                     products.price.toString(),
//                     style: TextStyle(
//                         fontSize: 12,
//                         height: 1.4,
//                         color: MainColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Spacer(),
//                   IconButton(
//                       onPressed: () {
//                         shopCubit.get(context).changeFavorites(products.id!);
//                       },
//                       icon: Icon(
//                         Icons.favorite_border,
//                         size: 12,
//                         color:
//                             shopCubit.get(context).inFavourites![products.id]!
//                                 ? Colors.red
//                                 : header,
//                       ))
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }


// Wrap(
//                   children: [
//                     Text(
//                         "Would you like to continue learning how to use Flutter alerts?"),
//                     Text(
//                       "Would you like to continue learning how to use Flutter alerts?",
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 15),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             width: 250,
//                             child: ElevatedButton(
//                                 child: Text("Sign in with email"),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 }),
//                           ),
//                           SizedBox(
//                             width: 250,
//                             child: ElevatedButton(
//                               child: Text("Sign in with facebook"),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
