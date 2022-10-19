import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../../../models/shop_app/categories_model.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavouritesState)
        {
          if(!state.model.status!)
          {
            showToast(text: state.model.message!, state: ToastStates.ERROR );
          }
        }
      },
      builder: (context, state)
      {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
            builder:(context) => productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel, context ),
            fallback:(context) => Center(child: CircularProgressIndicator()),
        );
      },
    );

  }

 Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel, context) => SingleChildScrollView(
   physics: BouncingScrollPhysics(),
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children:
     [
       CarouselSlider(
           items: model.data!.banners.map((e) => Image(
             image: NetworkImage('${e.image}'),
             width: double.infinity,
             fit: BoxFit.cover,
           ),).toList(),
           options: CarouselOptions(
             height: 250.0,
             enableInfiniteScroll: true,
             viewportFraction: 1.0,
             autoPlay: true,
             reverse: false,
             autoPlayAnimationDuration: Duration(seconds: 1),
             autoPlayInterval: Duration(seconds: 3),
             initialPage: 0,
             scrollDirection: Axis.horizontal,
             autoPlayCurve: Curves.fastOutSlowIn,
           ),
       ),
       SizedBox(
         height: 10.0,
       ),
       Padding(
         padding: const EdgeInsets.symmetric(
           horizontal: 10.0,
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Categories',
               style: TextStyle(
                 fontWeight: FontWeight.w800,
                 fontSize: 24.0,
               ),
             ),
             SizedBox(
               height: 10.0,
             ),
             Container(
               height: 100.0,
               child: ListView.separated(
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data![index]),
                   separatorBuilder: (context, index) =>  SizedBox(
                     width: 10.0,
                   ),
                   itemCount: categoriesModel.data!.data!.length,
               ),
             ),
             SizedBox(
               height: 20.0,
             ),
             Text(
               'New Products',
               style: TextStyle(
                 fontWeight: FontWeight.w800,
                 fontSize: 24.0,
               ),
             ),
           ],
         ),
       ),
       SizedBox(
         height: 20.0,
       ),
       Container(
         color: Colors.grey[300],
         child: GridView.count(
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           crossAxisCount: 2,
           mainAxisSpacing: 1.0,
           crossAxisSpacing: 1.0,
           childAspectRatio: 1 / 1.56,
           children: List.generate(model.data!.products.length,
                   (index) => buildGridProduct(model.data!.products[index], context),
           ),
         ),
       )
     ],
   ),
 );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage(model.image!),
        fit: BoxFit.cover,
        height: 100.0,
        width: 100.0,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(.8),
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductModel model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discount != 0)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
              ),
              color: Colors.red,
              child: Text(
                'Discount',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: deafultColor,
                      fontSize: 12.0,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount != 0)//حط اولد برايس للي عليه دس كاونت فقط
                  Text(
                      '${model.oldPrice.round()}',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 10.0,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavourites(model.id!);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ? deafultColor : Colors.grey,
                        child: Icon(
                            Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
