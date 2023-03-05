import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';

import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: BannerImageView(),
          ),
          Positioned.fill(
            child: GradientView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: BannerTitleView(),
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          )
        ],
      ),
    );
  }
}





class BannerTitleView extends StatelessWidget {
  const BannerTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The Wolverine 2013.",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Offical Review",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  const BannerImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://lumiere-a.akamaihd.net/v1/images/the_wolverine_-_feature_71479c84.png",
      fit: BoxFit.cover,
    );
  }
}
