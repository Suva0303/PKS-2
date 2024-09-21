import 'package:flutter/material.dart';
import 'book.dart';

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
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: BooksList(),
    );
  }
}

class BooksList extends StatelessWidget {
  final List<Book> books = [
    Book(
      name: 'Оно',
      imageUrl: '../lib/images/it.jpeg',
      price: 900, // Цены в рублях
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Доступные Книги'),
      ),
      body: Center(
        child: ListView.builder(
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
                subtitle:
                    Text('${books[index].price} ₽'), // Формат цен в рублях
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(book.imageUrl),
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
