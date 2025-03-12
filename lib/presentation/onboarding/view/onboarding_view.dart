import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:study_tracker_mobile/presentation/resources/strings_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/custom_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => OnboardingCubit(),
        child: BlocListener<OnboardingCubit, int>(
          listener: (context, state) {
            _pageController.animateToPage(
              state,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: BlocBuilder<OnboardingCubit, int>(
            builder: (context, state) {
              final cubit = context.read<OnboardingCubit>();
              return SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        title: "Bỏ qua",
                        type: ButtonType.text,
                        onPressed: () {
                          cubit.skipOnboarding(context);
                        },
                        enableSplash: false,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.pages.length,
                        onPageChanged: (index) =>
                            cubit.emit(index), // Cập nhật state khi vuốt
                        itemBuilder: (context, index) {
                          final page = cubit.pages[index];
                          return _buildPage(
                              page.title, page.description, page.image);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        cubit.pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: state == index ? Colors.blue : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                        title: state < cubit.pages.length - 1
                            ? AppStrings.next
                            : AppStrings.start,
                        onPressed: () => cubit.nextPage(context),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String title, String description, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 400),
          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
