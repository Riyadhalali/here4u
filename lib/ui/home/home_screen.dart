import 'package:flutter/material.dart';
import 'package:here4u/providers/post_provider.dart';
import 'package:here4u/ui/home/components/drawer.dart';
import 'package:here4u/ui/home/components/emptyposts.dart';
import 'package:here4u/ui/home/components/imageslider.dart';
import 'package:here4u/ui/home/components/post.dart';
import 'package:here4u/utils/database.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  bool fetching = true;
  DB db = DB();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    var postProvider = Provider.of<PostProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ImageSlider(),
        Divider(),
        Expanded(
          child: Provider.of<PostProvider>(context).items.length == 0
              ? EmptyPosts()
              : Consumer<PostProvider>(
                  builder: (context, postProvider, child) => ListView.builder(
                    itemCount: postProvider.items.length,
                    itemBuilder: (context, index) {
                      return PostPage(
                        textPost: postProvider.items[index].textPost,
                        datePost: postProvider.items[index].date,
                        // imagePath:
                        //     '/data/user/0/com.example.here4u/cache/image_picker4817170398834859554.jpg',
                        imagePath:
                            postProvider.items[index].imagePath.toString(),
                      );
                    },
                  ),
                ),
        )
      ],
    );
  }

//------------------------------------------------------------------------------
}
