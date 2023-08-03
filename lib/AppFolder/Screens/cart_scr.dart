import 'package:chat_app/AppFolder/ModelApp/CategoryModel.dart';
import 'package:chat_app/AppFolder/appCubit/cubit.dart';
import 'package:chat_app/AppFolder/appCubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:chat_app/constants.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Color.fromARGB(255, 212, 205, 205),
            appBar: AppBar(
              elevation: 1,
              centerTitle: true,
              title: Text(
                "Shopping Bag",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ConditionalBuilder(
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return cartItem(
                              AppCubit.get(context).CartList![index], context);
                        },
                        itemCount: AppCubit.get(context).CartList!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            width: double.infinity,
                            color: Colors.grey,
                            height: 1,
                          );
                        }),
                    condition: state is! GetCartDataLoadingStates,
                    fallback: (BuildContext context) {
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:  ${AppCubit.get(context).total.round()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              backgroundColor: MainColor),
                          onPressed: () {},
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}

Widget cartItem(CategoryModel data, context) {
  return Dismissible(
    background: Container(
      width: 70,
      alignment: Alignment.center,
      color: Colors.red,
      child: IconButton(
          onPressed: () {
            // shopCubit.get(context).changeCarts(data.product!.id!);
          },
          icon: Icon(Icons.delete)),
    ),
    key: UniqueKey(),
    child: Container(
      height: 145,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(
                  // "https://img.freepik.com/free-photo/young-beautiful-woman-looking-camera-trendy-girl-casual-summer-white-t-shirt-jeans-shorts-round-sunglasses-positive-female-shows-facial-emotions-funny-model-isolated-yellow_158538-15802.jpg?w=740&t=st=1681213159~exp=1681213759~hmac=cc305d40d349334159a5f1620eefabf10bbd9c0f32e8a7585325c7434c5fa736"
                  "${data.images![0]}"),
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  "${data.name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: 230,
                  child: Text(
                    "${data.description}",
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        color: Color.fromARGB(255, 97, 93, 93)),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Size: 38.5 (EU)",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 97, 93, 93)),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Delivered By: ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 58, 56, 56),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data.delivered.toString(),
                      style: TextStyle(
                          fontSize: 13,
                          color: MainColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 228,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        // height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.remove,
                                  size: 15,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Text(
                              '1',

                              // "${data.quantity}"
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${data.price}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).changeCartProducts(data);
    },
  );
}