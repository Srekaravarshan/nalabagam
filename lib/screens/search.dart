import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nalabagam/services/api_service.dart';
import 'package:nalabagam/widgets/recipe_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController search;

  // Map<String, dynamic> recipesMap = json.decode(
  //     "{\"results\":[{\"id\":654959,\"title\":\"PastaWithTuna\",\"image\":\"https://spoonacular.com/recipeImages/654959-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":511728,\"title\":\"PastaMargherita\",\"image\":\"https://spoonacular.com/recipeImages/511728-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":654812,\"title\":\"PastaandSeafood\",\"image\":\"https://spoonacular.com/recipeImages/654812-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":654857,\"title\":\"PastaOnTheBorder\",\"image\":\"https://spoonacular.com/recipeImages/654857-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":654883,\"title\":\"PastaVegetableSoup\",\"image\":\"https://spoonacular.com/recipeImages/654883-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":654928,\"title\":\"PastaWithItalianSausage\",\"image\":\"https://spoonacular.com/recipeImages/654928-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":654926,\"title\":\"PastaWithGorgonzolaSauce\",\"image\":\"https://spoonacular.com/recipeImages/654926-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":654944,\"title\":\"PastaWithSalmonCreamSauce\",\"image\":\"https://spoonacular.com/recipeImages/654944-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":654905,\"title\":\"PastaWithChickpeasandKale\",\"image\":\"https://spoonacular.com/recipeImages/654905-312x231.jpg\",\"imageType\":\"jpg\"},{\"id\":654901,\"title\":\"PastaWithChickenandBroccoli\",\"image\":\"https://spoonacular.com/recipeImages/654901-312x231.jpg\",\"imageType\":\"jpg\"}],\"offset\":0,\"number\":10,\"totalResults\":223}");

  @override
  void initState() {
    super.initState();
    search =  TextEditingController(text: widget.query);
  }

  List chipList = [
    'Indian',
    'American',
    'Italian',
    'Japanese',
    'Korean',
    'Southern'
  ];
  int cuisineIndex = -1;

  @override
  Widget build(BuildContext context) {
    // List results = recipesMap['results'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          // The search area here
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 1,
          title: Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: search,
                onSubmitted: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        search.clear();
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: chipList.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        if (cuisineIndex == index) {
                          cuisineIndex = -1;
                        } else {
                          cuisineIndex = index;
                        }
                      });
                    },
                    child: Chip(
                      padding: const EdgeInsets.all(8),
                      label: Text(
                        chipList[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: cuisineIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      backgroundColor:
                          cuisineIndex == index ? Colors.green : Colors.black12,
                    )),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 8),
              ),
            ),
            FutureBuilder<List>(
                future: APIService.instance.searchRecipe(widget.query,
                    (cuisineIndex == -1) ? null : chipList[cuisineIndex]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.data ?? [];
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(30),
                    itemBuilder: (BuildContext context, int index) {
                      final recipe = data[index];
                      return RecipeCard(
                          title: recipe['title'],
                          image: recipe['image'],
                          id: recipe['id']);
                    },
                    itemCount: data.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 25),
                  );
                }),
          ],
        ),
      ),
      // body: FutureBuilder<List>(
      //   future:,
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData)
      //       return Center(child: CircularProgressIndicator());
      //     return ListView.builder(
      //       itemCount: recipes.length,
      //     itemBuilder: (context, index) {
      //       return RecipeCard(recipe: recipe);
      //     },);
      //   },
      // )
    );
  }
}
