import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class Post {
  final int id;
  final String title;
  final String content;
  final User writer;
  final List<Comment> comments;
  final DateTime createdAt;
  final int likes;
  final bool liked;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.writer,
    required this.comments,
    required this.createdAt,
    required this.likes,
    required this.liked
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedTitle = json['title'];
    final String parsedContent = json['content'];
    User parsedWriter = User.fromJson(json['writer']);

    List<Comment> parsedComments = [];
    if (json['comments'] != null) {
      var commentsList = json['comments'] as List<dynamic>;
      parsedComments = commentsList.map((v) => Comment.fromJson(v)).toList();
    }

    final DateTime parsedCreatedAt = json['createdAt'];
    final int parsedLikes = json['likes'];
    final bool parsedLiked = json['liked'];

    return Post(
      id: parsedId,
      title: parsedTitle,
      content: parsedContent,
      writer: parsedWriter,
      comments: parsedComments,
      createdAt: parsedCreatedAt,
      likes: parsedLikes,
      liked: parsedLiked
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['writer'] = writer;
    data['comments'] = comments;
    data['createdAt'] = createdAt;
    data['likes'] = likes;
    data['liked'] = liked;
    return data;
  }

  @override
  String toString() {
    return 'Post{id: $id, title: $title, content: $content, writer: $writer, comments: $comments, createdAt: $createdAt, likes: $likes, liked: $liked}';
  }

  bool isLiked() {
    if (liked == true) {
      return true;
    } else {
      return false;
    }
  }
}