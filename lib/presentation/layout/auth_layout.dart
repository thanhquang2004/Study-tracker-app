import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/presentation/resources/assets_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/font_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/strings_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';
import 'package:study_tracker_mobile/presentation/widget/custom_button.dart';

class AuthenticateLayout extends StatefulWidget {
  final String title;
  final List<Widget>? listTextField;
  final Widget? helpText;
  final VoidCallback? buttonSubmit;
  final Widget? otherButton;
  final String? errorText;
  final String prefixNavigateText;
  final String navigateText;
  final VoidCallback? navigate;
  final double? height;

  const AuthenticateLayout({
    super.key,
    required this.title,
    required this.listTextField,
    this.buttonSubmit,
    this.helpText,
    this.otherButton,
    required this.prefixNavigateText,
    required this.navigateText,
    this.navigate,
    this.errorText = "",
    this.height,
  });

  @override
  State<AuthenticateLayout> createState() => _AuthenticateLayoutState();
}

class _AuthenticateLayoutState extends State<AuthenticateLayout> {
  @override
  Widget build(BuildContext context) {
    final double? logoHeight =
        widget.height != null ? Constants.deviceHeight - widget.height! : null;
    return Scaffold(
      backgroundColor: XColors.neutral_8,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildLogo(height: logoHeight),
            _buildFormContainer(height: widget.height),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo({double? height}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s20),
      width: double.infinity,
      height: height ?? Constants.deviceHeight * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 0.01 * Constants.deviceHeight,
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: XColors.semanticShadowBox.withOpacity(0.02),
                blurRadius: 14,
                offset: const Offset(0, 0),
              ),
              BoxShadow(
                color: XColors.semanticShadowBox.withOpacity(0.02),
                blurRadius: 44,
                offset: const Offset(0, 10),
              ),
            ]),
            child: SvgPicture.asset(
              ImageAssets.authLogo,
              fit: BoxFit.contain,
              height: 0.35 * (height ?? Constants.deviceHeight * 0.35),
            ),
          ),
          Align(
            child: Text(
              AppStrings.appName,
              style: getSemiBoldStyle(color: XColors.neutral_1, fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContainer({double? height}) {
    return Container(
      width: double.infinity,
      height: height ?? Constants.deviceHeight * 0.65,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.s20,
      ).copyWith(top: AppSize.s20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: XColors.neutral_7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: getBoldStyle(color: XColors.neutral_1, fontSize: 21),
          ),
          const SizedBox(height: AppSize.s8),
          if (widget.listTextField!.isNotEmpty) ...widget.listTextField!,
          if (widget.errorText!.isNotEmpty) _buildErrorText(),
          if (widget.helpText != null) _buildHelpText(),
          const SizedBox(height: AppSize.s16),
          CustomButton(
            title: widget.title,
            onPressed: widget.buttonSubmit,
            fontSize: FontSize.s20,
            width: double.infinity,
          ),
          if (widget.otherButton != null) widget.otherButton!,
          _buildNavigationText(),
        ],
      ),
    );
  }

  Widget _buildErrorText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s8),
      child: Text(
        widget.errorText!,
        style: getRegularStyle(color: XColors.semanticError, fontSize: 16),
      ),
    );
  }

  Widget _buildHelpText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
      child: widget.helpText,
    );
  }

  Widget _buildNavigationText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.prefixNavigateText,
            style: getRegularStyle(color: XColors.neutral_1, fontSize: 12),
          ),
          CustomButton(
            width: 0,
            title: widget.navigateText,
            onPressed: widget.navigate,
            fontSize: FontSize.s12,
            type: ButtonType.text,
            enableSplash: false,
          ),
        ],
      ),
    );
  }
}
