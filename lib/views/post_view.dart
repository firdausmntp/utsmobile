import 'package:flutter/material.dart';
import 'package:uts/controllers/post_controller.dart';
import 'package:uts/models/post.dart';
import 'package:uts/views/detailpost_view.dart';
import 'package:get/get.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 242, 235, 1),
      appBar: AppBar(
        title: const Text('List Postingan'),
        backgroundColor: Color.fromRGBO(66, 85, 43, 1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color.fromRGBO(94, 113, 66, 1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Memuat postingan...',
                    style: TextStyle(
                      color: Color.fromRGBO(94, 113, 66, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Color.fromRGBO(139, 0, 0, 1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(
                      color: Color.fromRGBO(139, 0, 0, 1),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Color.fromRGBO(120, 134, 107, 1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tidak ada postingan tersedia',
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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final post = snapshot.data![index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(120, 134, 107, 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: Color.fromRGBO(94, 113, 66, 0.2),
                    child: ClipOval(
                      child: Image.network(
                        'https://boringapi.com/api/v1/static/photos/${post.id}.jpeg',
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 32,
                            color: Color.fromRGBO(66, 85, 43, 1),
                          );
                        },
                      ),
                    ),
                  ),
                  title: Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromRGBO(33, 42, 22, 1),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(94, 113, 66, 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: Color.fromRGBO(66, 85, 43, 1),
                    ),
                  ),
                  onTap: () {
                    print('Postingan ${post.id} di-klik');
                    Get.to(() => DetailPostingan(post: post));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
