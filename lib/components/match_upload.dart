import 'package:flutter/material.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:my_rating_app_mobile/components/my_button.dart';
import 'package:my_rating_app_mobile/components/search_player_delegate.dart';

import '../domain/player.dart';
import '../util/string_utils.dart';
import 'flash_message.dart';
import 'player_avatar.dart';

class MatchUpload extends StatefulWidget {
  final Player loggedPlayer;

  const MatchUpload({
    super.key,
    this.color = const Color(0xFFFFE306),
    this.child,
    required this.loggedPlayer,
  });

  final Color color;
  final Widget? child;

  @override
  State<MatchUpload> createState() => _MatchUploadState();
}

class _MatchUploadState extends State<MatchUpload> {
  int _sets = 1;
  Player? _myParter;
  Player? _opponent1;
  Player? _opponent2;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
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

  void clearForm() {
    setState(() {
      _sets = 1;
      _myParter = null;
      _opponent1 = null;
      _opponent2 = null;
      _dateController.clear();
      _timeController.clear();

      for (var e in _team1Results) {
        e.clear();
      }
      for (var e in _team2Results) {
        e.clear();
      }
    });
  }

  String? get _errorText {
    if ({_myParter?.id, _opponent1?.id, _opponent2?.id}.length != 3) {
      return 'All 4 players must be selected';
    }
    if (_dateController.text == '' || _timeController.text == '') {
      return 'Date and time must be selected';
    }

    if (_dateController.text == '' || _timeController.text == '') {
      return 'Date and time must be selected';
    }

    for (int set = 0; set < _sets; set++) {
      if (_team1Results[set].text == '' || _team2Results[set].text == '') {
        return 'All sets must be filled';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          child: const Text('Upload a match',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 320),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.green,
                  offset: Offset(
                    50.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 20.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.red,
                  offset: Offset(60.0, 60.0),
                  blurRadius: 20.0,
                  spreadRadius: 30.0,
                ),
              ],
              border: Border(
                top: BorderSide(
                    color: Colors.blueAccent, width: 5.0, style: BorderStyle.solid),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                _playerAvatar(widget.loggedPlayer.name, () {},
                                    Colors.blue.shade300, context),
                                _playerAvatar(
                                    _myParter?.name,
                                    (value) => setState(() {
                                          _myParter = value;
                                        }),
                                    Colors.blue.shade300,
                                    context)
                              ],
                            ),
                          ),
                          const Text('VS', style: TextStyle(fontSize: 15)),
                          Expanded(
                            child: Row(
                              children: [
                                _playerAvatar(
                                    _opponent1?.name,
                                    (value) => setState(() => _opponent1 = value),
                                    Colors.red.shade300,
                                    context),
                                _playerAvatar(
                                    _opponent2?.name,
                                    (value) => setState(() => _opponent2 = value),
                                    Colors.red.shade300,
                                    context)
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          )
                        ],
                      ),
                      const SizedBox(
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
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintText: 'Date',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
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
                          const SizedBox(
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
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintText: 'Time',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
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
                      Expanded(
                        child: Row(
                          children: [
                            const Text('SETS'),
                            Expanded(
                                child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      inactiveTrackColor: const Color(0xFF8D8E98),
                                      activeTrackColor: Colors.blue,
                                      thumbColor: const Color(0xffdbff08),
                                      overlayColor: Colors.blue.shade100,
                                      thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 15.0),
                                      overlayShape: const RoundSliderOverlayShape(
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
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  height: 30,
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      '${shortenName(widget.loggedPlayer.name)} / ${shortenName(_myParter?.name) ?? '?'}')),
                              const SizedBox(
                                width: 150,
                                child: Divider(),
                              ),
                              Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      '${shortenName(_opponent1?.name) ?? '?'} / ${shortenName(_opponent2?.name) ?? '?'}')),
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
                                      child: Text(toOrdinal(set + 1)),
                                    ),
                                    SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: TextField(
                                          style: const TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                          controller: _team1Results[set],
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) =>
                                              {updateTeam1Results(set, value)},
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.all(3.0),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey, width: 0.5),
                                            ),
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 50,
                                      child: Divider(),
                                    ),
                                    // Divider(),
                                    SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: TextField(
                                          style: const TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                          controller: _team2Results[set],
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) =>
                                              {updateTeam2Results(set, value)},
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(3.0),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey, width: 0.5),
                                            ),
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: MyButton(
                              onTap: () {
                                if (_errorText == null) {
                                  showFlashMessage(context, 'Match Uploaded',
                                      MessageType.success);
                                  clearForm();
                                } else {
                                  showFlashMessage(
                                      context, _errorText!, MessageType.error);
                                }
                              },
                              text: 'Submit')),
                    ])),
          ),
        ),
      ],
    );
  }
}

_playerAvatar(
    String? name, Function onPlayerSelect, Color backgroundColor, context) {
  return Expanded(
      child: GestureDetector(
          onTap: () async {
            await showSearch(
              context: context,
              delegate: SearchPlayer(callback: onPlayerSelect),
            );
          },
          child: PlayerAvatar(name: name, backgroundColor: backgroundColor)));
}
