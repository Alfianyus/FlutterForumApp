import 'package:flutter/material.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/views/post_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class postdata extends StatefulWidget {
  const postdata({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<postdata> createState() => _postdataState();
}

class _postdataState extends State<postdata> {
  final PostController _postController = Get.put(PostController());
  Color likedPost = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.user!.name!,
            style: GoogleFonts.poppins(),
          ),
          Text(
            widget.post.user!.email!,
            style: GoogleFonts.poppins(
              fontSize: 10,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.post.content!,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await _postController.likeAndDislike(widget.post.id);
                  _postController.getAllPosts();
                },
                icon: Icon(
                  Icons.thumb_up,
                  color: widget.post.liked! ? Colors.blue : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(
                    () => PostDetails(
                      post: widget.post,
                    ),
                  );
                },
                icon: Icon(Icons.message),
              ),
            ],
          )
        ],
      ),
    );
  }
}
