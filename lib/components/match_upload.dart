import 'package:flutter/material.dart';
import 'dart:math';
import 'package:interval_time_picker/interval_time_picker.dart';

class MatchUpload extends StatefulWidget {
  const MatchUpload({
    Key? key,
    this.color = const Color(0xFFFFE306),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  @override
  State<MatchUpload> createState() => _MatchUploadState();
}

class _MatchUploadState extends State<MatchUpload> {
  int _sets = 1;
  final List<int> _team1Results = [];
  final List<int> _team2Results = [];

  final TextEditingController _clubController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        alignment: Alignment.center,
        color: Colors.green.shade50,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                          children: [_playerAvatar(), _playerAvatar()],
                        ),
                      ),
                      const Text('VS', style: TextStyle(fontSize: 30)),
                      Expanded(
                        child: Row(
                          children: [_playerAvatar(), _playerAvatar()],
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
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: _clubController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'Club',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.house,
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (value) {},
                    ),
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
                      for (int i = 0; i <= _sets; i++)
                        _matchResult(
                          i,
                        ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                    },
                    child: Text('Submit'),
                  )

                  // Expanded(child: Match())
                ])),
      ),
    );
  }
}

_playerAvatar() {
  return Expanded(
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        minRadius: 25,
        backgroundImage:
        NetworkImage('https://i.pravatar.cc/300?img=${Random().nextInt(70)}'),
      ));
}

_matchResult(index) {
  return Row(
    children: [
      Visibility(
          visible: index != null && index == 0,
          child: Column(
            children: [
              Text(''),
              SizedBox(
                  height: 50,
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Nazareh T / Rachel A')))),
              SizedBox(
                // height: 50,
                // width: 200,
                child: Divider(),
              ),
              // Divider(),
              SizedBox(
                  height: 50,
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Tom W / Megan J')))),
            ],
          )),
      Visibility(
          visible: index > 0,
          child: Column(
            children: [
              Text('${toOrdinal(index)}'),
              SizedBox(
                  height: 30,
                  width: 30,
                  child: TextField(
                    onChanged: (value) => {},
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.all(20.0),
                      border: OutlineInputBorder(),
                    ),
                  )),
              SizedBox(
                // height: 50,
                width: 50,
                child: Divider(),
              ),
              // Divider(),
              SizedBox(
                  height: 30,
                  width: 30,
                  child: TextField(
                    onChanged: (value) => {},
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.all(20.0),
                      border: OutlineInputBorder(),
                    ),
                  )),
            ],
          ))
    ],
  );
}

String toOrdinal(int number) {
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
