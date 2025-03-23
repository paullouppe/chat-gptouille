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
  final double width;

  const RecipeCard(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.ratings,
      required this.tags,
      required this.duration,
      required this.price,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            // Image Section
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Ratings badge (top left)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            ratings[0],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          const SizedBox(width: 2),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            ratings[1],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Favorite button (top right)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      child: Icon(Icons.favorite_border,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),

            // Info Section
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title[0].toUpperCase() + title.substring(1),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),

                    // Price & Duration
                    Row(
                      children: [
                        ...List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: PriceIcon(
                              isFilled: index < price,
                              iconSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.alarm,
                            size: 18, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Tags
                    Wrap(
                      spacing: 8,
                      children: tags
                          .map((tag) => RecipeTag(
                                text: tag,
                                borderRadius: 20,
                                fontSize: 12,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
