import 'package:flutter/material.dart';

class CommunityDrawer extends StatelessWidget {
  const CommunityDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ListView(
            children: const [
              CommunityDrawerHeader( // FIXME
                  avatar: "https://img3.sycdn.imooc.com/61c58ca10001966a09600960-140-140.jpg",
                  username: "列奥那多是勇者",
                  userId: "LeonardoZarkli",
                  following: 10,
                  followers: 10000
              ),
              Divider(),
              DrawerItem(icon: Icons.person_outline, label: "个人主页"),
              DrawerItem(icon: Icons.topic_outlined, label: "话题"),
              DrawerItem(icon: Icons.bookmark_border_outlined, label: "书签"),
            ],
          ),
        )
      )
    );
  }
}



class CommunityDrawerHeader extends StatelessWidget {
  final String avatar;
  final String username;
  final String userId;
  final int following;
  final int followers;

  const CommunityDrawerHeader({Key? key, required this.avatar, required this.username, required this.userId,
    required this.following, required this.followers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(200)),
            child: Image.network(avatar, width: 80,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                Expanded(child: Text("@$userId", style: const TextStyle(fontSize: 16),)),
                const Icon(Icons.arrow_downward,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Text(following.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                const Text(" 正在关注", style: TextStyle(fontSize: 18),),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(followers.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                const Text(" 关注者", style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const DrawerItem({Key? key,required this.icon,required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 28,),
        ),
        Padding(padding: const EdgeInsets.all(8.0),
          child: Text(label, style: const TextStyle(fontSize: 18),),
        )
      ],
    );
  }
}

