import 'package:flutter/material.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:my_rating_app_mobile/components/my_button.dart';
import 'package:my_rating_app_mobile/components/search_player_delegate.dart';

import '../domain/player.dart';

class MatchUpload extends StatefulWidget {
  final loggedPlayer;

  const MatchUpload({
    Key? key,
    this.color = const Color(0xFFFFE306),
    this.child,
    required this.loggedPlayer,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  @override
  State<MatchUpload> createState() => _MatchUploadState();
}

class _MatchUploadState extends State<MatchUpload> {
  int _sets = 1;
  final List<TextEditingController> _team1Results = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final List<TextEditingController> _team2Results = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  Player? _myParter;
  Player? _opponent1;
  Player? _opponent2;
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  void setPlayer(Player player, Player? spot) {
    setState(() {
      spot = player;
    });
  }

  void updateSets(int value) {
    setState(() {
      _sets = value;
    });
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showIntervalTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      interval: 15,
      visibleStep: VisibleStep.fifteenths,
    );

    if (picked != null) {
      setState(() {
        _timeController.text =
            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void updateTeam1Results(int set, String value) {
    setState(() {
      _team1Results[set].text = value;
    });
  }

  void updateTeam2Results(int set, String value) {
    _team2Results[set].text = value;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        constraints: const BoxConstraints(minHeight: 350, maxHeight: 350),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          border: Border(
            left: BorderSide(
                color: Colors.blueAccent, width: 5.0, style: BorderStyle.solid),
          ),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            _playerAvatar(
                                widget.loggedPlayer.photoUrl,
                                widget.loggedPlayer.displayName,
                                () {},
                                context),
                            _playerAvatar(
                                _myParter?.photoUrl,
                                _myParter?.displayName,
                                (value) => setState(() {
                                      _myParter = value;
                                    }),
                                context)
                          ],
                        ),
                      ),
                      const Text('VS', style: TextStyle(fontSize: 30)),
                      Expanded(
                        child: Row(
                          children: [
                            _playerAvatar(_opponent1?.photoUrl, _opponent1?.displayName,
                                    (value) => setState(() {
                                  _opponent1 = value;
                                }), context),
                            _playerAvatar(_opponent2?.photoUrl, _opponent2?.displayName,
                                    (value) => setState(() {
                                  _opponent2 = value;
                                }), context)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _dateController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              hintText: 'Date',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: Colors.grey,
                              ),
                            ),
                            readOnly: true,
                            onTap: _selectDate,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _timeController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              hintText: 'Time',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.timelapse,
                                color: Colors.grey,
                              ),
                            ),
                            readOnly: true,
                            onTap: _selectTime,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Text('SETS'),
                            Expanded(
                                child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      inactiveTrackColor: Color(0xFF8D8E98),
                                      activeTrackColor: Colors.blue,
                                      thumbColor: Color(0xffdbff08),
                                      overlayColor: Color(0x29EB1555),
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 15.0),
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 30.0),
                                    ),
                                    child: Slider(
                                      value: _sets.toDouble(),
                                      min: 1,
                                      max: 3,
                                      divisions: 2,
                                      label: _sets.round().toString(),
                                      onChanged: (double value) {
                                        setState(() {
                                          _sets = value.toInt();
                                        });
                                      },
                                    ))),
                          ],
                        )),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              // decoration: BoxDecoration(color: Colors.red.shade200),
                              padding: EdgeInsets.symmetric(vertical: 5),
                              height: 40,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  '${_shortenName(widget.loggedPlayer.displayName) ?? widget.loggedPlayer.email} / ${_shortenName("Rachel Ashby")}')),
                          SizedBox(
                            width: 150,
                            child: Divider(),
                          ),
                          Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              // decoration: BoxDecoration(color: Colors.red.shade200),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  '${_shortenName("Tomafasfas Woods") ?? widget.loggedPlayer.email ?? '?'} / ${_shortenName("Megan fsafsafJamieson")}')),
                        ],
                      ),
                      for (int set = 0; set < _sets; set++)
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: Text('${_toOrdinal(set + 1)}'),
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: _team1Results[set],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) =>
                                          {updateTeam1Results(set, value)},
                                      decoration: InputDecoration(
                                        filled: true,
                                        isDense: true,
                                        fillColor: Colors.grey.shade200,
                                        contentPadding: EdgeInsets.all(5.0),
                                        border: OutlineInputBorder(),
                                      ),
                                    )),
                                SizedBox(
                                  width: 50,
                                  child: Divider(),
                                ),
                                // Divider(),
                                SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: _team2Results[set],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) =>
                                          {updateTeam2Results(set, value)},
                                      decoration: InputDecoration(
                                        filled: true,
                                        isDense: true,
                                        fillColor: Colors.grey.shade200,
                                        contentPadding: EdgeInsets.all(5.0),
                                        border: OutlineInputBorder(),
                                      ),
                                    )),
                              ],
                            )
                          ],
                        )
                    ],
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: MyButton(onTap: () {}, text: 'Submit')),

                  // Expanded(child: Match())
                ])),
      ),
    );
  }
}

_playerAvatar(
    String? photoUrl, String? name, Function onPlayerSelect, context) {
  return Expanded(
      child: GestureDetector(
          onTap: () async {
            await showSearch(
              context: context,
              delegate: SearchPlayer(callback: onPlayerSelect),
            );
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            minRadius: 25,
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
            child: photoUrl == null ? Text(_nameInitials(name) ?? '') : null,
          )));
}

String? _shortenName(String? name) {
  return name?.split(" ").reduce((value, element) => '$value ${element[0]}.');
}

String? _nameInitials(String? name) {
  return name
      ?.split(" ")
      .reduce((value, element) => '${value[0]}${element[0]}');
}

String _toOrdinal(int number) {
  if (number < 0) throw Exception('Invalid Number');

  switch (number % 10) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}
