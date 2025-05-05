import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/home/bloc/home_bloc.dart';
import 'package:smart_tuition_tracker/features/home/ui/student_tile.dart';
import 'package:smart_tuition_tracker/models/user.dart';
import 'package:dotted_border/dotted_border.dart';

class Home extends StatefulWidget {
  final UserInformation info;
  const Home({super.key, required this.info});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _homeBloc.add(HomeInitialEvent(role: widget.info.role));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Center(child: CircularProgressIndicator());
          case HomeLoadedTeacherState:
            return RefreshIndicator(
              color: Colors.black,
              onRefresh: () async {
                _homeBloc.add(HomeInitialEvent(role: 'Teacher'));
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'My Students',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap:
                          true, // Makes the ListView take only the space it needs
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          (state as HomeLoadedTeacherState).students.length,
                      itemBuilder: (context, index) {
                        return StudentTile(info: (state).students[index]);
                      },
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: DottedBorder(
                        dashPattern: [6, 3], // Dash length and gap
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        color: Colors.grey,
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.grey[100],
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  "Add New Student",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return const Center(child: Text("Unknown State"));
        }
      },
    );
  }
}
