import 'package:flutter/material.dart';
import 'package:nalabagam/screens/recipe.dart';

class RecipeCard extends StatelessWidget {
  final String title, image;
  final String? subtitle;
  final int id;

  const RecipeCard(
      {Key? key,
      required this.title,
      required this.image,
      this.subtitle,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreen(id: id),
          )),
      child: Stack(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(149, 157, 165, 0.3),
                      blurRadius: 24,
                      offset: Offset(0, 8))
                ],
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image))),
          ),
          Container(
            height: 250.0,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: const Radius.circular(30)),
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [
                      0.6,
                      1.0
                    ])),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                const SizedBox(height: 4),
                // Text('${recipe['extendedIngredients'].length} Ingredients | ${recipe['readyInMinutes']} Min',
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                        fontFamily: 'Montserrat', color: Colors.white),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
