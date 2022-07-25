import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../services/api_service.dart';

class RecipeScreen extends StatelessWidget {
  int id;
  RecipeScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map>(
          future: APIService.instance.getRecipe(id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            print(snapshot.data);
            final Map recipe = snapshot.data ?? {};
            return Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 70),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                                image: NetworkImage(recipe['image']),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        recipe['title'],
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        '${recipe['extendedIngredients'].length} Ingredients | ${recipe['readyInMinutes']} Min',
                        style: const TextStyle(
                            fontFamily: 'Montserrat', color: Colors.white),
                      ),
                      DefaultTabController(
                          length: 3,
                          initialIndex: 0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  child: const TabBar(
                                    labelColor: Colors.blue,
                                    unselectedLabelColor: Colors.black,
                                    tabs: [
                                      Tab(text: 'Info'),
                                      Tab(text: 'Instructions'),
                                      Tab(text: 'Ingredients'),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 500,
                                    constraints: const BoxConstraints(minHeight: 400),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey, width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      ListView(
                                        shrinkWrap: true,
                                        children: [
                                          tile(recipe['vegetarian'] ? 'Vegetarian' :'Non Vegetarian', color: recipe['vegetarian'] ? Colors.green :Colors.red, icon: Icons.circle, hasIcon: true),
                                          const Divider(),
                                          tile('Ready in ${recipe['readyInMinutes']} Min', color: Colors.blue, icon: Icons.timer, hasIcon: true),
                                          const Divider(),
                                          tile('Price per serving', leading: '\$${recipe['pricePerServing']}', color: Colors.blue),
                                          const Divider(),
                                          tile('Servings', leading: '${recipe['servings']}', color: Colors.blue),
                                          const Divider(),
                                          tile('Health Score', leading: '${recipe['healthScore']}', color: Colors.green),
                                          const Divider(),
                                          tile('Likes', leading: '${recipe['aggregateLikes']}', color: Colors.red),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),

                                        child: SingleChildScrollView(
                                            child: HtmlWidget(
                                                recipe['instructions'],
                                                  textStyle:
                                                // style:
                                                    const TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                                            )),
                                      ),
                                      ListView.separated(
                                        itemBuilder: (context, index) {
                                          final ingredients =
                                              recipe['extendedIngredients'][index];
                                          print(ingredients['aisle']);
                                          // return Container();
                                          return ListTile(
                                            title: Text(
                                              ingredients['aisle'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, fontFamily: 'Montserrat',
                                                  fontSize: 18),
                                            ),
                                            trailing: Text(ingredients['unit'], style: const TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontStyle: FontStyle.italic),),
                                          );
                                        },
                                        shrinkWrap: true,
                                        itemCount:
                                            recipe['extendedIngredients'].length, separatorBuilder: (BuildContext context, int index) => const Divider(),
                                      ),
                                    ]))
                              ])),
                    ],
                  ),
                )),
                Positioned( top: 40,
                  left: 30,
                  child:  Container(
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(149, 157, 165, 0.3),
                                blurRadius: 24,
                                offset: Offset(0, 8))
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white),
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back))),),
              ],
            );
          }),
    );
  }

  Widget tile (String title,  {String? leading, required Color color , IconData? icon,bool hasIcon = false}) {
    return ListTile(
        leading: hasIcon ? Icon(
          icon,
          color: color,
        ) :Text(
          leading ?? '',
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ));
  }
}
