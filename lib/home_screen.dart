import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ParkInn APIs"),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 20,
              child: Card(
                child: ListTile(
                  title: Text("Get"),
                  subtitle: Text("fetching the users data"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
