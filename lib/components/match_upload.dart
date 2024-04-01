import 'package:flutter/material.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:my_rating_app_mobile/components/my_button.dart';
import 'package:my_rating_app_mobile/components/search_player_delegate.dart';

import '../domain/player.dart';
import '../util/string_utils.dart';
import 'flash_message.dart';


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
    if ({_myParter?.email, _opponent1?.email, _opponent2?.email}.length != 3) {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        constraints: const BoxConstraints(minHeight: 350, maxHeight: 350),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          border: const Border(
            left: BorderSide(
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
                        width: 25,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            _playerAvatar(
                                widget.loggedPlayer.photoUrl,
                                widget.loggedPlayer.displayName,
                                () {},
                                Colors.red,
                                context),
                            _playerAvatar(
                                _myParter?.photoUrl,
                                _myParter?.displayName,
                                (value) => setState(() {
                                      _myParter = value;
                                    }),
                                Colors.yellow,
                                context)
                          ],
                        ),
                      ),
                      const Text('VS', style: TextStyle(fontSize: 30)),
                      Expanded(
                        child: Row(
                          children: [
                            _playerAvatar(
                                _opponent1?.photoUrl,
                                _opponent1?.displayName,
                                (value) => setState(() {
                                      _opponent1 = value;
                                    }),
                                Colors.green,
                                context),
                            _playerAvatar(
                                _opponent2?.photoUrl,
                                _opponent2?.displayName,
                                (value) => setState(() {
                                      _opponent2 = value;
                                    }),
                                Colors.orange,
                                context)
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                  const SizedBox(
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
                            const Text('SETS'),
                            Expanded(
                                child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      inactiveTrackColor:
                                          const Color(0xFF8D8E98),
                                      activeTrackColor: Colors.blue,
                                      thumbColor: const Color(0xffdbff08),
                                      overlayColor: const Color(0x29EB1555),
                                      thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 15.0),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
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
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              height: 40,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  '${shortenName(widget.loggedPlayer.displayName) ?? shortenName(widget.loggedPlayer.email)} / ${shortenName(_myParter?.displayName) ?? '?'}')),
                          const SizedBox(
                            width: 150,
                            child: Divider(),
                          ),
                          Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              // decoration: BoxDecoration(color: Colors.red.shade200),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  '${shortenName(_opponent1?.displayName) ?? '?'} / ${shortenName(_opponent2?.displayName) ?? '?'}')),
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
                                        contentPadding:
                                            const EdgeInsets.all(5.0),
                                        border: const OutlineInputBorder(),
                                      ),
                                    )),
                                const SizedBox(
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
                                        contentPadding:
                                            const EdgeInsets.all(5.0),
                                        border: const OutlineInputBorder(),
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
                          horizontal: 20, vertical: 10),
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

                  // Expanded(child: Match())
                ])),
      ),
    );
  }
}

_playerAvatar(
    String? photoUrl, String? name, Function onPlayerSelect, Color backgroundColor,  context) {
  return Expanded(
      child: GestureDetector(
          onTap: () async {
            await showSearch(
              context: context,
              delegate: SearchPlayer(callback: onPlayerSelect),
            );
          },
          child: CircleAvatar(
            backgroundColor: name == null ? Colors.grey.shade300 : backgroundColor,
            minRadius: 25,
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
            child: photoUrl == null ? Text( nameInitials(name) ?? '') : null,
          )));
}