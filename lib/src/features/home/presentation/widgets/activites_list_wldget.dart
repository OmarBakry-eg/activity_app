import 'package:activity_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:activity_app/src/features/home/presentation/widgets/no_activity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'activity_widget.dart';

class ActivitiesListWidget extends StatelessWidget {
  const ActivitiesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.callGetRandomActivites();
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        return state is HomeLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state is HomeLoaded
                ? state.activites.isEmpty
                    ? const NoActivityWidget(
                        title: 'No activites for now\nTry add new one!',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 30),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (c, i) => ActivityWidget(
                              activityEntity: state.activites[i],
                            ),
                        separatorBuilder: (c, i) => const Divider(
                              color: Colors.black,
                              thickness: 0.7,
                              height: 20,
                            ),
                        itemCount: state.activites.length)
                : state is ErrorHomeState
                    ? NoActivityWidget(
                        title: state.message,
                      )
                    : const SizedBox.shrink();
      },
    );
  }
}
