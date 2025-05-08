
import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';

class ResourceWidget extends StatelessWidget {
  final Resource resource;

  const ResourceWidget({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(resource.content),
          if (resource.links.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: resource.links
                  .map((link) => GestureDetector(
                        onTap: () {
                          // TODO: Implement link navigation (e.g., launch URL)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Open link: $link')),
                          );
                        },
                        child: Text(
                          link,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}