import 'package:delivery/screens/information/home.dart';
import 'package:delivery/services/blocs/updateData/updatedata_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoScreen extends StatelessWidget {
  static String routeName = "/info";
  const InfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UpdatedataBloc(), child: Home());
  }
}
