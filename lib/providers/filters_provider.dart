import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFreeFilter,
  lactoseFreeFilter,
  veganFilter,
  vegantarianFilter,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFreeFilter: false,
          Filter.lactoseFreeFilter: false,
          Filter.veganFilter: false,
          Filter.vegantarianFilter: false,
        });
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());
final filterdMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (selectedFilters[Filter.glutenFreeFilter]! && !meal.isGlutenFree) {
      return false;
    }
    if (selectedFilters[Filter.lactoseFreeFilter]! && !meal.isLactoseFree) {
      return false;
    }
    if (selectedFilters[Filter.veganFilter]! && !meal.isVegan) {
      return false;
    }
    if (selectedFilters[Filter.vegantarianFilter]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
