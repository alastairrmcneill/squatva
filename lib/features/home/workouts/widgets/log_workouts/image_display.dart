import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squatva/general/services/image_helper.dart';
import 'package:squatva/general/widgets/dashed_border.dart';

class ImageDisplay extends StatefulWidget {
  ImageDisplay({super.key});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  final imageHelper = ImageHelper();

  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            children: [
              const SizedBox(width: 10),
              ...files
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.file(
                          e,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: DashedBorder(
                  strokeWidth: 1,
                  borderRadius: 4,
                  color: Theme.of(context).hintColor,
                  child: InkWell(
                    onTap: () async {
                      final results = await imageHelper.pickImage(multiple: true);
                      for (var result in results) {
                        files.add(File(result.path));
                      }
                      setState(() {});
                    },
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
