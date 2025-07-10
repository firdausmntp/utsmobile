import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uts/views/post_view.dart';

void main() {
  runApp(const MyUts());
}

class MyUts extends StatelessWidget {
  const MyUts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UTS Firdaus Satrio Utomo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PostView(),
    );
  }
}
