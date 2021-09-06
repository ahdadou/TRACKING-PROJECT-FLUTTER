import 'package:delivery/screens/home/home_screen.dart';
import 'package:delivery/screens/profile/profile_screen.dart';
import 'package:delivery/services/repositories/trackingRepository.dart';
import 'package:delivery/shared/models/tracking.dart';
import 'package:delivery/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:delivery/services/repositories/trackingRepository.dart'
    as trackRepository;

class Panelwidget extends StatefulWidget {
  const Panelwidget(
      {Key key, this.controller, this.functionON, this.functionOFF})
      : super(key: key);
  final ScrollController controller;
  final Function functionON;
  final Function functionOFF;
  @override
  _PanelwidgetState createState() => _PanelwidgetState();
}

class _PanelwidgetState extends State<Panelwidget> {
  bool _isSelected = false;
  bool isActive = false;
  Tracking _tracking;
  var myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tracking$.stream.listen((event) {
      if (this.mounted) setState(() {});
      this._tracking = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: [generateCode(), trackingCode()],
    );
  }

  Widget generateCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "ACTIVE YOUR TRACKING CODE",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              FlutterSwitch(
                activeColor: kPrimaryColor,
                width: 60.0,
                height: 30.0,
                valueFontSize: 13.0,
                toggleSize: 25.0,
                value: _isSelected,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  if (val)
                    widget.functionON();
                  else
                    widget.functionOFF();

                  setState(() {
                    _isSelected = val;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: _tracking.uuid));
                          },
                          icon: Icon(
                            Icons.copy,
                            color: Colors.grey,
                          )),
                      if (_isSelected)
                        Text(_tracking != null ? _tracking.uuid : '')
                      else
                        Text("****-****-****-****"),
                    ],
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {
                      trackRepository.updateTrackingUUID();
                    },
                    icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kPrimaryColor),
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ))),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget trackingCode() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 20, top: 10, bottom: 10),
      child: Column(
        children: [
          Text(
            "USE UUID FOR TRACKING A USER",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: new TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      hintText: "New message...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none),
                ),
              ),
              FlutterSwitch(
                activeColor: kPrimaryColor,
                width: 60.0,
                height: 30.0,
                valueFontSize: 13.0,
                toggleSize: 25.0,
                value: isActive,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  if (val) {
                    uuid$.add(myController.text);
                    stompClientTrack.activate();
                  } else
                    stompClientTrack.deactivate();

                  setState(() {
                    isActive = val;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
