import 'dart:math';

import 'package:bahanku/api/constant.dart';
import 'package:bahanku/models/api_response.dart';
import 'package:bahanku/models/post.dart';
import 'package:bahanku/services/post_service.dart';
import 'package:bahanku/services/user_service.dart';
import 'package:bahanku/view/forum/create_post_screen.dart';
import 'package:bahanku/view/forum/reference/comment.dart';
import 'package:bahanku/view/login/login.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getPosts();

    if (response.error == null) {
      setState(
        () {
          _postList = response.data as List<dynamic>;
          _loading = _loading ? !_loading : _loading;
        },
      );
    } else if (response.error == unauthorized) {
      logout().then(
        (value) => {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
              (route) => false)
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  void _handleDeletePost(int postId) async {
    ApiResponse response = await deletePost(postId);
    if (response.error == null) {
      retrievePosts();
    } else if (response.error == unauthorized) {
      logout().then(
        (value) => {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
              (route) => false)
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  // post like dislik
  void _handlePostLikeDislike(int postId) async {
    ApiResponse response = await likeUnlikePost(postId);

    if (response.error == null) {
      retrievePosts();
    } else if (response.error == unauthorized) {
      logout().then(
        (value) => {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
              (route) => false)
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget forumList() {
      return _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 660,
              child: RefreshIndicator(
                onRefresh: () {
                  return retrievePosts();
                },
                child: ListView.builder(
                  itemCount: _postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Post post = _postList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                radius: 30,
                                child: Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    image: post.user!.image != null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              '${post.user!.image}',
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : const DecorationImage(
                                            image: NetworkImage(
                                                defaultProfilePicture),
                                            fit: BoxFit.cover,
                                            scale: 0.5,
                                          ),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 270,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${post.user!.name}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Text(
                                      '8h',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              post.user!.id == userId
                                  ? PopupMenuButton(
                                      position: PopupMenuPosition.under,
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Text('Edit'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        )
                                      ],
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.grey[700],
                                      ),
                                      onSelected: (val) {
                                        if (val == 'edit') {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      PostForm(
                                                        title: 'Edit Post',
                                                        post: post,
                                                      )))
                                              .then((value) {
                                            setState(() {
                                              retrievePosts();
                                            });
                                          });
                                        } else {
                                          _handleDeletePost(post.id ?? 0);
                                        }
                                      },
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Text(
                            '${post.body}',
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                        post.image != null
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage('${post.image}'),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : SizedBox(height: post.image != null ? 0 : 10),
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(
                              left: 20, top: 8, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Image.asset('assets/icons/love.png'),
                              InkWell(
                                child: Image.asset(
                                  post.selfLiked == true
                                      ? 'assets/icons/love.png'
                                      : 'assets/icons/love.png',
                                  scale: 1.2,
                                  color: post.selfLiked == true
                                      ? Colors.red
                                      : Colors.grey[800],
                                ),
                                onTap: () {
                                  _handlePostLikeDislike(post.id ?? 0);
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                width: 60,
                                child: Text(
                                  post.likesCount != 0
                                      ? '${post.likesCount}'
                                      : '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              InkWell(
                                child: Image.asset(
                                  'assets/icons/comment.png',
                                  scale: 1.2,
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => CommentPage(
                                        postId: post.id,
                                      ),
                                    ),
                                  )
                                      .then(
                                    (value) {
                                      setState(() {
                                        retrievePosts();
                                      });
                                    },
                                  );
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                width: 60,
                                child: Text(
                                  post.commentsCount != 0
                                      ? '${post.commentsCount}'
                                      : '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Image.asset(
                                'assets/icons/share.png',
                                scale: 1.2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
    }

    Widget titleText() {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        height: 100,
        width: double.maxFinite,
        child: const Center(
          child: Text(
            'News Feed',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    Widget contentForumPage() {
      return Column(
        children: [
          titleText(),
          forumList(),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: contentForumPage(),
    );
  }
}
