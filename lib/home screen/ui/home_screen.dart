import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/home/ui/home.dart';
import 'package:smart_tuition_tracker/home%20screen/bloc/home_screen_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenBloc _homeScreenBloc = HomeScreenBloc();

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
        if (state is HomeScreenLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFFA12F2F)),
          );
        }
        if (state is HomeScreenLoadedState) {
          final userData = state.data;
          return Scaffold(
            appBar: AppBar(title: Text(appBar[selectedIndex])),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: const Color(0xFFA12F2F)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                            'https://robohash.org/${userData.name}.png?set=set1',
                          ),
                        ),
                        Divider(thickness: 1),
                        Text(
                          '${userData.name} - ${userData.role}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          userData.email,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log Out'),
                    onTap: () => _homeScreenBloc.add(HomeScreenLogOutEvent()),
                  ),
                ],
              ),
            ),
            body: () {
              if (selectedIndex == 0) {
                return Home();
              } else if (selectedIndex == 1) {
                return Center(child: Text('Student List Screen'));
              } else if (selectedIndex == 2) {
                return Center(child: Text('Profile Screen'));
              }
              return Container();
            }(),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Student List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: const Color(0xFFA12F2F),
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
