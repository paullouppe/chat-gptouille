import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_app/theme/theme_provider.dart';
import 'package:flutter_app/theme/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  //Fonction qui indique ce qu'il faut faire si le bouton "sign out" est appuyé
  void pressedDeco() {}
  void pressedDelete() {}

  // Liste des boutons avec chemins des icônes et textes
  final List<Map<String, String>> buttonDiet = [
    {
      "icon": "assets/images/icon_carrot.png",
      "selectedIcon": "assets/images/icon_carrot_selected.png",
      "text": "Vegetarian"
    },
    {
      "icon": "assets/images/icon_leaf.png",
      "selectedIcon": "assets/images/icon_leaf_selected.png",
      "text": "Vegan"
    },
    {
      "icon": "assets/images/icon_pork.png",
      "selectedIcon": "assets/images/icon_pork_selected.png",
      "text": "Without pork"
    },
    {
      "icon": "assets/images/icon_wheat.png",
      "selectedIcon": "assets/images/icon_wheat_selected.png",
      "text": "Gluten free"
    },
    {
      "icon": "assets/images/icon_milk.png",
      "selectedIcon": "assets/images/icon_milk_selected.png",
      "text": "Lactose free"
    },
    {
      "icon": "assets/images/icon_fish.png",
      "selectedIcon": "assets/images/icon_fish_selected.png",
      "text": "Pescetarian"
    },
  ];

  List<bool> selectedButtonsDiet = List.generate(6, (index) => false);

  final List<Map<String, String>> buttonsEquipement = [
    {
      "icon": "assets/images/icon_microwave.png",
      "selectedIcon": "assets/images/icon_microwave_selected.png",
      "text": "Vegetarian"
    },
    {
      "icon": "assets/images/icon_oven.png",
      "selectedIcon": "assets/images/icon_oven_selected.png",
      "text": "Vegan"
    },
    {
      "icon": "assets/images/icon_bake.png",
      "selectedIcon": "assets/images/icon_bake_selected.png",
      "text": "Without pork"
    },
    {
      "icon": "assets/images/icon_mixer.png",
      "selectedIcon": "assets/images/icon_mixer_selected.png",
      "text": "Gluten free"
    },
    {
      "icon": "assets/images/icon_robot.png",
      "selectedIcon": "assets/images/icon_robot_selected.png",
      "text": "Lactose free"
    },
    {
      "icon": "assets/images/icon_fish.png",
      "selectedIcon": "assets/images/icon_fish_selected.png",
      "text": "Pescetarian"
    },
  ];

  List<bool> selectedButtonsEquipement = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  400, // Largeur maximale pour éviter l'étirement sur grands écrans
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profil utilisateur
                  Row(
                    children: [
                      const Image(
                        image: AssetImage("assets/images/icon_user.png"),
                        width: 80.0,
                        height: 80.0,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            'Paul Louppe',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFE724C)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Titres "Your preferences" et "Your diet"
                  Text(
                    'Your preferences',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text('Your diet',
                      style: Theme.of(context).textTheme.bodyMedium),

                  const SizedBox(height: 10),

                  //Liste des boutons scrollables
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(buttonDiet.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedButtonsDiet[index] =
                                !selectedButtonsDiet[index];
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: selectedButtonsDiet[index]
                                  ? const Color(0xFFFE724C)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                selectedButtonsDiet[index]
                                    ? buttonDiet[index]["selectedIcon"]!
                                    : buttonDiet[index]["icon"]!,
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                buttonDiet[index]["text"]!,
                                style: TextStyle(
                                  color: selectedButtonsDiet[index]
                                      ? const Color(0xFFFE724C)
                                      : const Color(0xFF5B5B5E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  Text('Your equipement',
                      style: Theme.of(context).textTheme.bodyMedium),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(buttonsEquipement.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedButtonsEquipement[index] =
                                !selectedButtonsEquipement[index];
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: selectedButtonsEquipement[index]
                                  ? const Color(0xFFFE724C)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                selectedButtonsEquipement[index]
                                    ? buttonsEquipement[index]["selectedIcon"]!
                                    : buttonsEquipement[index]["icon"]!,
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                buttonsEquipement[index]["text"]!,
                                style: TextStyle(
                                  color: selectedButtonsEquipement[index]
                                      ? const Color(0xFFFE724C)
                                      : const Color(0xFF5B5B5E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  Text('Account settings',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 10),
                  // Bouton "Sign out"
                  Row(
                    children: [
                      Text("Theme selection :",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 10),
                      ToggleSwitch(
                        minWidth: 90.0,
                        initialLabelIndex:
                            themeProvider.themeData == AppThemes.darkTheme
                                ? 1
                                : 0,
                        cornerRadius: 20.0,
                        totalSwitches: 2,
                        icons: [Icons.light_mode, Icons.dark_mode],
                        onToggle: (index) {
                          if (index == 0) {
                            themeProvider
                                .setLightTheme(); // Appliquer le thème clair
                          } else {
                            themeProvider
                                .setDarkTheme(); // Appliquer le thème sombre
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 360.0,
                    height: 50.0,
                    child: ButtonGeneric(
                        content: "Sign out", pressedFunction: pressedDeco),
                  ),
                  const SizedBox(height: 16),

                  // Bouton "Delete"
                  SizedBox(
                    width: 360.0,
                    height: 50.0,
                    child: OutlinedButton(
                      onPressed: pressedDelete,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context)
                            .colorScheme
                            .primary, // Texte orange
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2), // Bordure orange
                        backgroundColor: Colors.transparent, // Fond blanc
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15.0), // Bordures arrondies
                        ),
                      ),
                      child: Text(
                        "Delete your account",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold), // Style du texte
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
