// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_sheet_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RateSheetViewModel on _RateSheetViewModelBase, Store {
  late final _$ratingAtom =
      Atom(name: '_RateSheetViewModelBase.rating', context: context);

  @override
  double get rating {
    _$ratingAtom.reportRead();
    return super.rating;
  }

  @override
  set rating(double value) {
    _$ratingAtom.reportWrite(value, super.rating, () {
      super.rating = value;
    });
  }

  late final _$firstSheetOpacityAtom =
      Atom(name: '_RateSheetViewModelBase.firstSheetOpacity', context: context);

  @override
  double get firstSheetOpacity {
    _$firstSheetOpacityAtom.reportRead();
    return super.firstSheetOpacity;
  }

  @override
  set firstSheetOpacity(double value) {
    _$firstSheetOpacityAtom.reportWrite(value, super.firstSheetOpacity, () {
      super.firstSheetOpacity = value;
    });
  }

  late final _$isFirstSheetVisibleAtom = Atom(
      name: '_RateSheetViewModelBase.isFirstSheetVisible', context: context);

  @override
  bool get isFirstSheetVisible {
    _$isFirstSheetVisibleAtom.reportRead();
    return super.isFirstSheetVisible;
  }

  @override
  set isFirstSheetVisible(bool value) {
    _$isFirstSheetVisibleAtom.reportWrite(value, super.isFirstSheetVisible, () {
      super.isFirstSheetVisible = value;
    });
  }

  late final _$noActionAsyncAction =
      AsyncAction('_RateSheetViewModelBase.noAction', context: context);

  @override
  Future<void> noAction(BuildContext context) {
    return _$noActionAsyncAction.run(() => super.noAction(context));
  }

  late final _$sureActionAsyncAction =
      AsyncAction('_RateSheetViewModelBase.sureAction', context: context);

  @override
  Future<void> sureAction(BuildContext context) {
    return _$sureActionAsyncAction.run(() => super.sureAction(context));
  }

  @override
  String toString() {
    return '''
rating: ${rating},
firstSheetOpacity: ${firstSheetOpacity},
isFirstSheetVisible: ${isFirstSheetVisible}
    ''';
  }
}
