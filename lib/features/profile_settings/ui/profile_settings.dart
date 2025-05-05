import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/profile_settings/bloc/profile_settings_bloc.dart';
import 'package:smart_tuition_tracker/features/wrapper/ui/wrapper.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final ProfileSettingsBloc _profileSettingsBloc = ProfileSettingsBloc();
  @override
  void initState() {
    super.initState();
    _profileSettingsBloc.add(ProfileSettingsInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileSettingsBloc, ProfileSettingsState>(
        bloc: _profileSettingsBloc,
        listenWhen:
            (previous, current) => current is ProfileSettingsActionState,
        buildWhen:
            (previous, current) => current is! ProfileSettingsActionState,
        listener: (context, state) {
          if (state is ProfileSettingsLogOutSuccessState) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Wrapper()),
              (_) => false,
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProfileSettingsLoadedState:
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    _profileSettingsBloc.add(ProfileSettingsLogOutEvent());
                  },
                  child: Text('Log Out'),
                ),
              );
            default:
              return Center(child: Text('Unknown State'));
          }
        },
      ),
    );
  }
}
