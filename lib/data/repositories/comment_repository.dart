

import 'package:comments/constants/apis.dart';
import 'package:comments/data/handlers/http_handlers.dart';
import 'package:comments/data/models/comment_model.dart';

class CommentRepository{

  HttpHandlers handler = HttpHandlers();

  Future<List<Comment>> getComments() async{
    final response = await handler.get(APIS.COMMENTS_URL, authorizationRequired: false);
    final List comments = response;
    return comments.map((e) => Comment.fromJson(e)).toList();
  }

}