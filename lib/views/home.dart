import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/post_field.dart';
import 'widgets/post_data.dart';
import 'package:forumapp/controllers/post_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum APP'),
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                hintText: 'what do you want to ask?',
                controller: _textController,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45,
                    vertical: 10,
                  ),
                ),
                onPressed: () async {
                  await _postController.createPost(
                    content: _textController.text.trim(),
                  );
                  _textController.clear();
                  _postController.getAllPosts();
                },
                child: Obx(() {
                  return _postController.isLoading.value ? const CircularProgressIndicator() : Text('Post');
                }),
              ),
              const SizedBox(
                height: 0,
              ),
              Text('Posts'),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return _postController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postController.posts.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: postdata(
                              post: _postController.posts.value[index],
                            ),
                          );
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
