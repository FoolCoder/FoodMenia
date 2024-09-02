import 'package:flutter/material.dart';

import '../modals/recipe.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key, required this.recipe});
  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text('RecipesBook'),
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(
      children: [
        _recipeImage(context),
        _recipeDetails(context),
      ],
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: NetworkImage(recipe.image)),
      ),
    );
  }

  Widget _recipeDetails(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${recipe.cuisine},${recipe.difficulty}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '${recipe.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Prep Time ${recipe.prepTimeMinutes} Minutes',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          Text(
            'Rating ${recipe.rating.toString()} | ${recipe.reviewCount}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
