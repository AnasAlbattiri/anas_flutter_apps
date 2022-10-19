
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/counter_app/counter/states.dart';


import 'cubit.dart';

class CounterScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocProvider
      (create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener:(context, state)
        {
          if(state is CounterPlusState)
          {
            print('Plus ${state.counter}');
          }
          if (state is CounterMinusState)
          {
            print('Minus ${state.counter}');
          }
        } ,
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
              backgroundColor: Colors.black,
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child:
                      Text(
                        'MINUS',
                      )
                  ),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 50.0,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child:
                      Text(
                        'PLUS',
                      )
                  ),

                ],
              ),
            ),

          );
        },
      ),

      );

  }

}
