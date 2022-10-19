import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';
import '../../shared/cubit/cubit.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {

var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();
var titleController = TextEditingController();
var dateController = TextEditingController();
var timeController = TextEditingController();
DateTime date = DateTime(2022,12,5);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state)
        {
         if(state is AppInsertDatabaseState)
         {
           Navigator.pop(context);
         }

        },
        builder: (BuildContext context, state)
        {
          AppCubit cubit=AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
               cubit.titles[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),

            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black,
                child: Icon(
                  cubit.fabIcon,
                ),
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate())
                    {
                      cubit.insertToDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text
                      );
                    }
                  } else {
                    scaffoldKey.currentState!.showBottomSheet(
                      (context) => Container(
                        color: Colors.grey[100],
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Form(
                                child: deafultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                  },
                                  label: 'Title Task',
                                  prefix: Icons.title,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Form(
                                child: deafultFormField(
                                     onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context).toString());
                                    });
                                  },
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                  },
                                  label: 'Time Task',
                                  prefix: Icons.watch_later_outlined,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Form(
                                child: deafultFormField(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  controller: dateController,
                                  type: TextInputType.text,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                  },
                                  label: 'Date Task',
                                  prefix: Icons.calendar_month,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                    ).closed.then((value) {
                      cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                    });
                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                }),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index)
                {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived',
                  ),
                ]),
          );
        },

      ),
    );
  }

}