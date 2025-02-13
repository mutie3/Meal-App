import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/meal_detial_secreen.dart';
import 'package:meals/widgets/meal_item.dart';
import '../models/meal.dart';
import '../providers/filters_provider.dart';

class MealsSecreen extends ConsumerWidget {
  final String? title;
  final List<Meal> meals;
  List<String> yourFilters(WidgetRef ref) {
    final selectedFilters = ref.watch(filtersProvider);
    List<String> fil = [];
    if (selectedFilters[Filter.glutenFreeFilter]!) {
      fil.add("Gluten-Free");
    }
    if (selectedFilters[Filter.lactoseFreeFilter]!) {
      fil.add("Lactose-Free");
    }
    if (selectedFilters[Filter.veganFilter]!) {
      fil.add("Vegan");
    }
    if (selectedFilters[Filter.vegantarianFilter]!) {
      fil.add("Vvegantarian");
    }
    return fil;
  }

  const MealsSecreen({
    super.key,
    this.title,
    required this.meals,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return title == null
        ? content(context)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content(context));
  }

  SingleChildScrollView content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: meals
            .map((meal) => MealItem(
                  meal: meal,
                  onSelectMeal: (Meal meal) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => MealDetailScreen(
                          meal: meal,
                        ),
                      ),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
