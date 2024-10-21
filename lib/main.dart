import 'package:flutter/material.dart';
import 'book.dart';
import 'favorites.dart';
import 'profile.dart';
import 'cart.dart'; // Импортируем новый экран

void main() {
  runApp(BooksApp());
}

class BooksApp extends StatefulWidget {
  @override
  _BooksAppState createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  int _selectedIndex = 0; // Индекс для навигационной панели
  List<Book> cart = []; // Корзина для товаров
  List<Book> favorites = [];

  final List<Widget> _pages = []; // Инициализация позже

  @override
  void initState() {
    super.initState();

    // Инициализируем страницы с данными корзины и избранных книг
    _pages.addAll([
      BooksList(
          onAddToCart: _addToCart), // Передаем функцию добавления в корзину
      FavoritesScreen(favorites: favorites),
      CartScreen(cartItems: cart),
      ProfileScreen(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToCart(Book book) {
    setState(() {
      cart.add(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин Книг',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 230, 250),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.book,
                  color: Color.fromARGB(255, 0, 0, 0)), // Белая иконка
              label: 'Книги',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: Color.fromARGB(255, 0, 0, 0)), // Белая иконка
              label: 'Избранные',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,
                  color: Color.fromARGB(255, 0, 0, 0)), // Белая иконка
              label: 'Корзина',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: Color.fromARGB(255, 0, 0, 0)), // Белая иконка
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.white, // Цвет для невыбранных элементов
          backgroundColor: Colors.purple, // Цвет фона навигационной панели
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class BooksList extends StatelessWidget {
  final Function(Book) onAddToCart;

  BooksList({required this.onAddToCart});

  final List<Book> books = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Доступные Книги'),
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
                icon: const Icon(Icons.add_shopping_cart,
                    color: Color.fromARGB(255, 0, 0, 0)), // Белая иконка
                onPressed: () {
                  onAddToCart(books[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
