import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/data/services/roadmap_service.dart';
import 'package:study_tracker_mobile/presentation/generate/cubit/generate_cubit.dart';
import 'package:study_tracker_mobile/presentation/generate/cubit/generate_model.dart';
import 'package:study_tracker_mobile/presentation/generate/view/roadmap_view.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart'; // Import màn hình mới

/// Quiz Page with chat-like UI
class GenerateView extends StatefulWidget {
  const GenerateView({Key? key}) : super(key: key);
  @override
  _GenerateViewState createState() => _GenerateViewState();
}
class _GenerateViewState extends State<GenerateView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenerateCubit(RoadmapService()),
      child: Scaffold(
        appBar: AppBar(title: Text('Quiz Chat')),
        body: BlocConsumer<GenerateCubit, GenerateModel>(
          listener: (context, state) {
            if (state.roadmap != null) {
              // Chuyển hướng đến RoadmapView và truyền roadmap
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RoadmapView(roadmap: state.roadmap!),
                ),
              );
            }
            if (state.error != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      return Align(
                        alignment: msg.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? Colors.blueAccent
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color: msg.isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Add TextButton to view roadmap if it exists
                if (state.roadmap != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                RoadmapView(roadmap: state.roadmap!),
                          ),
                        );
                      },
                      child: Text(
                        'View Roadmap',
                        style: getSemiBoldStyle(color: XColors.primary, fontSize: 16,)
                      ),
                    ),
                  ),
                if (state.isLoading)
                  LinearProgressIndicator()
                else
                  Column(
                    children: [
                      if (state.quiz.suggestAnswer.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          children: state.quiz.suggestAnswer.map((opt) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 40),
                              child: ChoiceChip(
                                label: Text(opt.content),
                                selected: false,
                                onSelected: (_) {
                                  context
                                      .read<GenerateCubit>()
                                      .submitAnswer(opt.content);
                                },
                              ),
                            );
                          }).toList(),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: 'Type your answer...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.send, color: XColors.primary),
                                onPressed: () {
                                  final text = _controller.text.trim();
                                  if (text.isNotEmpty) {
                                    context
                                        .read<GenerateCubit>()
                                        .submitAnswer(text);
                                    _controller.clear();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}