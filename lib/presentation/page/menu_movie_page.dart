import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/models/movie_model.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/presentation/page/movies/category_movie_page.dart';
import 'package:indoscape/presentation/page/movies/detail_movie_page.dart';
import 'package:indoscape/presentation/widget/shimmer_widget.dart';
import 'package:skeletons/skeletons.dart';

class MenuMoviePage extends StatefulWidget {
  const MenuMoviePage({Key? key}) : super(key: key);
  static const routeName = '/menu_movie_page';

  @override
  State<MenuMoviePage> createState() => _MenuMoviePageState();
}

class _MenuMoviePageState extends State<MenuMoviePage> {
  int page = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: textColor),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _carouselMoviesNowPlaying(),
                  const VerticalGap20(),
                  _titleCategory('Popular Movies', 1),
                  const VerticalGap10(),
                  _moviesListByCategory(Repository().getPopularMovies(page)),
                  const VerticalGap10(),
                  _titleCategory('Top Rated Movies', 2),
                  const VerticalGap10(),
                  _moviesListByCategory(Repository().getTopRatedMovies(page)),
                  const VerticalGap10(),
                  _titleCategory('Upcoming Movies', 3),
                  const VerticalGap10(),
                  _moviesListByCategory(Repository().getUpcomingMovies(page)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 48,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: backgroundColor,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Coming Soon'),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        color: backgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<MovieModel> _moviesListByCategory(category) {
    return FutureBuilder(
      future: category,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3.75,
            child: _moviesListView(data),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3.75,
            child: const ShimmerMoviesListView(),
          );
        }
      },
    );
  }

  Skeleton _moviesListView(MovieModel? data) {
    return Skeleton(
      isLoading: isLoading,
      duration: const Duration(seconds: 2),
      themeMode: ThemeMode.light,
      shimmerGradient: _shimmerGradientCustom(),
      skeleton: const ShimmerMoviesListView(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const HorizontalGap10(),
        itemCount: data!.results!.length,
        itemBuilder: (context, index) {
          final movie = data.results![index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailMoviePage.routeName,
                arguments: movie.id,
              );
            },
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const VerticalGap10(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title!,
                        style: jakartaH5.copyWith(
                          color: backgroundColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const VerticalGap5(),
                      Text(
                        movie.releaseDate!.year.toString(),
                        style: jakartaCaption.copyWith(
                          color: backgroundColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  FutureBuilder<MovieModel> _carouselMoviesNowPlaying() {
    return FutureBuilder(
      future: Repository().getNowPlayingMovies(page),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Skeleton(
            isLoading: isLoading,
            duration: const Duration(seconds: 2),
            themeMode: ThemeMode.light,
            shimmerGradient: _shimmerGradientCustom(),
            skeleton: const ShimmerMoviesCarouselLists(),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 1.75,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                viewportFraction: 1,
              ),
              itemCount: data!.results!.length,
              itemBuilder: (context, index, realIndex) {
                final movie = data.results![index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailMoviePage.routeName,
                      arguments: movie.id,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                textColor.withOpacity(.25),
                                textColor,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title!,
                                style: jakartaH3.copyWith(
                                  color: backgroundColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const VerticalGap5(),
                              Text(
                                movie.releaseDate!.year.toString(),
                                style: jakartaCaption.copyWith(
                                  color: backgroundColor.withOpacity(.75),
                                ),
                              ),
                              const VerticalGap5(),
                              Text(
                                movie.overview.toString(),
                                style: jakartaButton.copyWith(
                                  color: backgroundColor.withOpacity(.75),
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const ShimmerMoviesCarouselLists();
        }
      },
    );
  }

  InkWell _titleCategory(String title, int id) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          CategoryMoviePage.routeName,
          arguments: id,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: const BoxDecoration(color: primaryColor),
                ),
                const HorizontalGap5(),
                Text(
                  title,
                  style: jakartaH3.copyWith(
                    color: backgroundColor,
                  ),
                ),
              ],
            ),
            Text(
              'Show all',
              style: jakartaBodyText2.copyWith(color: primaryColor),
            )
          ],
        ),
      ),
    );
  }

  LinearGradient _shimmerGradientCustom() {
    return LinearGradient(
      colors: [
        primaryColor.withOpacity(.25),
        primaryColor.withOpacity(.5),
        primaryColor.withOpacity(.25),
      ],
      begin: const Alignment(-1.0, -0.5),
      end: const Alignment(1.0, 0.5),
      stops: const [0.0, 0.5, 1.0],
      tileMode: TileMode.repeated,
    );
  }
}
