import 'package:flutter/material.dart';
import 'package:flutter_calendar_expense_tracker/widgets/number_input.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class CalendarView extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final String? photoURL;
  final String? userName;
  const CalendarView(
      {Key? key, required this.googleSignIn, this.photoURL, this.userName})
      : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  bool _moneyButtonEnabled = false;
  BehaviorSubject<bool> $moneyButton = BehaviorSubject<bool>();
  late MyNumberInput input;

  @override
  void initState() {
    super.initState();
    input = MyNumberInput(
      myLabel: 'Weeks to Calculate',
      myIcon: Icons.calendar_month_rounded,
      enabled: true,
      $moneyButton: $moneyButton,
    );

    $moneyButton.listen((value) => {
          setState(() {
            _moneyButtonEnabled = value;
          })
        });
  }

  Future<void> _handleSignOut() async {
    await widget.googleSignIn.disconnect();
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.amber,
      actions: [
        IconButton(icon: const Icon(Icons.logout), onPressed: _handleSignOut),
      ],
      title: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Image.network(
            widget.photoURL!,
            height: 35,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          widget.userName!,
          style: const TextStyle(fontSize: 20),
        )
      ]),
    );
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.center,
      color: Colors.amber[700],
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          input,
          const SizedBox(height: 6),
          MyNumberInput(
            myLabel: 'Money in the Bank',
            myIcon: Icons.attach_money,
            enabled: _moneyButtonEnabled,
          ),
          ElevatedButton(onPressed: () => {}, child: const Text("CLick me"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }
}
