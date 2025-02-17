import 'package:flutter/material.dart';
import 'recipe_price_icon.dart';
import 'recipe_tag.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String duration;
  final List<String> ratings;
  final List<String> tags;
  final int price;
  final double height;

  // Constructor with required parameters
  const RecipeCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.ratings,
    required this.tags,
    required this.duration,
    required this.price,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: height * 1.15,
        height: height,
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Get the width of the card
                  double cardWidth = constraints.maxWidth;
                  double cardHeight = constraints.maxHeight;
                  double iconSize = cardWidth * 0.06;
                  double spaceWidth = cardWidth * 0.11;
                  double titleFontSize = cardHeight * 0.08;
                  double ratingFontSize = cardHeight * 0.04;
                  double otherFontSize = cardHeight * 0.05;
                  double tagBorderRadius = cardHeight * 0.04;
                  double favoriteSize = cardHeight * 0.14;

                  return
                      // Superior section with background image
                      Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        // Background Image
                        Expanded(
                          flex: 5,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                  image: DecorationImage(
                                    image: AssetImage(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Button on top right
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFE724C),
                                      shape: BoxShape.circle),
                                  height: favoriteSize,
                                  child: IconButton(
                                    icon: Icon(Icons.favorite,
                                        size: favoriteSize / 1.7,
                                        color: Colors.white),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              // Small image on top left
                              Positioned(
                                top: 15,
                                left: 10,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      // First Element
                                      Text(
                                        ratings[0],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ratingFontSize * 1.3,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Second Element
                                      Icon(Icons.star,
                                          color: Colors.yellow,
                                          size: iconSize / 1.5),
                                      SizedBox(
                                          width: 4), // Space between elements
                                      SizedBox(
                                          width: 4), // Space between elements
                                      // Third Element
                                      Text(
                                        ratings[1],
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: ratingFontSize),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Bottom section
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                        fontSize: titleFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    ...List.generate(
                                        3,
                                        (index) => Row(
                                              children: [
                                                PriceIcon(
                                                    isFilled: index < price,
                                                    iconSize: iconSize),
                                                SizedBox(
                                                    width:
                                                        4.0), // Space after each icon
                                              ],
                                            )),
                                    SizedBox(width: spaceWidth), // Space
                                    Icon(Icons.alarm,
                                        color: Color(0xFFFE724C),
                                        size: iconSize),
                                    SizedBox(width: 4.0),
                                    Text(duration,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 97, 97, 97),
                                            fontSize: otherFontSize)),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ...List.generate(
                                        tags.length,
                                        (index) => Row(
                                              children: [
                                                RecipeTag(
                                                  text: tags[index],
                                                  borderRadius: tagBorderRadius,
                                                  fontSize: otherFontSize / 1.2,
                                                ),
                                                SizedBox(width: spaceWidth / 3)
                                              ],
                                            )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
