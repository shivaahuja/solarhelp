import 'package:flutter/material.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemCount = 20;
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Item ${(index + 1)}'),
          leading: const Icon(Icons.store),
          trailing: const Icon(Icons.link),
          onTap: () {
            debugPrint('Item ${(index + 1)} pressed');
          },
        );
      },
    );
  }
}
