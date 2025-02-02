import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "Post.dart";

class PostsListWidget extends StatefulWidget 
{

  final List<Post> listOfPosts;
  final User firebaseUser;

  const PostsListWidget(this.listOfPosts, this.firebaseUser, {super.key});

  @override
  State<PostsListWidget> createState() => _PostsListWidgetState();
}

class _PostsListWidgetState extends State<PostsListWidget> 
{
  void setStateUpdateLikes(Function callbackfunc)
  {
    setState(() {
      callbackfunc();
    });
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
      itemCount: this.widget.listOfPosts.length,
      itemBuilder: (context, index)
      {
        var post = this.widget.listOfPosts[index];
        return Card
        (child: Row(children: 
            <Widget>[Expanded(child: ListTile(title: Text(post.bodyText),
                                              subtitle: Text(post.author))),
                      Row(children: <Widget>[Container(child:Text(post.usersLiked.length.toString())),
                                            IconButton(onPressed: () => setStateUpdateLikes(()=> post.likePost(widget.firebaseUser)), 
                                                        color: post.usersLiked.contains(widget.firebaseUser.uid)? Colors.green : Colors.black, 
                                                        icon: Icon(Icons.thumb_up))]),
                    ]
        ));
      },
    );
  }
}