import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/widgets/rating_view.dart';

import '../resources/dimens.dart';

class MovieView extends StatelessWidget {

  final Function onTapMovie;

  MovieView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEMS_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap:(){
              onTapMovie();
            },
            child: Image.network(
              "https://lumiere-a.akamaihd.net/v1/images/the_wolverine_-_feature_71479c84.png",
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Text(
            "West World",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Text(
                "8.9",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: MARGIN_MEDIUM),
              RatingView(),
            ],
          )
        ],
      ),
    );
  }
}
