import 'package:flutter/material.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key, required this.id});
  static const routeName = '/food_detail_page';
  final int id;

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.id.toString()),
      ),
    );
  }
}
