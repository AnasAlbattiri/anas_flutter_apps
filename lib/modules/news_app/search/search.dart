import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/shared/components/components.dart';

import '../../../layout/news_app/cubit/states.dart';



// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {

  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: deafultFormField(
                  controller: searchController ,
                  type: TextInputType.text,
                  onChange: (value) //مع كل تشينج اروح اعمل سيرش
                  {
                    NewsCubit.get(context).getSearch(value);
                  },

                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true))
            ],
          ),
        );
      },

    );
  }
}
