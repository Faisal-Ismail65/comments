part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentStateLoading extends CommentState{}

class CommentStateLoaded extends CommentState{
  final List<Comment> comments;
  CommentStateLoaded({required this.comments});

}

class CommentStateError extends CommentState{
  final String message;
  CommentStateError(this.message);
}
