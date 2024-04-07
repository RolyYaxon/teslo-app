import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(

      child: const Center(child: CircularProgressIndicator(strokeWidth: 2,)),

    );
  }
}