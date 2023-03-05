import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/play_button_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://lumiere-a.akamaihd.net/v1/images/the_wolverine_-_feature_71479c84.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child:PlayButtonView()
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(MARGIN_MEDIUM_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                    Text(
                        "Passengers",
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: TEXT_REGULAR_2X,
                          fontWeight: FontWeight.w600
                        ) ,
                    ),
                  SizedBox(height: MARGIN_MEDIUM),
                  TitleText(
                      "15 DECEMBER 2016"
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
