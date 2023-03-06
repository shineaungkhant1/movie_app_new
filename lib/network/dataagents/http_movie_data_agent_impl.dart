import 'package:flutter/cupertino.dart';
import 'package:movie_app/network/api_constant.dart';
import 'package:http/http.dart' as http;

import 'movie_data_agent.dart';

class HttpMovieDataAgentImpl extends MovieDataAgent {
  @override
  void getNowPlayingMovie(int page) {
    Map<String, String> queryParameters = {
      PARAM_API_KEY:API_KEY,
      PARAM_LANGUAGE:LANGUAGE_EN_US,
      PARAM_PAGE:page.toString()
    };

    var url=Uri.https(BASE_URL_HTTP,END_POINT_GET_NOW_PLAYING,queryParameters);

    http.get(url).then((value){
      debugPrint("Now Playing Movies ======>  ${value.body.toString()}");
    }).catchError((error){
      debugPrint("Error  ======> ${error.toString()}");
    });

  }
}
