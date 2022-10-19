import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/styles/colors.dart';
import 'package:untitled/shared/styles/icon_broken.dart';

Widget deafultButton({
  double radius = 3.0,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required String text,
  double width = double.infinity,
  required Function function,

})

=> Container(
  height: 40.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  width: width,
  child: MaterialButton(
    onPressed: ()
    {
      function();
    },
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,

      ),
    ),
  ),
);

Widget deafultTextButton({
  required String text,
  required Function function,
}) => TextButton(
  onPressed: ()
  {
    function();
  },
  child: Text(
      text.toUpperCase(),
  ),
);


PreferredSizeWidget deafultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
  Color color = Colors.black,

}) => AppBar(
  leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon: Icon(
        IconBroken.Arrow___Left_2,
        color: color,
      ),
  ),
  title: Text(
    title!,
  ),
  actions: actions,
  titleSpacing: 5.0,
);


Widget deafultFormField({

  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  bool isClickable = true,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,

})

=> TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: (String value) => onSubmit,
  onChanged: (String value) => onChange,
  onTap: ()
  {
    onTap!();
  },
  validator: (String? value) => validate(value),
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix !=null?  IconButton(
      onPressed: ()
      {
        suffixPressed!();
      },
      icon: Icon(
      suffix,
      ),
    ) : null,
    border: OutlineInputBorder(),
  ),

  );

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model ['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        CircleAvatar(



          backgroundColor: Colors.blueAccent,



          child: Text(



              '${model['time']}',



            style: TextStyle(



              color: Colors.white,



            ),



          ),



          radius: 40.0,



        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                '${model['title']}',



                style: TextStyle(



                  fontSize: 18.0,



                  fontWeight: FontWeight.bold,



                ),



              ),
              Text(



                '${model['date']}',



                style: TextStyle(



                  fontSize: 14.0,



                  color: Colors.grey,



                ),



              ),
            ],



          ),



        ),
        SizedBox(

          width: 15.0,



        ),
        IconButton(



            onPressed:()



            {



              AppCubit.get(context).updateData(



                  status: 'done',



                  id: model ['id'] );



            } ,



            icon: Icon(



              Icons.check_box,



              color: Colors.green,



            )



        ),
        IconButton(



            onPressed:()



            {



              AppCubit.get(context).updateData(



                  status: 'archived',



                  id: model ['id'] );



            } ,



            icon: Icon(



              Icons.archive_outlined,



              color: Colors.black45,



            )



        ),
      ],
    ),
  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model ['id']);
  },

);

Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index)
    {
      return buildTaskItem(tasks[index], context);
    },
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  ),
  itemCount: tasks.length,
),
  fallback: (context) => Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children:
  [
    Icon(
      Icons.menu,
      size: 100.0,
      color: Colors.grey,
    ),
    Text(
      'No Tasks Yet, Please Add some tasks',
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    ),
  ]
  )
  )
);

Widget buildArticleItem(article, context) => Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

  children:

  [

  Container(

  height: 120.0,

  width: 120.0,

  decoration: BoxDecoration(

  borderRadius: BorderRadius.circular(10.0), //الكيرفات بتغيروا

  image: DecorationImage(

  image: NetworkImage('${article['urlToImage']}', scale: 1.0),

  fit: BoxFit.cover, //بغير حجم الصورة

    ),

    ),

    ),

  SizedBox(

  width: 16.0,

  ),

  Expanded(

  child: Container(

  height: 120.0,

  child: Column(

  crossAxisAlignment: CrossAxisAlignment.start,

  mainAxisSize: MainAxisSize.min,

  mainAxisAlignment: MainAxisAlignment.start,

  children:

  [

   Expanded(

   child: Text(

  '${article['title']}',

  style: Theme.of(context).textTheme.bodyText1,

  overflow: TextOverflow.ellipsis,

  maxLines: 3,

  ),

  ),

  Text(

  '${article['publishedAt']}',

  style: TextStyle(

color: Colors.grey,

),

  ),



  ],

  ),

  ),

  ),

  ],

  ),

  );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list, context , {isSearch=false}) => ConditionalBuilder(
  condition: list.length>0 ,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => myDivider() ,
      itemCount: 10,
  ),
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

void navigateTo(context, widget) => Navigator.push(context, MaterialPageRoute(
    builder: (context) => widget ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil (context, MaterialPageRoute(
builder: (context) => widget,
),
(route)
{
  return false;
}
    );

void showToast ({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: deafultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavourites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favorites[model.id]!
                              ? deafultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );



