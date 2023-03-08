import 'package:flutter/material.dart';
import 'package:squatva/general/models/exercise_model.dart';

class Filter2 extends StatelessWidget {
  const Filter2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Colors.grey[200],
                              height: 400,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(children: Equipment.all.map((e) => Text(e)).toList()),
                              ),
                            );
                          },
                        );
                      },
                      child: Text('Equipment'),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Category'),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Limb Involvement'),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
