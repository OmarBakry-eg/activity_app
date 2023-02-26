import 'package:activity_app/src/utils/ui/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import '../cubit/home_cubit.dart';

class WelcomeMessageWidget extends StatelessWidget {
  const WelcomeMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit =
        BlocProvider.of<HomeCubit>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 27),
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Color(0xff172735),
                      letterSpacing: 0.42,
                    ),
                    children: [
                      TextSpan(
                        text: 'Good ${homeCubit.welcomeTimeMessage}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const TextSpan(
                        text: ' ',
                      ),
                      const TextSpan(
                        text: 'Distributed',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      const TextHeightBehavior(applyHeightToFirstAscent: false),
                  softWrap: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'TODAY DATE',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: MyColors.purpleColor,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: false,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Text(
              intl.DateFormat.yMd().format(DateTime.now()),
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 17,
                color: Color(0xff172735),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            )
          ],
        ),
      ),
    );
  }
}
