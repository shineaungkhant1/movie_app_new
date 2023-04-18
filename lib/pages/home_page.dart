import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/viewitems/bammer_view.dart';
import 'package:movie_app/viewitems/movie_view.dart';
import 'package:movie_app/viewitems/showcase_view.dart';
import 'package:movie_app/widgets/actor_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

  MovieModel movieModel = MovieModelImpl();

  /// State Variables
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  @override
  void initState() {
    /// Now Playing Movies
    // movieModel.getNowPlayingMovies(1).then((movieList) {
    //   setState(() {
    //     nowPlayingMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    /// Now Playing Movies From Database
    movieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      setState(() {
        nowPlayingMovies = movieList;
      });
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Popular Movies
    // movieModel.getPopularMovies(1).then((movieList) {
    //   setState(() {
    //     popularMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    /// Popular Movies From Database
    movieModel.getPopularMoviesFromDatabase().listen((movieList){
      setState(() {
        popularMovies = movieList;
      });
    }).onError((error){
      debugPrint(error.toString());
    });

    /// Top Rated Movies
    // movieModel.getTopRatedMovies(1).then((movieList) {
    //   setState(() {
    //     topRatedMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    /// Top Rated Movies From Database
    movieModel.getTopRatedMoviesFromDatabase().listen((movieList){
      setState(() {
        topRatedMovies = movieList;
      });
    }).onError((error){
      debugPrint(error.toString());
    });

    /// Genres
    movieModel.getGenres().then((genres) {
      setState(() {
        this.genres = genres;
      });
    /// Movie By Genre
      _getMoviesByGenre(genres?.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Genres From Database
    movieModel.getGenresFromDatabase().then((genreList){
      setState(() {
        genres = genreList;
        /// Movies By Genre
        _getMoviesByGenre(genreList.first.id );
      });
    }).catchError((error){
      debugPrint(error.toString());
    });

    /// Actors
    movieModel.getActors(1).then((actors) {
      setState(() {
        this.actors = actors;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
    super.initState();

    /// Actors From Database
    movieModel.getAllActorsFromDatabase().then((actorList){
      setState(() {
        actors=actorList;
      });
    }).catchError((error){
      debugPrint(error.toString());
    });
  }

  void _getMoviesByGenre(int genreId) {
    movieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
      setState(() {
        this.moviesByGenre = moviesByGenre;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          MAIN_SCREEN_APP_BAR_TITLE,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Icon(
          Icons.menu,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 0,
              bottom: 0,
              right: MARGIN_MEDIUM_2,
            ),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerSectionView(
                movieList: popularMovies?.take(5).toList(),
              ),
              SizedBox(height: MARGIN_LARGE),
              BestPopularMoviesAndSerialsView(
                /// Navigate
                onTapMovie: (movieId) => _navigateToMovieDetailsScreen(context,movieId),
                nowPlayingMovies: nowPlayingMovies,
              ),
              SizedBox(height: MARGIN_LARGE),
              CheckMovieShowTimeSectionView(),
              SizedBox(height: MARGIN_LARGE),
              GenreSectionView(
                /// Navigate to details screen
                onTapMovie: (movieId) => _navigateToMovieDetailsScreen(context,movieId),
                genreList: genres, moviesByGenre: moviesByGenre, onChooseGenre: (genreId) {
                  if(genreId != null){
                    _getMoviesByGenre(genreId);
                  }
              },
              ),
              SizedBox(height: MARGIN_LARGE),
              ShowcasesSection(topRatedMovies: topRatedMovies),
              SizedBox(height: MARGIN_LARGE),
              ActorsAndCreatorSectionView(BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE,
                  actorsList: actors),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int? movieId) {
    if(movieId != null){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetalisPage(
            movieId: movieId,
          ),
        ),
      );
    }
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? moviesByGenre;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenre;

  GenreSectionView(
      {required this.genreList,
      required this.moviesByGenre,
      required this.onTapMovie, required this.onChooseGenre});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: MAIN_HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map(
                        (genre) => Tab(
                          child: Text(genre.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
              onTap: (index){
                onChooseGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) => this.onTapMovie(movieId),
            movieList: moviesByGenre,
          ),
        )
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  const CheckMovieShowTimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_LARGE),
      height: MOVIE_SHOW_TIMES_SECTION,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          )
        ],
      ),
    );
  }
}

class ShowcasesSection extends StatelessWidget {
  late final List<MovieVO>? topRatedMovies;

  ShowcasesSection({required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        child: TitleTextWithSeeMoreView(
          SHOW_CASES_TITLE,
          SHOW_CASES_SEE_MORE,
        ),
      ),
      SizedBox(height: MARGIN_MEDIUM_2),
      Container(
        height: SHOW_CASES_HEIGHT,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          children: topRatedMovies
                  ?.map(
                    (topRatedMovies) => ShowCaseView(
                      movie: topRatedMovies,
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    ]);
  }
}

class BestPopularMoviesAndSerialsView extends StatelessWidget {
  final Function onTapMovie;

  final List<MovieVO>? nowPlayingMovies;

  BestPopularMoviesAndSerialsView(
      {required this.onTapMovie, required this.nowPlayingMovies});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIE_AND_SERIALS)),
        SizedBox(height: MARGIN_MEDIUM_2),
        HorizontalMovieListView(
          onTapMovie: (movieId) => this.onTapMovie(movieId),
          movieList: nowPlayingMovies,
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemCount: movieList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => onTapMovie(movieList?[index].id),
                  child: MovieView(
                    movie: movieList?[index],
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  late final List<MovieVO>? movieList;

  BannerSectionView({required this.movieList});

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.movieList
                    ?.map(
                      (movie) => BannerView(
                        movie: movie,
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: (widget.movieList?.length == 0) ? 1 : widget.movieList?.length ?? 1,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INCATIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        )
      ],
    );
  }
}
