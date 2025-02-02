import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_1/database.dart';

class Post
{
  String bodyText;
  String author;
  List usersLiked = [];
  late DatabaseReference postDbId;

  Post(this.bodyText, this.author);

  void likePost(User user)
  {
    if (this.usersLiked.contains(user.uid))
    {
      this.usersLiked.remove(user.uid);
    }
    else
    {
      this.usersLiked.add(user.uid);
    }

    this.updatePostLikes();
  }

  void updatePostLikes()
  {
    updatePost(this, postDbId);
  }

  void setDbId(DatabaseReference id)
  {
    this.postDbId = id;
  }

  Map<String, dynamic> toJsonFormat()
  {
    return{
      'author': this.author,
      'usersLiked': this.usersLiked,
      'body': this.bodyText
    };
  }
}