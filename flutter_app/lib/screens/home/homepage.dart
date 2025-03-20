import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/search_results.dart';
import '../widgets/recipe_card.dart';
import 'package:flutter_app/services/requests.dart';
import 'dart:math';

//Classe qui donne le contenu de la Homepage sans prendre en considératiion le navigation bar qui est traité à part.
//(c'est là où on construit la page, pas au dessus)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> recipes = [];

  Future<void> fetchRecipe() async {
    Set<String> recipesUrl = {};

    while (recipesUrl.length < 6) {
      recipesUrl.add('http://localhost:8080/recipes/${Random().nextInt(10000) + 1}');
    }

    try {
      List<List<Map<String, dynamic>>> results = await Future.wait(
        recipesUrl.map((url) => getRecipe(url)),
      );
      List<Map<String, dynamic>> allRecipes = results.expand((list) => list).toList();

      // Vérifier si le widget est encore monté avant de faire un setState
      if (mounted) {
        setState(() {
          recipes = allRecipes;
        });
      }
    } catch (e) {
      // Gérer les erreurs ici
      print('Erreur lors de la récupération des recettes: $e');
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //Logo
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: Image.asset('assets/images/gptouille_logo.png')),

            // Title Text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'What do you want to eat?',
                style: Theme.of(context).textTheme.headlineLarge,

              ),),
           

              // Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      hintText: "Find a recipe...",
                      hintStyle: WidgetStateProperty.all(
                      TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary), // Light grey color
                    ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (String query) async {
                // Call the API with the user's query
                List<dynamic> results = await fetchSearchResults(query);
                
                // Navigate to another page and pass the results
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResults(results: results),
                  ),
                );
              },
                      leading: const Icon(Icons.search),
                    );
                  },
                  suggestionsBuilder: (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                      );
                    });
                  },
                ),
              ),
                    Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Recipes you might like",
                  style: Theme.of(context).textTheme.headlineLarge,
                )),

                    // First Row of Recipe Cards
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: recipes
                              .take(3)
                              .map((recipeData) => _buildRecipeCard(recipeData))
                              .toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("They also liked",
                    style: Theme.of(context).textTheme.headlineLarge)),

                    // Second Row of Recipe Cards
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: recipes
                              .skip(3)
                              .take(3)
                              .map((recipeData) => _buildRecipeCard(recipeData))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ));
  }
}

  // Helper function to create RecipeCard widgets
  Widget _buildRecipeCard(Map<String, dynamic> recipeData) {
    return RecipeCard(
      title: recipeData['name'],
      imagePath: "assets/images/recipes/vegan_tacos.png",
      tags: ["EASY"],
      duration: "${recipeData['minutes']} min",
      ratings: ["3", "20+"],
      price: 3,
      height: 425,
    );
  }
