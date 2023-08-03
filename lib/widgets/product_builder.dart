import 'package:flutter/material.dart';

import '../AppFolder/ModelApp/CategoryModel.dart';
import '../AppFolder/Screens/item_screen.dart';
import '../AppFolder/appCubit/cubit.dart';
import '../constants.dart';
import 'navigator.dart';

Widget productBuilder(CategoryModel product, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, itemScreen(product));
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: product.images![0] != null
                  ? NetworkImage(product.images![0])
                  : NetworkImage(
                      "https://media.istockphoto.com/id/1335247217/vector/loading-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=jARr4Alv-d5U3bCa8eixuX2593e1rDiiWnvJLgHCkQM="),
              width: double.infinity,
              height: 150,
              fit: BoxFit.contain,
            ),
            // if (products.discount != 0)
            // Container(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 5,
            //   ),
            //   color: Colors.red,
            //   child: Text(
            //     "DISCOUNT",
            //     style: TextStyle(
            //       fontSize: 10,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
              if (product.name!.length <= 25)
                SizedBox(
                  height: 20,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // if (products.discount != 0)
                  //   Row(
                  //     children: [
                  //       Text(
                  //         "${products.oldPrice}",
                  //         style: TextStyle(
                  //             decoration:
                  //                 TextDecoration.lineThrough,
                  //             fontSize: 12,
                  //             height: 1.4,
                  //             color: Colors.grey),
                  //       ),
                  //       // Text(
                  //       //   " (${products.discount}%)",
                  //       //   style: TextStyle(fontSize: 12, color: Colors.red),
                  //       // ),
                  //     ],
                  //   ),

                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    product.price.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: MainColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeFavouriteProducts(product);
                      },
                      icon: Icon(Icons.favorite,
                          size: 14,
                          color: product.isFavourite!.contains(uid)
                              ? Colors.red
                              : Colors.grey))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
