import 'package:flutter/material.dart';
import 'package:madlayoutassignmentpart2/components/my_flutter_app_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Living room'),
                      Tab(text: 'Bedroom')
                    ],
                  ),
                  title: Text('IoT'),
                ),
                body: TabBarView(children: [
                  GridView.count(
                    // Create grid for the items
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    // list items
                    children: List.generate(Switches.length, (index) {
                      return Center(
                        child: SwitchCards(switchControl: Switches[index]),
                      );
                    }),
                  ),
                  GridView.count(
                    // Create grid for the items
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    // list items
                    children: List.generate(
                        Switches.where((i) => i.room.contains('living room'))
                            .length, (index) {
                      return Center(
                        child: SwitchCards(
                            switchControl: Switches.where(
                                    (i) => i.room.contains('living room'))
                                .elementAt(index)),
                      );
                    }),
                  ),
                  GridView.count(
                      // Create grid for the items
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      // list items
                      children: List.generate(
                          Switches.where((i) => i.room.contains('bedroom'))
                              .length, (index) {
                        return Center(
                          child: SwitchCards(
                              switchControl: Switches.where(
                                      (i) => i.room.contains('bedroom'))
                                  .elementAt(index)),
                        );
                      }))
                ]))));
  }
}

class SwitchControl {
  final String title;
  final IconData switchOn;
  final IconData switchOf;
  final String room;
  const SwitchControl(
      {required this.title,
      required this.switchOn,
      required this.switchOf,
      required this.room});
}

const List<SwitchControl> Switches = const <SwitchControl>[
  const SwitchControl(
      title: 'PlugAmmar',
      switchOn: MyFlutterApp.plug,
      switchOf: MyFlutterApp.unplugged,
      room: 'living room'),
  const SwitchControl(
      title: 'Bilik Hana',
      switchOn: MyFlutterApp.window,
      switchOf: MyFlutterApp.cancel,
      room: 'bedroom'),
  const SwitchControl(
      title: 'Gate Light',
      switchOn: MyFlutterApp.lightbulb,
      switchOf: MyFlutterApp.lamp,
      room: 'living room'),
  const SwitchControl(
      title: 'Plug 3 Patio',
      switchOn: MyFlutterApp.plug,
      switchOf: MyFlutterApp.unplugged,
      room: 'bedroom'),
  const SwitchControl(
      title: 'Parking Lights',
      switchOn: MyFlutterApp.lightbulb,
      switchOf: MyFlutterApp.lamp,
      room: 'living room'),
  const SwitchControl(
      title: 'laptop',
      switchOn: MyFlutterApp.laptop_phone,
      switchOf: MyFlutterApp.phonelink_off,
      room: 'living room')
];

//statefulWidget
class SwitchCards extends StatefulWidget {
  const SwitchCards({Key? key, required this.switchControl}) : super(key: key);
  final SwitchControl switchControl;

  @override
  _SwitchCardsState createState() => _SwitchCardsState();
}

//state
class _SwitchCardsState extends State<SwitchCards> {
  var currentIcon;
  var switchIcon = Icon(Icons.toggle_off_outlined);
  bool isSwitched = false;
  var powerState = "OFF";
  Color stateColor = Colors.red;

  @override
  void initState() {
    super.initState();
    currentIcon = widget.switchControl.switchOf;
  }

  void toggleSwitch() {
    if (isSwitched == false) {
      setState(() {
        switchIcon = Icon(Icons.toggle_on_outlined);
        currentIcon = widget.switchControl.switchOn;
        powerState = "ON";
        isSwitched = true;
        stateColor = Colors.green;
      });
    } else {
      setState(() {
        switchIcon = Icon(Icons.toggle_off_outlined);
        currentIcon = widget.switchControl.switchOf;
        powerState = "OFF";
        isSwitched = false;
        stateColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(children: <Widget>[
            Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(currentIcon, size: 30, color: Colors.blue),
                    Text(widget.switchControl.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    // Text(widget.switchControl.room, style: TextStyle(fontSize: 15, color: Colors.black54)),
                    Expanded(
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(powerState,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: stateColor))))
                  ],
                )),
            Expanded(
                flex: 4,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: switchIcon,
                          onPressed: toggleSwitch,
                          iconSize: 30,
                          color: Colors.blue)
                    ])),
            //Spacer(),
          ])),
    );
  }
}
