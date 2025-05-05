import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/home/ui/home.dart';
import 'package:smart_tuition_tracker/features/profile_settings/ui/profile_settings.dart';
import 'package:smart_tuition_tracker/features/schedule/ui/schedule.dart';
import 'package:smart_tuition_tracker/home%20screen/bloc/home_screen_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenBloc _homeScreenBloc = HomeScreenBloc();

  final List<String> appBar = ['Home', 'Inbox', 'Schedule', 'Profile'];
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
        if (state is HomeScreenNavigateToProfileSettingsState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileSettings()),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeScreenLoadingState) {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (state is HomeScreenLoadedState) {
          final userData = state.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(appBar[selectedIndex]),
              actions: [
                InkWell(onTap: () {}, child: Icon(Icons.notifications)),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    _homeScreenBloc.add(
                      HomeScreenNavigateToProfileSettingsEvent(),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://robohash.org/${userData.email}.png?set=set1',
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
            backgroundColor: const Color(0xFFF3F4F6),
            body: () {
              if (selectedIndex == 0) {
                return Home(info: userData);
              } else if (selectedIndex == 1) {
                return Center(child: Text('Inbox'));
              } else if (selectedIndex == 2) {
                return Schedule();
              } else if (selectedIndex == 3) {
                return Center(child: Text('Profile Screen'));
              }
              return Container();
            }(),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.messenger_rounded),
                  label: 'Inbox',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Schedule',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              backgroundColor: Colors.white,
              currentIndex: selectedIndex,
              //selectedItemColor: const Color(0xFFA12F2F),
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
            ),
          );
        }
        return Scaffold(body: Center(child: Text('Error: Invalid State')));
      },
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      selectedIndex = value;
    });
  }
}
