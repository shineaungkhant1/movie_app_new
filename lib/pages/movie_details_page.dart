


import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actor_and_creators_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class MovieDetalisPage extends StatelessWidget {
  final List<String> genreList = ["Action", "Adventure", "Thriller"];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailsSliverAppBarView(
                ()=>Navigator.pop(context)
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: TrailerSection(genreList),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  ActorsAndCreatorSectionView(
                      MOVIE_DETAILS_SCREEN_ACTORS_TITLE, "",
                      seeMoreButtonVisibility: false),
                  SizedBox(height:MARGIN_LARGE),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MARGIN_MEDIUM_2),
                    child: AboutFlimSectionView(),
                  ),
                  SizedBox(height:MARGIN_LARGE),
                  ActorsAndCreatorSectionView(
                      MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                      MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutFlimSectionView extends StatelessWidget {
  const AboutFlimSectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FLIM"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
          "Original Title:",
        "The Matrix"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
            "Type:",
            "Action, Adventure, Thriller"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
            "Production:",
            "United Kingdom, USA"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
            "Premiere:",
            "8 November 2016(World)"),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFlimInfoView(
            "Description:",
            "Morpheus offers Neo a choice between two pills: Taking the red pill, which will reveal the truth about the Matrix, or the blue, which will make Neo forget everything and return to his former life.")
      ],
    );
  }
}

class AboutFlimInfoView extends StatelessWidget {

  final String label;
  final String description;


  AboutFlimInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width /4,
          child: Text(
            label,
            style: TextStyle(
              color: MOVIE_DETAIL_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
                color: Colors.white,
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;
  TrailerSection(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(height: MARGIN_MEDIUM_3),
        StoryLineView(),
        SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
            MovieDetailsScreenButtonView(
                "PLAY TRAILER",
                PLAY_BUTTON_COLOR,
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.black54,
                )),
            SizedBox(width: MARGIN_CARD_MEDIUM_2),
            MovieDetailsScreenButtonView(
              "Rate MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailsScreenButtonView(
      this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border: (isGhostButton)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            SizedBox(width: MARGIN_MEDIUM),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR_2X),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  const StoryLineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          " Neo, is puzzled by repeated online encounters with the phrase the Matrix. Trinity contacts him and tells him a man named Morpheus has the answers Neo seeks A team of Agents and police, led by Agent Smith, arrives at Neo's workplace in search of him. Though Morpheus attempts to guide Neo to safety, Neo surrenders rather thanrisk a dangerous escape. The Agents offer to erase Neo's criminal record in exchange for his help with locating Morpheus, who they claim is a terrorist. When Neo refuses to cooperate, they fuse his mouth shut, pin him down, and implant a robotic bug in his stomach.Neo wakes up from what he believes to be a nightmare. Soon after, Neo is taken by Trinity to meet Morpheus, and she removes the bug from Neo.",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        SizedBox(width: MARGIN_SMALL),
        Text(
          "2h 30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Row(
          children: genreList.map((genre) => GenreChipView(genre)).toList(),
        ),
        Spacer(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: MARGIN_SMALL)
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {

  final Function onTapBack;


  MovieDetailsSliverAppBarView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      pinned: true,
     

      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetalisAppBarImageView(),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtomView(
                    ()=> this.onTapBack()
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: EdgeInsets.only(
                    top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                    left: MARGIN_MEDIUM_2,
                  ),
                  child: SearchButtomView()),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                    right: MARGIN_MEDIUM_2,
                    bottom: MARGIN_LARGE),
                child: MovieDetailsAppBarInfoView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText("38876 VOTES"),
                    SizedBox(height: MARGIN_CARD_MEDIUM_2),
                  ],
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Text(
                  "9,76",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "The Matrix",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  const MovieDetailsYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
      ),
      child: Center(
        child: Text(
          "2016",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SearchButtomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtomView extends StatelessWidget {
  
  final Function onTapBack;


  BackButtomView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        this.onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

class MovieDetalisAppBarImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
        "https://s26162.pcdn.co/wp-content/uploads/2021/03/the-matrix-reloaded.jpeg",
        fit: BoxFit.cover);
  }
}
