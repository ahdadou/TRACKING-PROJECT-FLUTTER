import 'package:delivery/screens/profile/home.dart';
import 'package:delivery/services/blocs/review/review_bloc.dart';
import 'package:delivery/shared/models/UserResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  final UserResponse userResponse;

  const ProfileScreen({Key key, this.userResponse}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocProvider(
        create: (context) => ReviewBloc()..add(fetchUserReviews(email: widget.userResponse.email)),
        child: Home(
          userResponse: widget.userResponse,
        ),
      ),
    );
  }

  getAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios))
          ],
        ),
      ),
    );
  }
}
