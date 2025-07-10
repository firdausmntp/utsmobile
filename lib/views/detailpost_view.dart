import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uts/models/post.dart';
import 'package:uts/views/comment_view.dart';

class DetailPostingan extends StatelessWidget {
  final Post post;

  const DetailPostingan({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 242, 235, 1),
      appBar: AppBar(
        title: Text('Detail Postingan #${post.id}'),
        backgroundColor: Color.fromRGBO(66, 85, 43, 1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(120, 134, 107, 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://boringapi.com/api/v1/static/photos/${post.id}.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Color.fromRGBO(94, 113, 66, 0.2),
                      child: Icon(
                        Icons.broken_image,
                        size: 64,
                        color: Color.fromRGBO(66, 85, 43, 1),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(33, 42, 22, 1),
              ),
            ),
            const SizedBox(height: 8),

            Text(
              post.body,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(33, 42, 22, 1),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Lihat Komentar di-klik untuk postingan ${post.id}');
                  Get.to(() => CommentView(post: post));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(66, 85, 43, 1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Lihat Komentar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
