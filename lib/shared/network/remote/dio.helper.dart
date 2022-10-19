import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

//GET
//POST
//PUT

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',//أول إشي بغيّر هذا البيس يو آر إل بجيبوا من البوست مان
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
  required String url,
  Map<String, dynamic>? query,
    String? token,
    String lang='en',
}) async
  {
    dio.options.headers =
    {
      'Authorization':token??'',
      'lang':lang,
      'Content-Type':'application/json',
    };
    return await dio.get(url, queryParameters: query);
  }



  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
    String lang='en',
  }) async
  {
    dio.options.headers =
    {
      'Authorization':token??'',
      'lang':lang,
      'Content-Type':'application/json',
    };
    return await dio.post(url, data: data);
  }


  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
    String lang='en',
  }) async
  {
    dio.options.headers =
    {
      'Authorization':token??'',
      'lang':lang,
      'Content-Type':'application/json',
    };
    return await dio.put(url, data: data);
  }



}