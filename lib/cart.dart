import 'package:flutter/material.dart';
import 'book.dart';

class CartScreen extends StatefulWidget {
  final List<Book> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Словарь для хранения количества книг
  Map<Book, int> quantities = {};

  @override
  void initState() {
    super.initState();
    // Инициализация количества для книги
    for (var book in widget.cartItems) {
      quantities[book] = (quantities[book] ?? 0) + 1;
    }
  }

  void _incrementQuantity(Book book) {
    setState(() {
      quantities[book] = (quantities[book] ?? 0) + 1;
    });
  }

  void _decrementQuantity(Book book) {
    setState(() {
      if (quantities[book]! > 1) {
        quantities[book] = quantities[book]! - 1;
      } else {
        // Удаляем книгу, если количество 0
        _removeItem(book);
      }
    });
  }

  void _removeItem(Book book) {
    setState(() {
      widget.cartItems.remove(book);
      quantities.remove(book);
    });
  }

  void _placeOrder() {
    // Здесь можно реализовать логику оформления заказа
    // Например, показать диалог с подтверждением
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Оформить заказ?'),
          content: Text('Вы уверены, что хотите оформить заказ?'),
          actions: [
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
            ),
            TextButton(
              child: Text('Подтвердить'),
              onPressed: () {
                // Логика подтверждения заказа
                // Например, можно очистить корзину или выполнить другие действия
                Navigator.of(context).pop(); // Закрыть диалог
                _clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Заказ оформлен!')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _clearCart() {
    setState(() {
      widget.cartItems.clear();
      quantities.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _placeOrder,
          ),
        ],
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Корзина пуста.'))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final book = widget.cartItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    leading: Image.asset(book.imageUrl),
                    title: Text(book.name),
                    subtitle: Text('${book.price} ₽'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _decrementQuantity(book),
                        ),
                        Text(quantities[book].toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _incrementQuantity(book),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeItem(book),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
