import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../services/api_service.dart';

class RecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map>(
          future: APIService.instance.getRecipe(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
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
                                    constraints: BoxConstraints(minHeight: 400),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey, width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      ListView(
                                        shrinkWrap: true,
                                        children: const [
                                          ListTile(
                                              leading: Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                              ),
                                              title: Text(
                                                'Non Vegetarian',
                                                style: TextStyle(fontSize: 20),
                                              )),
                                          Divider(),
                                          ListTile(
                                              leading: Icon(
                                                Icons.timer,
                                                color: Colors.blue,
                                              ),
                                              title: Text(
                                                'Ready in 45 Min',
                                                style: TextStyle(fontSize: 20),
                                              )),
                                          Divider(),
                                          ListTile(
                                              leading: Text(
                                                '\$1.63',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              title: Text(
                                                'Price per serving',
                                                style: TextStyle(fontSize: 20),
                                              )),
                                          Divider(),
                                          ListTile(
                                              leading: Text(
                                                '2',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              title: Text(
                                                'Servings',
                                                style: TextStyle(fontSize: 20),
                                              )),
                                          Divider(),
                                          ListTile(
                                              leading: Text(
                                                '10',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              title: Text(
                                                'Health Score',
                                                style: TextStyle(fontSize: 20),
                                              )),
                                          Divider(),
                                          ListTile(
                                              leading: Text(
                                                '209',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              title: Text(
                                                'Likes',
                                                style: TextStyle(fontSize: 20),
                                              )),
                                        ],
                                      ),
                                      Container(
                                        child: SingleChildScrollView(
                                            child: Html(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20),
                                                data: recipe['summary'],
                                                defaultTextStyle:
                                                    TextStyle(fontSize: 18, fontFamily: 'Montserrat'))),
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
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, fontFamily: 'Montserrat',
                                                  fontSize: 18),
                                            ),
                                            trailing: Text(ingredients['unit'], style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontStyle: FontStyle.italic),),
                                          );
                                        },
                                        shrinkWrap: true,
                                        itemCount:
                                            recipe['extendedIngredients'].length, separatorBuilder: (BuildContext context, int index) => Divider(),
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
}
