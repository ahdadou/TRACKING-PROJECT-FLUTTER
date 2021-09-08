import 'package:csc_picker/csc_picker.dart';
import 'package:delivery/screens/profile/profile_screen.dart';
import 'package:delivery/services/blocs/delivery/delivery_bloc.dart';
import 'package:delivery/shared/fakeData.dart';
import 'package:flutter/material.dart';
import 'package:delivery/shared/utils/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String countryValue;
  String stateValue;

  @override
  Widget build(BuildContext context) {
    var myController = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: BlocBuilder<DeliveryBloc, DeliveryState>(
        builder: (context, state) {
          if (state is FetchDeliveriesSuccessState) {
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: context.height),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // cityPicker(),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    height: 40,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        color: Colors.grey.withOpacity(0.3)),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/search.svg",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                          child: TextField(
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                height: 2.0,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText:
                                                  "Searcg By City,Email...",
                                            ),
                                            controller: myController,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Center(
                                      child: IconButton(
                                          onPressed: () {
                                            BlocProvider.of<DeliveryBloc>(
                                                    context)
                                                .add(fetchDeliveryByCityOrEmail(
                                                    param: myController.text));
                                          },
                                          icon: Icon(Icons.filter_alt_rounded)),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 12,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                                children: List.generate(
                                    state.userResponseList.length, (index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //     context, ProfileScreen.routeName);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfileScreen(
                                                userResponse: state
                                                    .userResponseList[index],
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 2),
                                  height: 70,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Colors.grey
                                                  .withOpacity(0.2)))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    state
                                                            .userResponseList[
                                                                index]
                                                            .image ??
                                                        users[index].image,
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  state.userResponseList[index]
                                                          .compteVerifie
                                                      ? Positioned(
                                                          bottom: 5,
                                                          right: 5,
                                                          child: Container(
                                                            width: 15,
                                                            height: 15,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .blue[600]),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.check,
                                                                size: 15,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ))
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.userResponseList[index]
                                                          .firstname +
                                                      ' ' +
                                                      state
                                                          .userResponseList[
                                                              index]
                                                          .lastname,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: RatingBarIndicator(
                                                        rating: state
                                                            .userResponseList[
                                                                index]
                                                            .ratingAverage
                                                            .floorToDouble(),
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        itemCount: 5,
                                                        itemSize: 20.0,
                                                        unratedColor: Colors
                                                            .amber
                                                            .withAlpha(50),
                                                        direction:
                                                            Axis.horizontal,
                                                      ),
                                                    ),
                                                    Text(
                                                      "(" +
                                                          state
                                                              .userResponseList[
                                                                  index]
                                                              .reviewCount
                                                              .toString() +
                                                          " reviews)",
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(state
                                                            .userResponseList[
                                                                index]
                                                            .city ??
                                                        '')
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }))),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is DeliveryLoadingState) {
            return Container(
              width: context.width,
              height: context.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container(
              width: context.width,
              height: context.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Container cityPicker() {
    return Container(
        width: 300,
        child: Column(
          children: [
            ///Adding CSC Picker Widget in app
            CSCPicker(
              ///Enable disable state dropdown [OPTIONAL PARAMETER]
              showStates: false,

              /// Enable disable city drop down [OPTIONAL PARAMETER]
              showCities: false,

              ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
              flagState: CountryFlag.ENABLE,

              ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
              dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),

              ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
              disabledDropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),

              ///Default Country
              defaultCountry: DefaultCountry.Morocco,

              ///selected item style [OPTIONAL PARAMETER]
              selectedItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              ///DropdownDialog Heading style [OPTIONAL PARAMETER]
              dropdownHeadingStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),

              ///DropdownDialog Item style [OPTIONAL PARAMETER]
              dropdownItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              ///Dialog box radius [OPTIONAL PARAMETER]
              dropdownDialogRadius: 10.0,

              ///Search bar radius [OPTIONAL PARAMETER]
              searchBarRadius: 10.0,

              ///triggers once country selected in dropdown
              onCountryChanged: (value) {
                setState(() {
                  ///store value in country variable
                  countryValue = value;
                });
              },

              ///triggers once state selected in dropdown
              onStateChanged: (value) {
                setState(() {
                  ///store value in state variable
                  stateValue = value;
                });
              },

              // ///triggers once city selected in dropdown
              onCityChanged: (value) {
                setState(() {
                  ///store value in city variable
                  // cityValue = value;
                });
              },
            ),
          ],
        ));
  }
}
