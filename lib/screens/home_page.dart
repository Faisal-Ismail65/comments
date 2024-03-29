import 'package:comments/data/models/comment_model.dart';
import 'package:comments/data/repositories/comment_repository.dart';
import 'package:comments/logic/comment_bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Comment> comments = [];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentBloc(CommentRepository())..add(CommentEventGetComments()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Comments'),
        ),
        body: BlocConsumer<CommentBloc, CommentState>(
          listener: (context, state) {
            if(state is CommentStateError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if(state is CommentStateLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state is CommentStateLoaded){
              comments = state.comments;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return ListTile(
                      title: Text(comment.body ?? ''),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              comments.removeAt(index);
                            });

                      }, icon: const Icon(Icons.delete, color: Colors.red)),);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}