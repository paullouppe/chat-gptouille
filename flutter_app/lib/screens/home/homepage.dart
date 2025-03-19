import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart';

//Classe qui donne le contenu de la Homepage sans prendre en considératiion le navigation bar qui est traité à part.
//(c'est là où on construit la page, pas au dessus)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              ),
            ),

            // Image
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
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
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

            // First Row of Cards
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                        child: RecipeCard(
                      title: "Vegan Taccos",
                      imagePath: "assets/images/recipes/vegan_tacos.png",
                      tags: ["VEGAN", "EASY"],
                      duration: "10 to 15 mins",
                      ratings: ["4,5", "(25+)"],
                      price: 2,
                      height: 425,
                    )),
                    Center(
                        child: RecipeCard(
                      title: "Yummy Noodles",
                      imagePath: "assets/images/recipes/noodles.png",
                      tags: ["VARIED", "FLAVORFUL", "GREAT"],
                      duration: "20 to 30 mins",
                      ratings: ["4", "(20+)"],
                      price: 1,
                      height: 425,
                    )),
                    Center(
                        child: RecipeCard(
                      title: "Vegan Taccos",
                      imagePath: "assets/images/recipes/vegan_tacos.png",
                      tags: ["VEGAN", "EASY"],
                      duration: "10 to 15 mins",
                      ratings: ["4,5", "(25+)"],
                      price: 2,
                      height: 425,
                    )),
                  ],
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("They also liked",
                    style: Theme.of(context).textTheme.headlineLarge)),

            // Second Row of Cards
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                        child: RecipeCard(
                      title: "Vegan Taccos",
                      imagePath: "assets/images/recipes/vegan_tacos.png",
                      tags: ["VEGAN", "EASY"],
                      duration: "10 to 15 mins",
                      ratings: ["4,5", "(25+)"],
                      price: 2,
                      height: 425,
                    )),
                    Center(
                        child: RecipeCard(
                      title: "Yummy Noodles",
                      imagePath: "assets/images/recipes/noodles.png",
                      tags: ["VARIED", "FLAVORFUL", "GREAT"],
                      duration: "20 to 30 mins",
                      ratings: ["4", "(20+)"],
                      price: 1,
                      height: 425,
                    )),
                    Center(
                        child: RecipeCard(
                      title: "Vegan Taccos",
                      imagePath: "assets/images/recipes/vegan_tacos.png",
                      tags: ["VEGAN", "EASY"],
                      duration: "10 to 15 mins",
                      ratings: ["4,5", "(25+)"],
                      price: 2,
                      height: 425,
                    )),
                  ],
                ),
              ),
            ),
          ]),
        ),
      )),
    );
  }
}
