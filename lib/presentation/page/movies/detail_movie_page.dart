import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/models/detail_movie_model.dart';
import 'package:indoscape/data/repositories/repository.dart';

class DetailMoviePage extends StatefulWidget {
  const DetailMoviePage({Key? key, required this.id}) : super(key: key);
  static const routeName = '/detail_movie_page';
  final int id;

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: textColor,
        body: FutureBuilder(
          future: Repository().getMovieById(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              final int runtime = data!.runtime!;
              final int runtimeHours = runtime ~/ 60;
              final int runtimeMinutes = runtime % 60;
              final double reviewersFormatted = data.voteCount! / 1000;

              return Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _posterSection(context, data),
                          const VerticalGap10(),
                          _statusAndReviewsSection(data, reviewersFormatted),
                          const VerticalGap10(),
                          _companiesSection(context, data),
                          const VerticalGap10(),
                          _titleSection(data),
                          const VerticalGap10(),
                          _genresSection(context, data),
                          _divider(),
                          _overviewSection(data),
                          _divider(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 48,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(.5),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Icon(
                                Icons.close,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(.5),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            '$runtimeHours hour $runtimeMinutes minutes',
                            style: jakartaH4.copyWith(color: backgroundColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
          },
        ));
  }

  Padding _overviewSection(DetailMovieModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        data.overview!,
        style: jakartaBodyText2.copyWith(
          color: backgroundColor,
        ),
      ),
    );
  }

  Padding _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Divider(
        color: backgroundColor.withOpacity(.25),
        thickness: 1,
      ),
    );
  }

  Padding _statusAndReviewsSection(
      DetailMovieModel data, double reviewersFormatted) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(
              data.status.toString(),
              style: jakartaH5.copyWith(
                color: backgroundColor,
              ),
            ),
          ),
          const HorizontalGap5(),
          const Icon(
            Icons.star_rate_rounded,
            color: Colors.yellow,
          ),
          Text(
            double.parse(data.voteAverage.toString()).toStringAsFixed(1),
            style: jakartaH4.copyWith(
              color: Colors.yellow,
            ),
          ),
          const HorizontalGap5(),
          Text(
            '(${reviewersFormatted.toString()} reviews)',
            style: jakartaCaption.copyWith(
              color: backgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _companiesSection(BuildContext context, DetailMovieModel data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 36,
      child: Row(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: data.productionCompanies!.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      data.productionCompanies![index].name!,
                      style: jakartaBodyText2.copyWith(
                        color: backgroundColor.withOpacity(.5),
                      ),
                    ),
                    if (index != data.productionCompanies!.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '|',
                          style: jakartaBodyText2.copyWith(
                            color: backgroundColor.withOpacity(.5),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _genresSection(BuildContext context, DetailMovieModel data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const HorizontalGap10(),
        itemCount: data.genres!.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                data.genres![index].name!,
                style: jakartaCaption.copyWith(
                  color: backgroundColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _titleSection(DetailMovieModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        data.title!,
        style: jakartaH2.copyWith(color: backgroundColor),
      ),
    );
  }

  Container _posterSection(BuildContext context, DetailMovieModel? data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.75,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w500${data!.posterPath}',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.75,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.transparent,
              textColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
