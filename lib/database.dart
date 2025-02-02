import 'Post.dart';

import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final firebaseDatabaseReference = FirebaseDatabase.instance.ref();

DatabaseReference savePostToDatabase(Post post){
  var id = firebaseDatabaseReference.child('posts').push();
  id.set(post.toJsonFormat());
  return id;
}

void updatePost(Post post, DatabaseReference postId)
{
  postId.update(post.toJsonFormat());
}

Future <List<Post>> retrievePostsfromDatabase() async
{
  List<Post> retrievedPosts = [];
  DataSnapshot dataSnapshot = await firebaseDatabaseReference.child('posts/').get();
  //casting as a datasnapshot via (content) as <Type>, since <DatabaseReference> and <DataSnapshot> are two different types. 
  //Even if <DatabaseReference>.child().once() returns a <Datasnapshot> type, still cast to remove the direct assignment error / colloquial.
  if (dataSnapshot.value != null)
  {
    var data = dataSnapshot.value as Map<dynamic, dynamic>;
    Map values = Map<dynamic, dynamic>.from(data);
    values.forEach((key, value) {
      Post post = initializePost(value);
      post.setDbId(firebaseDatabaseReference.child('posts/$key'));
      retrievedPosts.add(post);
    },);
  }
  return retrievedPosts;
}

Post initializePost(dbRecord)
{
    Map<String,dynamic> attributes =
    {
      "author": " ",
      "body": " ",
      "usersLiked": []
    };

    dbRecord.forEach((key,value) =>{
      attributes[key] = value,});

    return Post(attributes["body"], attributes["author"]);
}
