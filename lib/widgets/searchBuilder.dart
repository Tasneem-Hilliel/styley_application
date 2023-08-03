import 'package:chat_app/AppFolder/ModelApp/CategoryModel.dart';
import 'package:chat_app/AppFolder/Screens/item_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'divider.dart';
import 'navigator.dart';

Widget articleItem(CategoryModel product, context) {
  return InkWell(
    onTap: () {
      navigateTo(context,itemScreen(product));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: 
                // articles.urlToImage != null
                //     ?
                     DecorationImage(
                        image: NetworkImage('${product.images}'),
                        fit: BoxFit.cover)
                    // : const
                    //  DecorationImage(
                    //     image: NetworkImage(
                    //         'https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg'),
                    //     fit: BoxFit.cover)
                        ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // CounterCubit.get(context).isDark
                  //     ? Text(
                  //         maxLines: 3,
                  //         overflow: TextOverflow.ellipsis,
                  //         '${articles.title}',
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.w600),
                  //       )
                  //     : 
                      Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          "${product.name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                  Spacer(),
                  Text(
                    '${product.delivered} ',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}



Widget articleBuilder(list, context) {
  return ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => articleItem(list[index], context),
          separatorBuilder: (context, index) => divider(),
          itemCount: list.length),
      fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ));
}
