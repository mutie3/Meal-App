import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';

class FavProviderNotifier extends StateNotifier<List<Meal>> {
  FavProviderNotifier() : super([]);
  bool toggelMealFav(Meal meal) {
    bool isExist = state.contains(meal);
    if (isExist) {
      state = state.where((element) => element.id != meal.id).toList();
      return true;
    } else {
      state = [...state, meal];
      return false;
    }
  }
}

final favProviderNotifier =
    StateNotifierProvider<FavProviderNotifier, List<Meal>>((ref) {
  return FavProviderNotifier();
});
