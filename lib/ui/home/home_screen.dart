import 'package:flutter/material.dart';
import 'package:here4u/providers/post_provider.dart';
import 'package:here4u/ui/home/components/drawer.dart';
import 'package:here4u/ui/home/components/imageslider.dart';
import 'package:here4u/ui/home/components/post.dart';
import 'package:provider/provider.dart';

import 'components/emptyposts.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Here4U"),
      ),
      //-> if we put an singlechildscrolview it will give us an error
      body: columnElements(context),
      drawer: DrawePage(),
    );
  }

  //-------------------------------Widget Tree----------------------------------
  Widget columnElements(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ImageSlider(),
        Divider(),
        Expanded(
          child: postProvider.getPosts.isEmpty
              ? EmptyPosts()
              : ListView.builder(
                  itemCount: postProvider.getPosts.length,
                  itemBuilder: (BuildContext context, index) {
                    return ChangeNotifierProvider.value(
                      value: postProvider.getPosts.values.toList()[index],
                      child: PostPage(
                        id: postProvider.getPosts.values.toList()[index].id,
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }

//------------------------------------------------------------------------------
}
