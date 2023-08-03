import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/product_builder.dart';
import '../appCubit/cubit.dart';
import '../appCubit/states.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).allProducts;
        return Scaffold(
          body: ConditionalBuilder(
              condition: AppCubit.get(context).allProducts != null,
              builder: (context) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ConditionalBuilder(
                        condition: state is! GetAdsLoadingStates,
                        builder: (context) {
                          return CarouselSlider.builder(
                            itemCount: AppCubit.get(context).AdsList.length,
                            options:
                                CarouselOptions(autoPlay: true, height: 150),
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              return Image(
                                image: NetworkImage(
                                    AppCubit.get(context).AdsList[index]),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          );
                        },
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        color: Colors.white,
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1 / 1.46,
                          children: List.generate(
                              AppCubit.get(context).allProducts!.length,
                              (index) {
                            return productBuilder(cubit![index], context);
                          }),
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
