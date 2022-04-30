import 'package:flutter/material.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../rate_sheet_first.dart';
import '../rate_sheet_second.dart';
import '../rating_helper.dart';

part 'rate_sheet_viewmodel.g.dart';

class RateSheetViewModel = _RateSheetViewModelBase with _$RateSheetViewModel;

abstract class _RateSheetViewModelBase with Store {
  @observable
  double rating = 0;

  @observable
  double firstSheetOpacity = 1;

  @observable
  bool hasRated = false;

  @observable
  bool isFirstSheetVisible = true;

  @action
  Future<void> noAction(BuildContext context) async {
    Navigator.pop(context);
    rating = 0;
    firstSheetOpacity = 1;
    isFirstSheetVisible = true;
  }

  @action
  void navigateToFeedback(BuildContext context) {
    Navigator.pop(context);
    rating = 0;
    firstSheetOpacity = 1;
    isFirstSheetVisible = true;
  }

  @action
  Future<void> sureAction(BuildContext context) async {
    Navigator.pop(context);
    await RatingHelper.shared.requestReview();
    rating = 0;
    firstSheetOpacity = 1;
    isFirstSheetVisible = true;
  }

  @action
  Future<void> showRatingSheet(BuildContext context) async {
    var isAvailable = await RatingHelper.shared.inAppReview.isAvailable();
    if (isAvailable && !hasRated) {
      hasRated = true;
    showModalBottomSheet(
        useRootNavigator: true,
        enableDrag: false,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.width() * 0.05),
                topRight: Radius.circular(context.width() * (0.05)))),
        context: context,
        builder: (context) {
          return Container(
            height: context.height() * (0.4),
            child: Column(
              children: [
                SizedBox(
                  height: context.height() * (0.01),
                ),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      RateSheetSecond(),
                      RateSheetFirst(),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.height() * (0.05),
                ),
              ],
            ),
          );
        });
    }
  }
}
