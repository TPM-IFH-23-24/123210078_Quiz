import 'package:flutter/material.dart';
import 'package:quiz_123210078/models/game_store.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final GameStore game;

  const DetailPage({super.key, required this.game});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    isFav = !isFav;
                  });
                },
                child: Icon(Icons.favorite,
                    color: !isFav ? Color.fromARGB(48, 0, 0, 0) : Colors.red))
          ],
          title: Text(widget.game.name),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            _imageContainer(context),
            _detailContainer(context)
            // _tourismListMenu(context),
            // const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  Widget _imageContainer(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 180,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) =>
              Image.network(widget.game.imageUrls[index])),
    );
  }

  Widget _detailContainer(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.game.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                widget.game.releaseDate,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(148, 0, 0, 0)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  for (final tag in widget.game.tags)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                        tag,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.game.about,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(widget.game.reviewAverage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("${widget.game.reviewCount} reviews",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16))
                ],
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  print((widget.game.linkStore).runtimeType);
                  _launchURL(widget.game.linkStore);
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: const Text("Go to Store"),
              )
            ],
          )),
    );
  }

  Future<void> _launchURL(String strUrl) async {
    Uri url = Uri.parse(strUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
