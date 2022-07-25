import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nalabagam/screens/search.dart';
import 'package:nalabagam/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipe_model.dart';
import '../widgets/recipe_card.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchQuery = TextEditingController();

  // final recipes = json.decode(
  //     "{\"recipes\":[{\"vegetarian\":true,\"vegan\":false,\"glutenFree\":false,\"dairyFree\":false,\"veryHealthy\":false,\"cheap\":false,\"veryPopular\":false,\"sustainable\":false,\"lowFodmap\":false,\"weightWatcherSmartPoints\":17,\"gaps\":\"no\",\"preparationMinutes\":-1,\"cookingMinutes\":-1,\"aggregateLikes\":10,\"healthScore\":7,\"creditsText\":\"Foodista.com–TheCookingEncyclopediaEveryoneCanEdit\",\"license\":\"CCBY3.0\",\"sourceName\":\"Foodista\",\"pricePerServing\":65.1,\"extendedIngredients\":[{\"id\":1124,\"aisle\":\"Milk,Eggs,OtherDairy\",\"image\":\"egg-white.jpg\",\"consistency\":\"SOLID\",\"name\":\"eggwhites\",\"nameClean\":\"eggwhites\",\"original\":\"3Largeeggwhites(about130gorslightlymore)\",\"originalName\":\"Largeeggwhites(about130gorslightlymore)\",\"amount\":3.0,\"unit\":\"\",\"meta\":[],\"measures\":{\"us\":{\"amount\":3.0,\"unitShort\":\"\",\"unitLong\":\"\"},\"metric\":{\"amount\":3.0,\"unitShort\":\"\",\"unitLong\":\"\"}}},{\"id\":19335,\"aisle\":\"Baking\",\"image\":\"sugar-in-bowl.png\",\"consistency\":\"SOLID\",\"name\":\"sugar\",\"nameClean\":\"sugar\",\"original\":\"60gSugar\",\"originalName\":\"Sugar\",\"amount\":60.0,\"unit\":\"g\",\"meta\":[],\"measures\":{\"us\":{\"amount\":2.116,\"unitShort\":\"oz\",\"unitLong\":\"ounces\"},\"metric\":{\"amount\":60.0,\"unitShort\":\"g\",\"unitLong\":\"grams\"}}},{\"id\":12120,\"aisle\":\"Baking\",\"image\":\"hazelnuts.jpg\",\"consistency\":\"SOLID\",\"name\":\"hazelnuts\",\"nameClean\":\"hazelnuts\",\"original\":\"90gGroundhazelnut\",\"originalName\":\"Groundhazelnut\",\"amount\":90.0,\"unit\":\"g\",\"meta\":[],\"measures\":{\"us\":{\"amount\":3.175,\"unitShort\":\"oz\",\"unitLong\":\"ounces\"},\"metric\":{\"amount\":90.0,\"unitShort\":\"g\",\"unitLong\":\"grams\"}}},{\"id\":19334,\"aisle\":\"Baking\",\"image\":\"light-brown-sugar.jpg\",\"consistency\":\"SOLID\",\"name\":\"brownsugar\",\"nameClean\":\"goldenbrownsugar\",\"original\":\"30gBrownsugar\",\"originalName\":\"Brownsugar\",\"amount\":30.0,\"unit\":\"g\",\"meta\":[],\"measures\":{\"us\":{\"amount\":1.058,\"unitShort\":\"oz\",\"unitLong\":\"ounces\"},\"metric\":{\"amount\":30.0,\"unitShort\":\"g\",\"unitLong\":\"grams\"}}},{\"id\":20081,\"aisle\":\"Baking\",\"image\":\"flour.png\",\"consistency\":\"SOLID\",\"name\":\"plainflour\",\"nameClean\":\"wheatflour\",\"original\":\"25gPlainflour\",\"originalName\":\"Plainflour\",\"amount\":25.0,\"unit\":\"g\",\"meta\":[\"plain\"],\"measures\":{\"us\":{\"amount\":0.882,\"unitShort\":\"oz\",\"unitLong\":\"ounces\"},\"metric\":{\"amount\":25.0,\"unitShort\":\"g\",\"unitLong\":\"grams\"}}},{\"id\":20080,\"aisle\":\"Baking\",\"image\":\"flour.png\",\"consistency\":\"SOLID\",\"name\":\"wholemealflour\",\"nameClean\":\"wholewheatflour\",\"original\":\"60gWholemealflour\",\"originalName\":\"Wholemealflour\",\"amount\":60.0,\"unit\":\"g\",\"meta\":[],\"measures\":{\"us\":{\"amount\":2.116,\"unitShort\":\"oz\",\"unitLong\":\"ounces\"},\"metric\":{\"amount\":60.0,\"unitShort\":\"g\",\"unitLong\":\"grams\"}}},{\"id\":1001,\"aisle\":\"Milk,Eggs,OtherDairy\",\"image\":\"butter-sliced.jpg\",\"consistency\":\"SOLID\",\"name\":\"butter\",\"nameClean\":\"butter\",\"original\":\"65gMeltedbutterwith1/2tspvanillaextract\",\"originalName\":\"Meltedbutterwith1/2tspvanillaextract\",\"amount\":65.0,\"unit\":\"g\",\"meta\":[\"with1/2tspvanillaextract\",\"melted\"],\"measures\":{\"us\":{\"amount\":2.293,\"unitShort\":\"oz\",\"unitLong\":\"ounces\"},\"metric\":{\"amount\":65.0,\"unitShort\":\"g\",\"unitLong\":\"grams\"}}},{\"id\":9021,\"aisle\":\"Produce\",\"image\":\"apricot.jpg\",\"consistency\":\"SOLID\",\"name\":\"apricots\",\"nameClean\":\"apricot\",\"original\":\"20geachDriedapricotsanddriedcranberries-cuttosmallerpieces\",\"originalName\":\"eachDriedapricotsanddriedcranberries-cuttosmallerpieces\",\"amount\":20.0,\"unit\":\"g\",\"meta\":[\"dried\"],\"measures\":{\"us\":{\"amount\":0.705,\"unitShort\":\"oz\",\"unitLong\":\"ounces\"},\"metric\":{\"amount\":20.0,\"unitShort\":\"g\",\"unitLong\":\"grams\"}}}],\"id\":665303,\"title\":\"WholemealCake\",\"readyInMinutes\":45,\"servings\":4,\"sourceUrl\":\"https://www.foodista.com/recipe/JDYXYDJY/wholemeal-cake\",\"image\":\"https://spoonacular.com/recipeImages/665303-556x370.jpg\",\"imageType\":\"jpg\",\"summary\":\"WholemealCakecouldbejustthe<b>lactoovovegetarian</b>recipeyou'vebeenlookingfor.Thisrecipemakes4servingswith<b>432calories</b>,<b>9gofprotein</b>,and<b>27goffat</b>each.For<b>65centsperserving</b>,thisrecipe<b>covers14%</b>ofyourdailyrequirementsofvitaminsandminerals.Acouplepeoplereallylikedthisdessert.10peoplehavemadethisrecipeandwouldmakeitagain.ItisbroughttoyoubyFoodista.Frompreparationtotheplate,thisrecipetakesaround<b>around45minutes</b>.Ifyouhavebrownsugar,sugar,flour,andafewotheringredientsonhand,youcanmakeit.Takingallfactorsintoaccount,thisrecipe<b>earnsaspoonacularscoreof47%</b>,whichissolid.Similarrecipesinclude<ahref=\\\"https://spoonacular.com/recipes/wholemeal-steam-bun-665306\\\">WholemealSteamBun</a>,<ahref=\\\"https://spoonacular.com/recipes/wholemeal-apple-cinnamon-scones-122784\\\">WholemealApple&CinnamonScones</a>,and<ahref=\\\"https://spoonacular.com/recipes/wholemeal-spinach-potato-pies-223882\\\">Wholemealspinach&potatopies</a>.\",\"cuisines\":[],\"dishTypes\":[\"dessert\"],\"diets\":[\"lactoovovegetarian\"],\"occasions\":[],\"instructions\":\"Inalargebowl,mixgroundhazelnut,brownsugar,plainflourandwholemealflourtogetherandsetaside.\\nWhiskeggwhitesandsugaratmediumhighspeedtillfirmandsmooth.\\nUsehandtofoldonequarterofbeateneggwhitestotheflourmixtureevenlyandremainingeggwhiteintwobatches.\\nLastlyaddinmeltedbutterintwobatchesandmixwellwitharubberspatulafollowbythedriedapricotsanddriedcranberries.\\nPourmixtureintoa7inch(lined)roundcakepanandsprinklemoredriedapricotsanddriedcranberriesoverit.\\nBakeatpreheatedoven170Cforabout30-35minutesoruntilskewerinsertedcomesoutclean.Leavecaketocoolinpanfor15minutesandremovetowireracktocooldowncompletely.\",\"analyzedInstructions\":[{\"name\":\"\",\"steps\":[{\"number\":1,\"step\":\"Inalargebowl,mixgroundhazelnut,brownsugar,plainflourandwholemealflourtogetherandsetaside.\",\"ingredients\":[{\"id\":20080,\"name\":\"wholewheatflour\",\"localizedName\":\"wholewheatflour\",\"image\":\"flour.png\"},{\"id\":19334,\"name\":\"brownsugar\",\"localizedName\":\"brownsugar\",\"image\":\"dark-brown-sugar.png\"},{\"id\":20081,\"name\":\"allpurposeflour\",\"localizedName\":\"allpurposeflour\",\"image\":\"flour.png\"},{\"id\":12120,\"name\":\"hazelnuts\",\"localizedName\":\"hazelnuts\",\"image\":\"hazelnuts.jpg\"}],\"equipment\":[{\"id\":404783,\"name\":\"bowl\",\"localizedName\":\"bowl\",\"image\":\"bowl.jpg\"}]},{\"number\":2,\"step\":\"Whiskeggwhitesandsugaratmediumhighspeedtillfirmandsmooth.\",\"ingredients\":[{\"id\":1124,\"name\":\"eggwhites\",\"localizedName\":\"eggwhites\",\"image\":\"egg-white.jpg\"},{\"id\":19335,\"name\":\"sugar\",\"localizedName\":\"sugar\",\"image\":\"sugar-in-bowl.png\"}],\"equipment\":[{\"id\":404661,\"name\":\"whisk\",\"localizedName\":\"whisk\",\"image\":\"whisk.png\"}]},{\"number\":3,\"step\":\"Usehandtofoldonequarterofbeateneggwhitestotheflourmixtureevenlyandremainingeggwhiteintwobatches.\",\"ingredients\":[{\"id\":1124,\"name\":\"eggwhites\",\"localizedName\":\"eggwhites\",\"image\":\"egg-white.jpg\"},{\"id\":20081,\"name\":\"allpurposeflour\",\"localizedName\":\"allpurposeflour\",\"image\":\"flour.png\"}],\"equipment\":[]},{\"number\":4,\"step\":\"Lastlyaddinmeltedbutterintwobatchesandmixwellwitharubberspatulafollowbythedriedapricotsanddriedcranberries.\",\"ingredients\":[{\"id\":9079,\"name\":\"driedcranberries\",\"localizedName\":\"driedcranberries\",\"image\":\"dried-cranberries.jpg\"},{\"id\":9032,\"name\":\"driedapricots\",\"localizedName\":\"driedapricots\",\"image\":\"dried-apricots.jpg\"},{\"id\":1001,\"name\":\"butter\",\"localizedName\":\"butter\",\"image\":\"butter-sliced.jpg\"}],\"equipment\":[{\"id\":404642,\"name\":\"spatula\",\"localizedName\":\"spatula\",\"image\":\"spatula-or-turner.jpg\"}]},{\"number\":5,\"step\":\"Pourmixtureintoa7inch(lined)roundcakepanandsprinklemoredriedapricotsanddriedcranberriesoverit.\",\"ingredients\":[{\"id\":9079,\"name\":\"driedcranberries\",\"localizedName\":\"driedcranberries\",\"image\":\"dried-cranberries.jpg\"},{\"id\":9032,\"name\":\"driedapricots\",\"localizedName\":\"driedapricots\",\"image\":\"dried-apricots.jpg\"}],\"equipment\":[{\"id\":404747,\"name\":\"cakeform\",\"localizedName\":\"cakeform\",\"image\":\"cake-pan.png\"}]},{\"number\":6,\"step\":\"Bakeatpreheatedoven170Cforabout30-35minutesoruntilskewerinsertedcomesoutclean.Leavecaketocoolinpanfor15minutesandremovetowireracktocooldowncompletely.\",\"ingredients\":[],\"equipment\":[{\"id\":405900,\"name\":\"wirerack\",\"localizedName\":\"wirerack\",\"image\":\"wire-rack.jpg\"},{\"id\":404784,\"name\":\"oven\",\"localizedName\":\"oven\",\"image\":\"oven.jpg\",\"temperature\":{\"number\":170.0,\"unit\":\"Celsius\"}},{\"id\":3065,\"name\":\"skewers\",\"localizedName\":\"skewers\",\"image\":\"wooden-skewers.jpg\"},{\"id\":404645,\"name\":\"fryingpan\",\"localizedName\":\"fryingpan\",\"image\":\"pan.png\"}],\"length\":{\"number\":50,\"unit\":\"minutes\"}}]}],\"originalId\":null,\"spoonacularSourceUrl\":\"https://spoonacular.com/wholemeal-cake-665303\"}]}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nalabagam',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.teal[900])),
                  IconButton(onPressed: ()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('login', false);
                    prefs.remove('email');
                    prefs.remove('password');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext ctx) => Login()));
                  }, icon: Icon(Icons.logout))
                ],
              ),
              const SizedBox(height: 15),
              const Text('Find Best Recipe\nFor Cooking',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: searchQuery,
                          style: const TextStyle(fontFamily: 'Montserrat'),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Search'))),
                    ),
                    SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(149, 157, 165, 0.3),
                              blurRadius: 24,
                              offset: Offset(0, 8))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.white,
                        onPressed: () {
                          if (searchQuery.text.trim().isNotEmpty)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchScreen(query: searchQuery.text),
                                ));
                        },
                      ),
                    )
                  ],
                ),
              ),
              FutureBuilder<List>(
                future: APIService.instance.fetchRandomRecipe(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  final recipes = snapshot.data ?? [];
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return RecipeCard(
                          title: recipe['title'],
                          image: recipe['image'] ?? '',
                          id: recipe['id'],
                          subtitle:
                              '${recipe['extendedIngredients'].length} Ingredients | ${recipe['readyInMinutes']} Min');
                    }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 25),
                  );
                },
              ),
              // ListView(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   children: [
              //     RecipeCard(
              //         image: recipes['recipes'][0]['image'],
              //         url: recipes['recipes'][0]['spoonacularSourceUrl'],
              //         title: recipes['recipes'][0]['title'],
              //         subtitle:
              //             '${recipes['recipes'][0]['extendedIngredients'].length} Ingredients | ${recipes['recipes'][0]['readyInMinutes']} Min'),
              //     const SizedBox(height: 25),
              //     RecipeCard(
              //         image: recipes['recipes'][0]['image'],
              //         url: recipes['recipes'][0]['spoonacularSourceUrl'],
              //         title: recipes['recipes'][0]['title'],
              //         subtitle:
              //             '${recipes['recipes'][0]['extendedIngredients'].length} Ingredients | ${recipes['recipes'][0]['readyInMinutes']} Min'),
              //     const SizedBox(height: 25),
              //     RecipeCard(
              //         image: recipes['recipes'][0]['image'],
              //         url: recipes['recipes'][0]['spoonacularSourceUrl'],
              //         title: recipes['recipes'][0]['title'],
              //         subtitle:
              //             '${recipes['recipes'][0]['extendedIngredients'].length} Ingredients | ${recipes['recipes'][0]['readyInMinutes']} Min'),
              //     const SizedBox(height: 25),
              //     RecipeCard(
              //         image: recipes['recipes'][0]['image'],
              //         url: recipes['recipes'][0]['spoonacularSourceUrl'],
              //         title: recipes['recipes'][0]['title'],
              //         subtitle:
              //             '${recipes['recipes'][0]['extendedIngredients'].length} Ingredients | ${recipes['recipes'][0]['readyInMinutes']} Min'),
              //   ],
              // )
            ],
          ),
        ),
      ),
      // body: FutureBuilder<List>(
      //   future: APIService.instance.fetchRandomRecipe(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center (
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     List recipes = snapshot.data ?? [];
      //     return ListView.builder(itemBuilder: (context, index) {
      //       return Container(
      //         height: 200,
      //         decoration: BoxDecoration(
      //               image: DecorationImage(image: NetworkImage(recipes[index]['image']))
      //         ),
      //       );
      //     },
      //     itemCount: recipes.length,
      //     shrinkWrap: true,);
      //   },
      // ),
    );
  }
}
