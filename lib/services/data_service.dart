import 'package:dio/dio.dart';
import 'package:flutter_practice_app/modals/recipe.dart';
import 'package:flutter_practice_app/services/http_services.dart';

class DataService {
  static final DataService _singleton = DataService._internal();
  final HTTPService _httpService = HTTPService();
  factory DataService() {
    return _singleton;
  }
  DataService._internal();

  Future<List<Recipe>?> getRecipes(String filter) async {
    var response = await _httpService
        .get(filter.isNotEmpty ? 'recipes/meal-type/$filter' : 'recipes');
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response?.data['recipes'];
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();
      return recipes;
    } else {
      return null;
    }
  }
}
