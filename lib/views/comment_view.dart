import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uts/controllers/comment_controller.dart';
import 'package:uts/models/post.dart';

class CommentView extends StatelessWidget {
  final Post post;

  const CommentView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final CommentController commentController = Get.put(
      CommentController(),
      tag: 'post_${post.id}',
    );

    commentController.fetchComments(post.id);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 242, 235, 1),
      appBar: AppBar(
        title: Text('Komentar untuk Post #${post.id}'),
        backgroundColor: const Color.fromRGBO(66, 85, 43, 1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(120, 134, 107, 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  'https://boringapi.com/api/v1/static/photos/${post.id}.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Color.fromRGBO(94, 113, 66, 0.2),
                      child: const Icon(
                        Icons.broken_image,
                        size: 64,
                        color: Color.fromRGBO(66, 85, 43, 1),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              post.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(33, 42, 22, 1),
              ),
            ),
          ),
          const Divider(
            color: Color.fromRGBO(94, 113, 66, 0.5),
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          Expanded(
            child: Obx(() {
              if (commentController.isLoading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: Color.fromRGBO(94, 113, 66, 1),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Memuat komentar...',
                        style: TextStyle(
                          color: Color.fromRGBO(94, 113, 66, 1),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (commentController.error.value != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Color.fromRGBO(139, 0, 0, 1),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${commentController.error.value}',
                        style: const TextStyle(
                          color: Color.fromRGBO(139, 0, 0, 1),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              if (commentController.comments.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: Color.fromRGBO(120, 134, 107, 1),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tidak ada komentar tersedia',
                        style: TextStyle(
                          color: Color.fromRGBO(120, 134, 107, 1),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(120, 134, 107, 0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(33, 42, 22, 1),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          comment.body,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(33, 42, 22, 1),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
