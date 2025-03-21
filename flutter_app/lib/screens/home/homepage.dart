import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart';
import 'package:flutter_app/services/requests.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> recipes = [];
  List<String> recipeImages = [
    "assets/images/recipes/meal1.jpg",
    "assets/images/recipes/meal2.jpg",
    "assets/images/recipes/meal3.jpg",
    "assets/images/recipes/meal4.jpg",
    "assets/images/recipes/meal5.jpg",
    "assets/images/recipes/meal6.jpg"
  ];

  List<dynamic> searchResults = []; // Store search results

  Future<void> fetchRecipe() async {
    Set<String> recipesUrl = {};
    recipeImages.shuffle();

    while (recipesUrl.length < 6) {
      recipesUrl
          .add('http://localhost:8080/recipes/${Random().nextInt(10000) + 1}');
    }

    try {
      List<List<Map<String, dynamic>>> results = await Future.wait(
        recipesUrl.map((url) => getRecipe(url)),
      );
      List<Map<String, dynamic>> allRecipes =
          results.expand((list) => list).toList();

      if (mounted) {
        setState(() {
          recipes = allRecipes;
        });
      }
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20),
                  child: Image.asset('assets/images/gptouille_logo.png'),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'What do you want to eat?',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Find a recipe...",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                      onSubmitted: (query) async {
                        FocusScope.of(context).unfocus(); // Close keyboard

                        List<dynamic> results =
                            await fetchSearchResults(query, 6);
                        if (!context.mounted) return;

                        setState(() {
                          searchResults = results; // Update search results
                        });
                      },
                    ),
                  ),
                ),

                // If searchResults is not empty, show search results
                if (searchResults.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Search Results",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate(
                          searchResults.length,
                          (index) =>
                              _buildRecipeCard(searchResults[index], index),
                        ),
                      ),
                    ),
                  ),
                ]
                // Else, show the default layout
                else ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Recipes you might like",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          recipes.take(3).length,
                          (index) => _buildRecipeCard(
                              recipes.take(3).elementAt(index), index),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "They also liked",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          recipes.skip(3).take(3).length,
                          (index) => _buildRecipeCard(
                              recipes.skip(3).take(3).elementAt(index),
                              index + 3),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to create RecipeCard widgets
  Widget _buildRecipeCard(Map<String, dynamic> recipeData, int index) {
    return RecipeCard(
      title: recipeData['name'],
      imagePath: recipeImages[index],
      tags: ["TASTY", "EASY"],
      duration: "${recipeData['minutes']} min",
      ratings: [
        (Random().nextInt(3) + 2).toString(),
        "(${Random().nextInt(12) * 5 + 20}+)"
      ],
      price: Random().nextInt(3) + 1,
      height: 425,
    );
  }
}
