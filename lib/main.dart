import 'package:flutter/material.dart';
import 'book.dart';
import 'favorites.dart';
import 'profile.dart';

void main() {
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин Книг',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 230, 250),
      ),
      debugShowCheckedModeBanner: false,
      home: BooksList(),
    );
  }
}

class BooksList extends StatefulWidget {
  @override
  _BooksListState createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  List<Book> books = [
    Book(
      name: 'Оно',
      imageUrl: '../lib/images/it.jpeg',
      price: 900,
    ),
    Book(
      name: 'Гарри Поттер',
      imageUrl: '../lib/images/harry.jpeg',
      price: 800,
    ),
    Book(
      name: 'Война и мир',
      imageUrl: '../lib/images/WarAndPeace.jpeg',
      price: 700,
    ),
    Book(
      name: 'Королина',
      imageUrl: '../lib/images/corolina.jpeg',
      price: 1100,
    ),
  ];

  List<Book> favorites = []; // Список избранных книг

  void _addBook(Book book) {
    setState(() {
      books.add(book);
    });
  }

  void _toggleFavorite(Book book) {
    setState(() {
      if (favorites.contains(book)) {
        favorites.remove(book);
      } else {
        favorites.add(book);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Доступные Книги'),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(favorites: favorites),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBookScreen(onAddBook: _addBook),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(color: Colors.black, width: 1),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text(books[index].name),
              subtitle: Text('${books[index].price} ₽'),
              leading: Image.asset(books[index].imageUrl),
              trailing: IconButton(
                icon: Icon(
                  favorites.contains(books[index])
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: favorites.contains(books[index]) ? Colors.red : null,
                ),
                onPressed: () {
                  _toggleFavorite(books[index]);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetail(book: books[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BookDetail extends StatelessWidget {
  final Book book;

  BookDetail({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(book.imageUrl),
              const SizedBox(height: 8),
              Text(book.name,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 16),
              Text('${book.price} ₽',
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 13, 14, 13))),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Купить ${book.name}',
                          style: const TextStyle(color: Colors.black)),
                      content: const Text('Вы желаете купить эту книгу?',
                          style: TextStyle(color: Colors.black)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Да',
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Нет',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Купить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddBookScreen extends StatelessWidget {
  final Function(Book) onAddBook;

  AddBookScreen({required this.onAddBook});

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить новую книгу'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Название книги'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Цена'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration:
                  const InputDecoration(labelText: 'Введите адрес изображения'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String name = _nameController.text;
                final double price = double.parse(_priceController.text);
                final String imageUrl = _imageUrlController.text;

                if (name.isNotEmpty && price > 0 && imageUrl.isNotEmpty) {
                  final newBook =
                      Book(name: name, imageUrl: imageUrl, price: price);
                  onAddBook(newBook);
                  Navigator.pop(context);
                }
              },
              child: const Text('Добавить книгу'),
            ),
          ],
        ),
      ),
    );
  }
}
