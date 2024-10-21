import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Suva_cccc';
  String email = 'kairat.alibekov.2004@mail.ru';
  String profileImageUrl = '../lib/images/profile.jpeg';

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллеры с текущими данными
    _usernameController.text = username;
    _emailController.text = email;
    _imageUrlController.text = profileImageUrl;
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Редактировать профиль'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration:
                      const InputDecoration(labelText: 'Имя пользователя'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _imageUrlController,
                  decoration:
                      const InputDecoration(labelText: 'URL фото профиля'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      username = _usernameController.text;
                      email = _emailController.text;
                      profileImageUrl = _imageUrlController.text;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Сохранить'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Получаем высоту экрана
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Center(
        child: Container(
          height: screenHeight * 0.8,
          width: screenWidth * 0.7,
          padding: const EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.1,
            horizontal: screenWidth * 0.15,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Colors.grey[800]!,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage(
                  profileImageUrl,
                ),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 20),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email, // Email
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _editProfile, // Вызов функции редактирования профиля
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDA70D6),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Редактировать профиль',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
