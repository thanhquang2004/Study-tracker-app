import 'package:equatable/equatable.dart';
import 'package:study_tracker_mobile/presentation/setting/model/setting_model.dart';

class SettingState extends Equatable {
  final List<SettingModel> settings;

  const SettingState({this.settings = const []});

  SettingState copyWith({List<SettingModel>? settings}) {
    return SettingState(
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object> get props => [settings];
}
