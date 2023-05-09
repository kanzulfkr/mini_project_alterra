import 'package:flutter/material.dart';

class Feeds extends StatelessWidget {
  const Feeds({
    Key? key,
    required this.name,
    required this.feed,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  }) : super(key: key);
  final String name;
  final String feed;
  final String commentCount;
  final String likeCount;
  final String shareCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 30,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 28.5,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 270,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      '$likeCount h',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete'))
                ],
                child: Image.asset('assets/icons/option.png'),
              )
            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 200,
          decoration: BoxDecoration(color: Colors.grey[300]),
        ),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/love.png'),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: 60,
                child: Text(
                  likeCount,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              InkWell(
                child: Image.asset('assets/icons/comment.png'),
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset('assets/icons/divider.png'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Comments ($commentCount)',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 20,
                                ),
                                SizedBox(
                                  width: 260,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            name,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '${shareCount}h',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        feed,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuButton(
                                  child: Image.asset('assets/icons/option.png'),
                                  position: PopupMenuPosition.under,
                                  itemBuilder: (context) => const [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem(
                                        value: 'delete', child: Text('Delete'))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: 60,
                child: Text(
                  commentCount,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Image.asset('assets/icons/share.png'),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: 60,
                child: Text(
                  shareCount,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Text(
            feed,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
