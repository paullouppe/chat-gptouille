import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  // Liste des boutons avec chemins des icônes et textes
  final List<Map<String, String>> buttons_diet = [
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

  final List<Map<String, String>> buttons_equipement = [
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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  400, // ✅ Largeur maximale pour éviter l'étirement sur grands écrans
            ),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profil utilisateur
                  Row(
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 80.0,
                        color: Color(0xFFFE724C),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Hello,',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Paul Louppe',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFE724C)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Bouton "Sign out"
                  SizedBox(
                    width: 360.0,
                    height: 50.0,
                    child: ButtonGeneric(content: "Sign out"),
                  ),

                  const SizedBox(height: 20),

                  // Titres "Your preferences" et "Your diet"
                  const Text(
                    'Your preferences',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF323643),
                    ),
                  ),
                  const Text(
                    'Your diet',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF67666D),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ✅ Liste des boutons scrollables
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(buttons_diet.length, (index) {
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
                                    ? buttons_diet[index]["selectedIcon"]!
                                    : buttons_diet[index]["icon"]!,
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                buttons_diet[index]["text"]!,
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

                  const Text(
                    'Your equipement',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF67666D),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(buttons_equipement.length, (index) {
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
                                    ? buttons_equipement[index]["selectedIcon"]!
                                    : buttons_equipement[index]["icon"]!,
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                buttons_equipement[index]["text"]!,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
