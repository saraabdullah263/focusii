import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_loading.dart';
import 'package:focusi/features/home/model_veiw/story_cubit/story_cubit.dart';
import 'package:focusi/features/home/model_veiw/story_cubit/story_state.dart';
import 'package:focusi/features/home/widget/custom_story_card.dart';
import 'package:focusi/features/home/date/model/story_model.dart';
import 'package:go_router/go_router.dart';

class StoriesVeiw extends StatefulWidget {
  const StoriesVeiw({super.key});

  @override
  State<StoriesVeiw> createState() => _StoriesVeiwState();
}

class _StoriesVeiwState extends State<StoriesVeiw> {
  bool _hasFetchedStories = false;

  @override
  void initState() {
    super.initState();

    if (!_hasFetchedStories) {
      final token = CacheHelper.getData(key: 'userToken');

      if (token != null && token is String && token.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<StoryCubit>().fetchStories(token);
        });
        _hasFetchedStories = true;
      } else {
        debugPrint('❌ Token is null or empty');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<StoryCubit, StoryState>(
        listener: (context, state) {
          if (state is StoryFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          List<StoryModel> stories = [];

          if (state is StorySuccess) {
            stories = state.stories;
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRoutes.kmainVeiw);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 35),
                ),
                SizedBox(height: screenHeight * .06),
                const Center(
                  child: Text(
                    'Stories for child:',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                SizedBox(height: screenHeight * .04),
                if (state is StoryLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CustomLoading(),
                    ),
                  )
                else if (stories.isNotEmpty)
                  ...stories.map((story) => CustomStoryCard(story: story))
                else
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No stories available',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
