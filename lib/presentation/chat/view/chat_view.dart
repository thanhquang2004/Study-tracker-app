import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  final List<String> messages = [
    'Welcome to the chatbot!',
    'How can I assist you today?',
  ];

  final Map<String, List<String>> responseOptions = {
    'How can I assist you today?': [
      'Tell me a joke',
      'What is the weather like?',
      'Give me a quote',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                  subtitle: responseOptions.containsKey(messages[index])
                      ? Wrap(
                          spacing: 8.0,
                          children: responseOptions[messages[index]]!
                              .map((option) => ElevatedButton(
                                    onPressed: () {
                                      // Handle option selection
                                      print('Selected: $option');
                                    },
                                    child: Text(option),
                                  ))
                              .toList(),
                        )
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: () {
                    // Implement send message functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
