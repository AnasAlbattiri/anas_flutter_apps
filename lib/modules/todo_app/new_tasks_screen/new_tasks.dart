import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';

class NewTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) 
  {
    var tasks = AppCubit.get(context).newTasks;
      return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return tasksBuilder(tasks: tasks,);
      },
    );

  }
}


