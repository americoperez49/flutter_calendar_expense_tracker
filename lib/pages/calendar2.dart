import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_expense_tracker/providers/google_provider.dart';
import 'package:provider/provider.dart';

class CalendarView2 extends StatelessWidget {
  CalendarView2({Key? key}) : super(key: key);

  AppBar _buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.amber,
      actions: [
        Consumer<GoogleProvider>(
            builder: (context, googleProvider, child) => IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => googleProvider.signOut())),
      ],
      title: Consumer<GoogleProvider>(
        builder: (context, googleProvider, child) => Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image.network(
              googleProvider.user!.photoUrl!,
              height: 35,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            googleProvider.user!.displayName!,
            style: const TextStyle(fontSize: 20),
          )
        ]),
      ),
    );
  }

  Widget numberOfWeeksInput(context) {
    var googleProvider = Provider.of<GoogleProvider>(context, listen: false);
    return Container(
        decoration: BoxDecoration(
            color: Colors.amber[400],
            borderRadius: BorderRadius.circular(16.0)),
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_month_rounded),
                label: Text("Weeks to Calculate")),
            onFieldSubmitted: (value) => {
                  if (value != "")
                    {googleProvider.getCalenderEvents(int.parse(value))}
                  else
                    googleProvider.reset()
                }));
  }

  Widget moneyInTheBankInput(context) {
    var googleProvider = Provider.of<GoogleProvider>(context);
    if (googleProvider.numberOfWeeks > 0) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.amber[400],
              borderRadius: BorderRadius.circular(16.0)),
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
                icon: Icon(Icons.attach_money),
                label: Text("Money in the Bank")),
            onFieldSubmitted: (value) => {},
          ));
    } else {
      return Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16.0)),
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              icon: Icon(Icons.attach_money),
              label: Text("Money in the Bank"),
            ),
            onFieldSubmitted: (value) => {},
            enabled: false,
          ));
    }
  }

  Widget _buildBody() {
    return Container(
        alignment: Alignment.center,
        child: Consumer<GoogleProvider>(
          builder: (context, googleProvider, child) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  numberOfWeeksInput(context),
                  const SizedBox(height: 6),
                  moneyInTheBankInput(context),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40), // NEW
                      ),
                      onPressed: googleProvider.numberOfWeeks > 0
                          ? () {
                              print('Submit');
                            }
                          : null,
                      child: const Text("Calculate")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40), // NEW
                      ),
                      onPressed: googleProvider.events!.isNotEmpty
                          ? () {
                              googleProvider.ToggleView();
                            }
                          : null,
                      child: Text(googleProvider.buttonText)),

                  Flexible(
                    child: Stack(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (googleProvider.events!.isNotEmpty) {
                              return Text(
                                  googleProvider.events![index].summary ?? "");
                            } else {
                              return Text("");
                            }
                          },
                          itemCount: googleProvider.events!.length,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        Visibility(
                          visible: googleProvider.gettingEvents ? true : false,
                          child: Center(
                              child: SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                              strokeWidth: 20,
                            ),
                          )),
                        )
                      ],
                    ),
                  )

                  // MyNumberInput(
                  //   myLabel: 'Money in the Bank',
                  //   myIcon: Icons.attach_money,
                  //   enabled: _moneyButtonEnabled,
                  // ),
                ],
              ),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody());
  }
}
