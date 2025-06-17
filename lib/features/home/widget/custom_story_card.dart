import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/features/home/date/model/story_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomStoryCard extends StatelessWidget {
  final StoryModel story;

  const CustomStoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .05,
                  vertical: MediaQuery.of(context).size.height * .05,
                ),
                child: Column(
                  children: [
                    Image.network(
                      story.coverPageUrl ?? 'https://via.placeholder.com/150',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 100);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    Text(
                      story.storyName ?? '',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: AppColors.primaryColor, width: 2),
                        ),
                      ),
                     onPressed: () async {
  final url = story.storyUrl;

  if (url != null && url.isNotEmpty) {
    final encodedUrl = Uri.encodeFull(url); 
    try {
      await launchUrlString(encodedUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Story not available'),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid story URL'),
      ),
    );
  }
},

                      child: Text(
                        'See full story',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
