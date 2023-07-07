import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class filtersNotifier extends StateNotifier<Map<Filter, bool>> {
  filtersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenfilter) {
    state = chosenfilter;
  }
}

final filterProvider =
    StateNotifierProvider<filtersNotifier, Map<Filter, bool>>(
        (ref) => filtersNotifier());
