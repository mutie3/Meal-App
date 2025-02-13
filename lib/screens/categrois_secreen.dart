import 'package:flutter/material.dart';
import 'package:meals/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';
import '../models/meal.dart';

class CategroisSecreen extends StatelessWidget {
  const CategroisSecreen({super.key, required this.avilableMeals});

  final List<Meal> avilableMeals;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              avilableMeals: avilableMeals,
            ),
        ],
      ),
    );
  }
}
