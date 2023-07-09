import 'package:flutter/widgets.dart';

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
    return Container();
  }
}
