import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_loading.dart';
import 'package:focusi/features/home/model_veiw/advice_cubit/advice_cubit.dart';
import 'package:focusi/features/home/model_veiw/advice_cubit/advice_state.dart';
import 'package:go_router/go_router.dart';


class AdvicesVeiw extends StatefulWidget {
  const AdvicesVeiw({super.key});

  @override
  State<AdvicesVeiw> createState() => _AdvicesVeiwState();
}

class _AdvicesVeiwState extends State<AdvicesVeiw> {
  bool _hasFetchedAdvice = false;

  @override
  void initState() {
    super.initState();

    if (!_hasFetchedAdvice) {
      final token = CacheHelper.getData(key: 'userToken');

      if (token != null && token is String && token.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<AdviceCubit>().getAdvice(token);
        });

        _hasFetchedAdvice = true;
      } else {
        debugPrint('❌ Token is null or empty');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocConsumer<AdviceCubit, AdviceState>(
        listener: (context, state) {
          if (state is AdviceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          List<String> advices = [];

          if (state is AdviceLoaded) {
            advices = state.advice.advice;
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed:(){  GoRouter.of(context).push(AppRoutes.kmainVeiw);}, icon:Icon( Icons.arrow_back,color: Colors.white,size: 35,)),
                SizedBox(height: screenHeight * .06),
                const Center(
                  child: Text(
                    'Advice for child:',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                if (state is AdviceLoading)
                  const Center(child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CustomLoading(),
                  ))
                else if (advices.isNotEmpty)
                  ...advices.asMap().entries.map(
                    (entry) => Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                        vertical: screenHeight * .015,
                        horizontal: screenWidth * .03,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * .01,
                          vertical: screenHeight * .03,
                        ),
                        child: ListTile(
                          title:  Text(' Advice ${entry.key + 1} :',style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                           
                         
                        subtitle:  Text(
                          ' ${entry.value}',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  )
                    ))
                else
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No advice available',
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
