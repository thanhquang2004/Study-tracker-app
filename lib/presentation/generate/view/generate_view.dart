import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/data/services/roadmap_service.dart';
import 'package:study_tracker_mobile/presentation/generate/cubit/generate_cubit.dart';
import 'package:study_tracker_mobile/presentation/generate/cubit/generate_model.dart';
import 'package:study_tracker_mobile/presentation/generate/view/roadmap_view.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/loader.dart';

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
        appBar: AppBar(
          title: Text(
            'Generate Roadmap',
            style: getBoldStyle(color: XColors.primary, fontSize: 20),
          ),
          elevation: 0,
          forceMaterialTransparency: false,
        ),
        body: BlocConsumer<GenerateCubit, GenerateModel>(
          listener: (context, state) {
            if (state.roadmap != null) {
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
            return Stack(
              children: [
                Column(
                  children: [
                    // Messages List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final msg = state.messages[index];
                          return Align(
                            alignment: msg.isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 14),
                              decoration: BoxDecoration(
                                color: msg.isUser
                                    ? Colors.blueAccent
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                msg.text,
                                style: TextStyle(
                                  color: msg.isUser
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Suggested Answers (ChoiceChips)
                    if (state.quiz.suggestAnswer.isNotEmpty)
                      Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.quiz.suggestAnswer.length,
                          itemBuilder: (context, index) {
                            final opt = state.quiz.suggestAnswer[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: ChoiceChip(
                                label: Text(opt.content),
                                selected: false,
                                onSelected: (_) {
                                  context
                                      .read<GenerateCubit>()
                                      .submitAnswer(opt.content);
                                },
                                backgroundColor: Colors.grey[200],
                                selectedColor: XColors.primary.withOpacity(0.2),
                                labelStyle: TextStyle(color: Colors.black87),
                              ),
                            );
                          },
                        ),
                      ),
                    if (state.isLoading) Loader(),
                    // View Roadmap Button
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
                            style: getSemiBoldStyle(
                              color: XColors.primary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    // Input Field
                    SafeArea(
                      child: Padding(
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
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
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
                    ),
                  ],
                ),
                // Loader
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
