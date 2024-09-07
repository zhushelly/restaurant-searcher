import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';

// load JSON file
class RestaurantNotifier extends StateNotifier<List<Restaurant>> {
  RestaurantNotifier() : super([]);

  // maps JSON to Restaurant objects
  Future<void> loadRestaurants() async {
    final data = await rootBundle.loadString('assets/restaurants.json');
    final List<dynamic> jsonResult = json.decode(data);
    state = jsonResult.map((json) => Restaurant.fromJson(json)).toList();
  }
}

// subscribe to changes in the restaurantProvider, so UI automatically updates when list of restaurants is updated or filtered
final restaurantProvider = StateNotifierProvider<RestaurantNotifier, List<Restaurant>>((ref) {
  return RestaurantNotifier()..loadRestaurants();
});
