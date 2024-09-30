import 'package:flutter/material.dart';
import 'book.dart'; 

class FavoritesScreen extends StatelessWidget {
  final List<Book> favorites;

  FavoritesScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранные Книги'),
      ),
      body: favorites.isEmpty
          ? Center(child: const Text('Нет избранных книг.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    title: Text(favorites[index].name),
                    subtitle: Text('${favorites[index].price} ₽'),
                    leading: Image.asset(favorites[index].imageUrl),
                  ),
                );
              },
            ),
    );
  }
}
