import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/presentation/page/movies/detail_movie_page.dart';

class CategoryMoviePage extends StatefulWidget {
  const CategoryMoviePage({super.key, required this.id});
  static const routeName = '/category-movie-page';
  final int id;

  @override
  State<CategoryMoviePage> createState() => _CategoryMoviePageState();
}

class _CategoryMoviePageState extends State<CategoryMoviePage> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      appBar: _appBarSection(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: widget.id == 1
              ? Repository().getPopularMovies(page)
              : (widget.id == 2
                  ? Repository().getTopRatedMovies(page)
                  : Repository().getUpcomingMovies(page)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: data!.results!.length,
                itemBuilder: (context, index) {
                  final movie = data.results![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailMoviePage.routeName,
                        arguments: movie.id,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  AppBar _appBarSection(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        widget.id == 1
            ? 'Popular Movies'
            : (widget.id == 2 ? 'Top Rated Movies' : 'Upcoming Movies'),
        style: jakartaH3,
      ),
    );
  }
}
