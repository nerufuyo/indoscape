import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/data/repositories/repository.dart';

class MenuFoodPage extends StatefulWidget {
  const MenuFoodPage({super.key});
  static const routeName = '/menu_food_page';

  @override
  State<MenuFoodPage> createState() => _MenuFoodPageState();
}

class _MenuFoodPageState extends State<MenuFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food'),
      ),
      body: FutureBuilder(
        future: Repository().getFoodList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final food = data[index];
                  return Text(food.name.toString());
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
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
    );
  }
}
