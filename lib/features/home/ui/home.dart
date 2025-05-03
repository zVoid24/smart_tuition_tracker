import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/home/bloc/home_bloc.dart';
import 'package:smart_tuition_tracker/models/user.dart';

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
    _homeBloc.add(HomeInitialEvent());
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
          case HomeLoadedState:
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(widget.info.name),
                          Text(widget.info.role),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(15),
                          topEnd: Radius.circular(15),
                        ),
                        color: Colors.green,
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
