import 'package:bahanku/view/component_widgets/component_widgets.dart';
import 'package:bahanku/view/onboarding/on_boarding.dart';
import 'package:flutter/material.dart';

import 'package:bahanku/models/api_response.dart';
import 'package:bahanku/models/comment/comment.dart';
import 'package:bahanku/api/comment_service.dart';
import 'package:bahanku/api/user_service.dart';
import 'package:bahanku/constant/app_services.dart';

class CommentPage extends StatefulWidget {
  final int? postId;

  CommentPage({this.postId});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<dynamic> _commentsList = [];
  bool _loading = true;
  int userId = 0;
  int _editCommentId = 0;
  TextEditingController _txtCommentController = TextEditingController();

  // Get comments
  Future<void> _getComments() async {
    userId = await getUserId();
    ApiResponse response = await getComments(widget.postId ?? 0);

    if (response.error == null) {
      setState(() {
        _commentsList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OnBoarding()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _createComment() async {
    ApiResponse response =
        await createComment(widget.postId ?? 0, _txtCommentController.text);

    if (response.error == null) {
      _txtCommentController.clear();
      _getComments();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OnBoarding()),
                (route) => false)
          });
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _editComment() async {
    ApiResponse response =
        await editComment(_editCommentId, _txtCommentController.text);

    if (response.error == null) {
      _editCommentId = 0;
      _txtCommentController.clear();
      _getComments();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OnBoarding()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _deleteComment(int commentId) async {
    ApiResponse response = await deleteComment(commentId);

    if (response.error == null) {
      _getComments();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OnBoarding()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    _getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget listComment() {
      return ListView.builder(
        itemCount: _commentsList.length,
        itemBuilder: (BuildContext context, int index) {
          Comment comment = _commentsList[index];
          return Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black26, width: 0.5))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              image: comment.user!.image != null
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          '${comment.user!.image}'),
                                      fit: BoxFit.cover)
                                  : null,
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blueGrey),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${comment.user!.name}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                    comment.user!.id == userId
                        ? PopupMenuButton(
                            child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.grey[700],
                                )),
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
                            onSelected: (val) {
                              if (val == 'edit') {
                                setState(
                                  () {
                                    _editCommentId = comment.id ?? 0;
                                    _txtCommentController.text =
                                        comment.comment ?? '';
                                  },
                                );
                              } else {
                                _deleteComment(comment.id ?? 0);
                              }
                            },
                          )
                        : const SizedBox()
                  ],
                ),
                const SizedBox(height: 10),
                Text('${comment.comment}')
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                      onRefresh: () {
                        return _getComments();
                      },
                      child: listComment()),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black26, width: 0.5)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: kInputDecoration('Comment'),
                          controller: _txtCommentController,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.grey[700],
                        ),
                        onPressed: () {
                          if (_txtCommentController.text.isNotEmpty) {
                            setState(() {
                              _loading = true;
                            });
                            if (_editCommentId > 0) {
                              _editComment();
                            } else {
                              _createComment();
                            }
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
