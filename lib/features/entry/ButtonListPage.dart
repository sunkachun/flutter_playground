import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Button {
  weather('Weather', '/weather'),
  download('Download', '/download'),
  barcode('Barcode Scanner', '/barcode'),
  search('Search', '/search');

  final String name;
  final String path;
  const Button(this.name, this.path);
}

class ButtonListPage extends StatelessWidget {
  final List<Button> buttonLabels = [
    Button.weather,
    Button.download,
    Button.barcode
  ];

  ButtonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feature List'),
      ),
      body: ListView.builder(
        itemCount: buttonLabels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                context.push(buttonLabels[index].path);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(buttonLabels[index].name),
            ),
          );
        },
      ),
    );
  }
}