import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import 'package:flutter/material.dart';
import "database.dart";
import "Post.dart";
import "TextInputWidget.dart";
import "PostListWidget.dart";

class MyHomePage extends StatefulWidget {
  final User firebaseUser;
  const MyHomePage(this.firebaseUser, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> userPosts = [];

  String text = "";

  void addPost(String text) {
    setState(() {
      var post = Post(text, widget.firebaseUser.displayName.toString());
      userPosts.add(post);
      DatabaseReference postDbId = savePostToDatabase(post);
      post.setDbId(postDbId); //this sets the postDbId attribute under the Post class to be the unique Database ID that
      //is created from the PostTodatabase function, under the database.dart file which adds the post to the database in the backend.
    });

  }

  void retrieveLatestPosts()
  {
    retrievePostsfromDatabase().then((retrievedPosts)=>{
      if (retrievedPosts.isNotEmpty)
      {
        this.setState(() {
          this.userPosts = retrievedPosts;
        })
      }
    });
  }

  @override
  void initState()
  {
    super.initState();
    retrieveLatestPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hello world")),
      body: Column(children: <Widget>[
        Expanded(child: PostsListWidget(userPosts, widget.firebaseUser)),
        TextInputWidget(addPost)
      ]),
    );
  }
}
