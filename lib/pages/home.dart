import 'package:flutter/material.dart';
import 'package:flutter_practice_app/modals/recipe.dart';
import 'package:flutter_practice_app/pages/recipes_page.dart';
import 'package:flutter_practice_app/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mealTypeFilter = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipe Book'),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _recipeTypesButton(),
          _recipesList(),
        ],
      ),
    );
  }

  Widget _recipeTypesButton() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'snak';
                  });
                },
                child: const Text('🥕 Snak')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'breakfast';
                  });
                },
                child: const Text('Breakfast')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'lunch';
                  });
                },
                child: const Text('Lunch')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'dinner';
                  });
                },
                child: const Text('Dinner')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = 'snak';
                  });
                },
                child: const Text('snak')),
          ),
        ],
      ),
    );
  }

  Widget _recipesList() {
    return Expanded(
        child: FutureBuilder(
            future: DataService().getRecipes(_mealTypeFilter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Unable to load data'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    var myList =
                        snapshot.data! as List; // <-- Your data using 'as'

                    Recipe recipe = myList[index] as Recipe;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RecipePage(
                              recipe: recipe,
                            );
                          }));
                        },
                        // isThreeLine: true,
                        // subtitle: const  e}\n Difficulty ${recipe.difficulty}"),
                        contentPadding: const EdgeInsets.only(top: 25),
                        leading: Image.network(recipe.image),
                        title: Text(recipe.name),
                        trailing: Text(
                          recipe.rating.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }
                },
              );
            }));
  }
}
