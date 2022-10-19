import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/shared/network/remote/dio.helper.dart';
import '../../../modules/news_app/business/business.dart';
import '../../../modules/news_app/science/science.dart';
import '../../../modules/news_app/sports/sports.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomItem =
  [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNav (int index)
  {
    currentIndex=index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness ()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'ie',
          'category':'business',
          'apiKey':'897cc581d6c34ca2b6c5bbcc1d49262e',
        }
    ).then((value)
    {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports ()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'ie',
              'category':'sports',
              'apiKey':'897cc581d6c34ca2b6c5bbcc1d49262e',
            }
        ).then((value)
        {
          sports=value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      } else
      {
        emit(NewsGetSportsSuccessState());
      }

  }

  List<dynamic> science = [];

  void getScience ()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'ie',
            'category':'science',
            'apiKey':'897cc581d6c34ca2b6c5bbcc1d49262e',
          }
      ).then((value)
      {
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'897cc581d6c34ca2b6c5bbcc1d49262e',
        }
    ).then((value)
    {
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  }
