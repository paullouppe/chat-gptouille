import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart';
import 'package:flutter_app/services/requests.dart';
import 'dart:math';

// Main page.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Shows default, random recipes unless the user makes a search.
class _HomePageState extends State<HomePage> {
  // Stores data obtained from database
  List<Map<String, dynamic>> recipes = [];
  // Stores images to randomly assign to recipes.
  List<String> recipeImages = [
    "assets/images/recipes/meal1.jpg",
    "assets/images/recipes/meal2.jpg",
    "assets/images/recipes/meal3.jpg",
    "assets/images/recipes/meal4.jpg",
    "assets/images/recipes/meal5.jpg",
    "assets/images/recipes/meal6.jpg"
  ];

  // Stores search results
  List<dynamic> searchResults = [];

  // Fetches 6 random recipes to populate the default home page.
  Future<void> fetchRecipe() async {
    //stores the database urls to grab a recipe from.
    Set<String> recipesUrl = {};
    recipeImages.shuffle();

    // Randomly chosen recipe ids in the 10 000 recipes imported at startup.
    while (recipesUrl.length < 6) {
      recipesUrl
          .add('http://localhost:8080/recipes/${Random().nextInt(10000) + 1}');
    }

    // Api call
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

                // Page title
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
                        FocusScope.of(context)
                            .unfocus(); // Close keyboard to avoid risks of error on submit

                        // From the user prompt, returns the 6 first results from a semantic search in the database
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
                          recipes.take(3).length, // The first 3 elements
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
                          recipes.skip(3).take(3).length, // The next 3 elements
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

  // Helper function to create RecipeCard widgets based on recipeData obtaned from API call and missing info generated semi-randomly.
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
