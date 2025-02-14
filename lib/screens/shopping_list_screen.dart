import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingList = ref.watch(shoppingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        backgroundColor: Colors.orange,
      ),
      body: shoppingList.isEmpty
          ? const Center(child: Text('No items in shopping list'))
          : ListView.builder(
              itemCount: shoppingList.length,
              itemBuilder: (context, index) {
                final ingredient = shoppingList[index];
                return ListTile(
                  leading: Checkbox(
                    value:
                        false,
                    onChanged: (bool? value) {

                    },
                  ),
                  title: Text(ingredient),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      ref
                          .read(shoppingListProvider.notifier)
                          .removeIngredient(ingredient);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('$ingredient removed from shopping list')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

