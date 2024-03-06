import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class SubmitMatchForm extends StatefulWidget {
  final Function()? onTap;
  const SubmitMatchForm({super.key, required this.onTap});

  @override
  State<SubmitMatchForm> createState() => _SubmitMatchFormState();
}

class _SubmitMatchFormState extends State<SubmitMatchForm> {

  var setsController = TextEditingController(text: '2');


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _playersCard(),
          const SizedBox(height: 5),
          _matchDetailsCard(setsController, int.parse(setsController.text)),
          MyButton(
            onTap: () {},
            text: 'Submit',
          ),
        ],
      ),
    );
  }
}

_playersCard() {


  return Card(
    child: ListTile(
      title: const Text('Players'),
      subtitle: Column(
        children: [
          MyTextField(
            controller: TextEditingController(),
            hintText: 'Player',
            obscureText: false,
          ),
          const SizedBox(height: 5),
          MyTextField(
            controller: TextEditingController(),
            hintText: 'Player',
            obscureText: false,
          ),
          const Center(child: Text("VS")),
          MyTextField(
            controller: TextEditingController(),
            hintText: 'Club',
            obscureText: false,
          ),
          const SizedBox(height: 5),
          MyTextField(
            controller: TextEditingController(),
            hintText: 'Player',
            obscureText: false,
          ),
        ],
      ),
    ),
  );
}

_matchDetailsCard(TextEditingController setsController, int sets) {
  return Card(
    child: ListTile(
      title: Text('Match Details'),
      subtitle: Column(
        children: [
          MyTextField(
            controller: TextEditingController(),
            hintText: 'Club',
            obscureText: false,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: MyTextField(
                  controller: TextEditingController(),
                  hintText: 'Date',
                  obscureText: false,
                ),
              ),
              Expanded(
                child: MyTextField(
                  controller: TextEditingController(),
                  hintText: 'Time',
                  obscureText: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextField(
            controller: setsController,

            obscureText: false,
          ),

          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('My Team'),
                    const SizedBox(height: 5),
                    Text('Other Team'),
                  ],
                ),
              ),
              for(var i = 1; i <= sets; i++)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Set ${setsController.text}'),
                    MyTextField(
                      controller: TextEditingController(),
                      hintText: 'Wins',
                      obscureText: false,
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      controller: TextEditingController(),
                      hintText: 'Losses',
                      obscureText: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
