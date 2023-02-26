import 'package:activity_app/src/features/activites/presentation/cubit/activity_cubit.dart';
import 'package:activity_app/src/features/activites/presentation/widgets/activity_text_field.dart';
import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/utils/ui/my_colors.dart';
import 'package:flutter/material.dart';
import '../../../../utils/base/app_form_validator.dart';

class ActivityFormWidget extends StatelessWidget {
  const ActivityFormWidget({
    super.key,
    required this.activityCubit,
    required this.activityEntity,
  });

  final ActivityCubit activityCubit;
  final ActivityEntity? activityEntity;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: activityCubit.formKey,
      child: Column(
        children: [
          ActivityTextField(
            textEditingController: activityCubit.activityQuoteTextController,
            lable: 'Activity Quote',
            hint: activityEntity?.activity ?? "Activity",
            validator: AppFormValidator.generalEmptyValidator,
          ),
          const Divider(
            color: MyColors.borderColor,
          ),
          ActivityTextField(
            textEditingController: activityCubit.activityTypeTextController,
            lable: 'Activity Type',
            hint: activityEntity?.type ?? "Type",
            isMultiline: true,
            validator: AppFormValidator.generalEmptyValidator,
          ),
        ],
      ),
    );
  }
}
