import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTitle extends StatelessWidget {
  String text;
  ShimmerTitle({this.text});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.orangeAccent,
      enabled: true,
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Text(text, style: Theme.of(context).textTheme.headline6),
          // Text(" الرَّحْمَـٰنِ الرَّحِيمِِ",
          //     style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }
}

// expandedCard({num, englishName, content, name}) {
//   return ExpansionCard(
//     backgroundColor: Colors.transparent,
//     borderRadius: 20,
//     leading: Text(
//       "${num}",
//       style: Theme.of(context).textTheme.bodyText1,
//     ),
//     title: Container(
//       child: Column(
//         textDirection: TextDirection.rtl,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "$name",
//             style: TextStyle(
//               fontSize: 30,
//               color: Colors.white,
//             ),
//           ),
//           Text(
//             "${englishName}",
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//         ],
//       ),
//     ),
//     children: <Widget>[
//       Container(
//         color: Colors.transparent,
//         height: 300,
//         child: ListView.builder(
//             itemCount: content.length,
//             itemBuilder: (context, index) {
//               return Column(
//                 children: <Widget>[
//                   Text(
//                       "${content[1].textMadani}" + "   " + "${content[1].id}",
//                       style: TextStyle(fontSize: 20, color: Colors.white)),
//                 ],
//               );
//             }),
//       )
//     ],
//   );
// }
