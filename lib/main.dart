import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/restaurant_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RestaurantListScreen(),
    );
  }
}

// handle user input and render the restaurant list
class RestaurantListScreen extends ConsumerStatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends ConsumerState<RestaurantListScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final restaurants = ref.watch(restaurantProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Restaurants...',
                border: OutlineInputBorder(),
                filled: true,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          if (searchQuery.isEmpty || restaurant.name.toLowerCase().contains(searchQuery.toLowerCase())) {
            return ListTile(
              title: Text(restaurant.name),
              subtitle: Text(restaurant.cuisine),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
