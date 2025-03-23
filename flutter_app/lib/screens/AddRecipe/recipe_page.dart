import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

// Page to add a recipe.
class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  RecipePageState createState() => RecipePageState();
}

class RecipePageState extends State<AddRecipePage> {
  //Controllers for ingredients, quantity and description TextFields.
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ingrNameController = TextEditingController();
  TextEditingController quantiteController = TextEditingController();

  // Stores ingredients added by users.
  List<Map<String, String>> ingredients = [];

  // Function to add an ingredient
  void addIngredient() {
    String ingredientName = ingrNameController.text;
    String quantity = quantiteController.text;

    // Added only if fields are not empty.
    if (ingredientName.isNotEmpty && quantity.isNotEmpty) {
      setState(() {
        ingredients.add({'name': ingredientName, 'quantity': quantity});
      });

      // Reinitializing controllers to allow for new ingredients.
      ingrNameController.clear();
      quantiteController.clear();
    }
  }

  // Function to add a recipe.
  void pressedAdd() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add a recipe',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 40),
              Text(
                'Add an image',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              ImagePickerWidget(),
              SizedBox(height: 20),
              Text(
                'Steps and description',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              CustomTextField(controller: descriptionController),
              SizedBox(height: 20),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 20,
              ),
              IngredientInput(
                alimentController: ingrNameController,
                quantiteController: quantiteController,
                onAdd: addIngredient,
              ),
              SizedBox(height: 20),
              // Addition of ingredients as tags.
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: ingredients.map((ingredient) {
                  return Chip(
                    label: Text(
                        '${ingredient['name']} - ${ingredient['quantity']}',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Color(0xFFFE724C),
                    side: BorderSide(
                      color: Color(0xFFFE724C),
                      width: 2.0,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Time of preparation',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              DurationCounter(
                initialMinutes: 10,
                onChanged: (newDuration) {
                  log("Durée changée: $newDuration min");
                },
              ),
              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 360.0,
                  height: 50.0,
                  child: ButtonGeneric(
                    content: "Add the recipe",
                    pressedFunction: pressedAdd,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Recipe image loader
class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;
  // Starts the file picker
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: _image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 50, color: Colors.grey),
                  SizedBox(height: 5),
                  Text("Add an image", style: TextStyle(color: Colors.grey)),
                ],
              )
            : Image.file(_image!, fit: BoxFit.cover),
      ),
    );
  }
}

// Textfield of recipe description
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4, // Allows for multiple lines of text
      decoration: InputDecoration(
        hintText: "Describe your recipe with all the steps...",
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white, // Background collor
        contentPadding: EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Colors.red.shade100, width: 2), // Light pink border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Color(0xFFFE724C), width: 2), // Darker border on focus
        ),
      ),
    );
  }
}

// Textfields to describe ingredients
class IngredientInput extends StatelessWidget {
  final TextEditingController alimentController;
  final TextEditingController quantiteController;
  final VoidCallback onAdd;

  const IngredientInput({
    super.key,
    required this.alimentController,
    required this.quantiteController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Ingredient", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            // Textfield for eatables
            Expanded(
              flex: 3,
              child: TextField(
                controller: alimentController,
                decoration: InputDecoration(
                  hintText: "Ex : onion",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.red.shade100, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFFE724C), width: 2),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
            SizedBox(width: 10),
            // Textfield for quantity
            Expanded(
              flex: 1,
              child: TextField(
                controller: quantiteController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "1",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.red.shade100, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFFE724C), width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        // Button to manage adding ingredients
        TextButton.icon(
          onPressed: onAdd,
          icon: Icon(Icons.add, color: Color(0xFFFE724C)),
          label: Text(
            "Add an ingredient",
            style: TextStyle(color: Color(0xFFFE724C)),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            backgroundColor: Colors.red.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

// Component to manage the recipe realization duration
class DurationCounter extends StatefulWidget {
  final int initialMinutes;
  final ValueChanged<int> onChanged;

  const DurationCounter({
    super.key,
    this.initialMinutes = 10,
    required this.onChanged,
  });

  @override
  DurationCounterState createState() => DurationCounterState();
}

class DurationCounterState extends State<DurationCounter> {
  late int minutes;

  @override
  void initState() {
    super.initState();
    minutes = widget.initialMinutes;
  }

  void _increment() {
    setState(() {
      minutes += 1;
    });
    widget.onChanged(minutes);
  }

  void _decrement() {
    if (minutes > 0) {
      setState(() {
        minutes -= 1;
      });
      widget.onChanged(minutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //bouton -
          IconButton(
            icon: Icon(Icons.remove, color: Color(0xFFFE724C)),
            onPressed: _decrement,
          ),
          //Temps
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "$minutes min",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          //bouton +
          IconButton(
            icon: Icon(Icons.add, color: Color(0xFFFE724C)),
            onPressed: _increment,
          ),
        ],
      ),
    );
  }
}
