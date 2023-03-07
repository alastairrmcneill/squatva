import 'package:flutter/material.dart';
import 'package:squatva/screens/filters_screen.dart';

class Filter1 extends StatelessWidget {
  const Filter1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FilterScreen())),
              icon: const Icon(
                Icons.filter_list_rounded,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
