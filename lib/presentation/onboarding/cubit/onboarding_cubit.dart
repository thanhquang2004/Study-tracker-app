import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/onboarding/model/onboarding_model.dart';
import 'package:study_tracker_mobile/presentation/resources/assets_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/strings_manager.dart';

class OnboardingCubit extends Cubit<int> {
  final List<OnboardingModel> pages = [
    OnboardingModel(
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingSubTitle1,
      image: ImageAssets.onboardingLogo1,
    ),
    OnboardingModel(
      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingSubTitle2,
      image: ImageAssets.onboardingLogo2,
    ),
    OnboardingModel(
      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingSubTitle3,
      image: ImageAssets.onboardingLogo3,
    ),
    OnboardingModel(
      title: AppStrings.onBoardingTitle4,
      description: AppStrings.onBoardingSubTitle4,
      image: ImageAssets.onboardingLogo4,
    ),
  ];

  OnboardingCubit() : super(0);

  void nextPage(context) => state < pages.length - 1
      ? emit(state + 1)
      : Navigator.pushReplacementNamed(context, '/login');

  void skipOnboarding(context) =>
      Navigator.pushReplacementNamed(context, '/login');
}
