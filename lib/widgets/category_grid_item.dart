import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_secreen.dart';
import '../models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.avilableMeals,
  });

  final List<Meal> avilableMeals;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6, // ارتفاع الظل لخلق عمق
      borderRadius: BorderRadius.circular(16),
      shadowColor: category.color.withOpacity(0.3), // ظل بلون التدرج
      child: InkWell(
        onTap: () {
          final List<Meal> filteredMeal = avilableMeals
              .where((meal) => meal.categories.contains(category.id))
              .toList();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MealsSecreen(
                title: category.title,
                meals: filteredMeal,
              ),
            ),
          );
        },
        splashColor: category.color.withOpacity(0.3), // لون تأثير الضغط
        highlightColor: category.color.withOpacity(0.1), // تأثير اللمس الخفيف
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.7),
                category.color.withOpacity(1.0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              category.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white, // جعل النص أبيض ليتناسب مع الخلفية
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2, // تحسين القراءة
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
