import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/home%20screen/bloc/home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _homeScreenBloc = HomeScreenBloc();

  final List<String> appBar = ['Home', 'Student List', 'Profile'];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeScreenBloc.add(HomeScreenInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      bloc: _homeScreenBloc,
      listenWhen: (previous, current) => current is HomeScreenActionState,
      buildWhen: (previous, current) => current is! HomeScreenActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(appBar[selectedIndex])),
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  DrawerHeader(child: Text("Hello!")),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log Out'),
                    onTap: () => _homeScreenBloc.add(HomeScreenLogOutEvent()),
                  ),
                ],
              ),
            ),
          ),
          body: () {
            if (state is HomeScreenLoadingState) {
              return CircularProgressIndicator(color: Color(0xFFA12F2F));
            } else if (selectedIndex == 0) {
            } else if (selectedIndex == 1) {
            } else if (selectedIndex == 2) {}
          }(),
        );
      },
    );
  }
}
