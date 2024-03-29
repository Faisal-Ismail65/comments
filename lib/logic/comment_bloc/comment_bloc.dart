import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comments/data/exceptions/http_exceptions.dart';
import 'package:comments/data/models/comment_model.dart';
import 'package:comments/data/repositories/comment_repository.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentRepository commentRepository = CommentRepository();
  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<CommentEventGetComments>((event, emit) async {
      try{
        emit(CommentStateLoading());

        final comments = await commentRepository.getComments();

        emit(CommentStateLoaded(comments: comments));

      }on FetchDataException catch(e){
        emit(CommentStateError(e.message));
      }

    });
  }
}
