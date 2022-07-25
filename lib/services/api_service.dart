import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/meal_plan_model.dart';
import '../models/recipe_model.dart';

class APIService {

  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String API_KEY = 'e3ac9e8c2b324b499b38bf4283aed4da';

  // Generate Meal Plan
  Future<MealPlan> generateMealPlan({required int targetCalories, required String diet}) async {
    if (diet == 'None') diet = '';
    Map<String, String> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/mealplans/generate',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
    } catch (err) {
      throw err.toString();
    }
  }

  // Recipe Info
  Future<Map> getRecipe(int id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/$id/information',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } catch (err) {
      throw err.toString();
    }
  }

  // Recipe Info
  Future<List> fetchRandomRecipe() async {
    Map<String, String> parameters = {
      'number': '6',
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/random',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      print(data['recipes'].length);
      return data['recipes'];
    } catch (err) {
      throw err.toString();
    }
  }

  // Recipe Info
  Future<List> searchRecipe(String query, String? cuisine) async {
    Map<String, String> parameters = {
      'query': query,
      'number': '6',
      'apiKey': API_KEY,
    };
    if (cuisine != null) {
      parameters.putIfAbsent('cuisine', () => cuisine);
    }
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/complexSearch',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } catch (err) {
      throw err.toString();
    }
  }
}