import 'package:chat_app/AppFolder/ModelApp/CategoryModel.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
// import 'package:chat_app/shop_cubit/cubit.dart';
// import 'package:chat_app/shop_cubit/states.dart';
// import '../constants.dart';
// import '../models/GetfavoritesModel.dart';

class favouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          // backgroundColor: Color.fromARGB(255, 212, 205, 205),
          appBar: AppBar(
            elevation: 1,
            centerTitle: true,
            title: Text(
              "Wishlist",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            child: ConditionalBuilder(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: AppCubit.get(context).favouritesList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return favBuilder(
                        AppCubit.get(context).favouritesList![index], context);
                    // favoriteBuilder(
                    // shopCubit.get(context).getfav!.data!.data![index], context);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                ),
              ),
              condition: AppCubit.get(context).favouritesList != null,
              fallback: (BuildContext context) {
                return Center(
                    child: Text(
                  "No favourites List",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ));
              },
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

Widget favBuilder(CategoryModel data, context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Image(
            height: 150,
            width: double.infinity,
            image: data.images != null
                ? NetworkImage(
                    "${data.images![0]}",
                  )
                : NetworkImage(
                    "https://media.istockphoto.com/id/1335247217/vector/loading-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=jARr4Alv-d5U3bCa8eixuX2593e1rDiiWnvJLgHCkQM="),
            fit: BoxFit.contain,
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // print(data.product!.id);
                // shopCubit.get(context).changeFavorites(data.product!.id!);

                AppCubit.get(context).changeFavouriteProducts(data);
              },
              icon: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 204, 201, 201),
                radius: 11,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.black,
                ),
              ))
        ],
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        "${data.name}",
        maxLines: 1,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      SizedBox(
        height: 3,
      ),
      Text(
        "${data.description}",
        maxLines: 2,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 13,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          // if (data.product!.discount != 0)
          //   Text("${data.product!.oldPrice} EP",
          //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
          //             decoration: TextDecoration.lineThrough,
          //           )),
          // if (data.product!.discount != 0)
          //   SizedBox(
          //     width: 3,
          //   ),
          Text("${data.price} EP",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red)),
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Center(
        child: InkWell(
          onTap: () {
            // shopCubit.get(context).changeCarts(data.product!.id!);
            AppCubit.get(context).changeCartProducts(data);
          },
          child: Container(
            height: 25,
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: MainColor)),
            child: Center(
              child: Text(
                "Add to Bag",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MainColor),
              ),
            ),
          ),
        ),
      ),
    ]),
  );
}

Widget divider() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Container(
      color: Colors.grey[300],
      height: 1,
    ),
  );
}
