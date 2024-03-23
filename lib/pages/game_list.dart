import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_123210078/models/game_store.dart';
import 'package:quiz_123210078/pages/game_details.dart';
import 'package:quiz_123210078/pages/login.dart';

class GameList extends StatelessWidget {
  final String username;

  const GameList({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            _heading(context),
            _tourismListMenu(context),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _heading(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, bottom: 16),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, $username  👋🏻",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text("Welcome to Bagus Game Store."),
              ],
            ),
            _logout(context)
          ],
        ));
  }

  Widget _tourismListMenu(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => _tourismListItem(context, index),
        itemCount: gameList.length,
      ),
    );
  }

  Widget _tourismListItem(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          border: Border.all(color: const Color.fromARGB(32, 0, 0, 0))),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                game: gameList[index],
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    image: DecorationImage(
                        image: NetworkImage(gameList[index].imageUrls[0]),
                        fit: BoxFit.cover)),
              ),
            ),
            Container(
              width: width,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    gameList[index].name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    gameList[index].price,
                    style: const TextStyle(
                        fontSize: 12, color: Color.fromARGB(128, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
          minimumSize: const Size(48, 48),
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(66, 124, 124, 124),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      icon: const Icon(Icons.logout),
    );
  }
}
