import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      height: media.height * 1,
      width: media.width * 1,
      decoration: const BoxDecoration(
        color: Color.fromARGB(125, 0, 0, 0),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
