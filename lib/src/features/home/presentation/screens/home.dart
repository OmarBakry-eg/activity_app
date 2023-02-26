import 'package:activity_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:activity_app/src/features/home/presentation/widgets/welcome_message_widget.dart';
import 'package:activity_app/src/utils/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/activites_list_wldget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit =
        BlocProvider.of<HomeCubit>(context, listen: false);

    return Scaffold(
      appBar: const HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await homeCubit.callGetRandomActivites();
        },
        child: SingleChildScrollView(
          child: Column(
            children: const [
              WelcomeMessageWidget(),
              SizedBox(
                height: 20,
              ),
              ActivitiesListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
