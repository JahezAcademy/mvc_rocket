import 'package:flutter/material.dart';
import 'package:mc/mc.dart';

class MiniView extends StatelessWidget {
  MiniView({required this.title});
  final String title;
  final McValue<String> mcString = "Initial value".mini;
  final McValue<int> mcNum = 5.mini;
  final McValue<List> mcList = [].mini;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("use View for every value"),
            McMV(mcString, () => Text(mcString.v)),
            McMV(
              mcNum,
              () => Text(mcNum.v.toString() +
                  (mcNum.v.toString() == "11"
                      ? " click to remove listener"
                      : "")),
            ),
            McMV(
              mcList,
              () {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemCount: mcList.v.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(child: Text(mcList.v[index].toString()));
                      },
                    ));
              },
            ),
            const SizedBox(
              height: 60.0,
            ),
            Text("merge multiple values"),
            McMV(
              McValue.merge([mcString, mcNum, mcList]),
              () => Wrap(
                runAlignment: WrapAlignment.center,
                children: [
                  Text(mcString.v),
                  Text("=>"),
                  Text(mcNum.v.toString()),
                  Text("=>"),
                  Text(mcList.v.toString())
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          mcNum.v++;
          mcString.v = "Value Changed";
          // dont use methods for add items or remove it use instead of it +/-
          mcList.v += [mcNum.v, mcString.v];
          if (mcNum.v == 6) {
            mcNum.registerListener(McValue.miniRebuild, valChanged);
            mcNum.registerListener(McValue.mergesRebuild, () {
              print(
                  'this listener called when widget of merges values rebuild');
            });
          }
          if (mcNum.v == 12) {
            mcNum.removeListener(McValue.miniRebuild, valChanged);
            print("listener removed!!!");
          }
        },
        tooltip: 'change Value',
        child: Icon(Icons.change_circle),
      ),
    );
  }

  valChanged() {
    print('this listener called when widget of mcNum rebuild');
  }
}

// class McMiniViewExample extends StatelessWidget {
//   // use mini for convert value to McValue
//   final McValue<String> myStringValue = "My Value".mini;
//   final McValue<int> myIntValue = 2021.mini;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         //use your value in McMV and if value changed will rebuild widget for show your new value
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // use McValue for every widget
//             McMV(myStringValue, () => Text(myStringValue.v)),
//             McMV(myStringValue, () => Text(myIntValue.v.toString())),
//             const SizedBox(
//               height: 25.0,
//             ),
//             // merge multi MCValue in one widget
//             McMV(McValue.merge([myStringValue, myIntValue]), () {
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(myStringValue.v),
//                   Text(myIntValue.v.toString())
//                 ],
//               );
//             })
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         onPressed: () {
//           // change value
//           myStringValue.v = "Value Changed";
//           myIntValue.v = 2022;
//         },
//         tooltip: 'change Value',
//         child: Icon(Icons.change_circle),
//       ),
//     );
//   }
// }
