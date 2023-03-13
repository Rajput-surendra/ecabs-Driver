import 'package:animation_wrappers/animation_wrappers.dart';

// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcabs_driver/DrawerPages/Settings/theme_cubit.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/utils/Session.dart';

import '../../Theme/style.dart';

class InsightPage extends StatefulWidget {
  @override
  _InsightPageState createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  // late List<charts.Series<Ratings, String>> ratingsChart;
  // late List<charts.Series<Ratings, String>> earningsChart;

  List<Ratings> _earnings = [
    Ratings('10:00', '250', 250, Color(0xffFDB036)),
    Ratings('11:00', '150', 150, Color(0xffFDB036)),
    Ratings('12:00', '200', 200, Color(0xffFDB036)),
    Ratings('13:00', '170', 170, Color(0xffFDB036)),
    Ratings('14:00', '140', 140, Colors.white),
    Ratings('15:00', '140', 0, Colors.white),
    Ratings('16:00', '140', 0, Colors.white),
  ];

  List<Ratings> _ratings = [
    Ratings('5.0', '640', 64, Colors.green),
    Ratings('4.0', '210', 21, Colors.blue),
    Ratings('3.0', '90', 9, Colors.yellow),
    Ratings('2.0', '40', 4, Colors.orange),
    Ratings('1.0', '30', 3, Colors.red),
  ];

  // generateData() {
  //   ratingsChart.add(
  //     charts.Series(
  //       data: _ratings,
  //       domainFn: (Ratings rating, _) => rating.ratings,
  //       measureFn: (Ratings rating, _) => rating.value,
  //       colorFn: (Ratings rating, _) =>
  //           charts.ColorUtil.fromDartColor(rating.color),
  //       id: 'Ratings',
  //     ),
  //   );
  //   earningsChart.add(
  //     charts.Series(
  //         data: _earnings,
  //         domainFn: (Ratings rating, _) => rating.ratings,
  //         measureFn: (Ratings rating, _) => rating.value,
  //         colorFn: (Ratings rating, _) =>
  //             charts.ColorUtil.fromDartColor(rating.color),
  //         id: 'Earnings',
  //         labelAccessorFn: (Ratings row, _) => '${row.value}'),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // ratingsChart = <charts.Series<Ratings, String>>[];
    // earningsChart = <charts.Series<Ratings, String>>[];
    // generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context,Strings.INSIGHT)!,style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme){
          return FadedSlideAnimation(
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height + 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  getTranslated(context,Strings.TODAY)!.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      letterSpacing: 0.7),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: '12\n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 17)),
                                      TextSpan(
                                          text: getTranslated(context,Strings.RIDES),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                              fontSize: 13,
                                              color: Theme.of(context).hintColor,
                                              height: 1.4)),
                                    ])),
                                Spacer(
                                  flex: 7,
                                ),
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: '\u{20B9}144.50\n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 17)),
                                      TextSpan(
                                          text: getTranslated(context,Strings.EARNINGS),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                              fontSize: 13,
                                              color: Theme.of(context).hintColor,
                                              height: 1.4)),
                                    ])),
                                Spacer(),
                              ],
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            Text(
                              getTranslated(context,Strings.EARNINGS)!.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 15, letterSpacing: 0.7),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 15,
                              child: Image.asset(
                                theme.scaffoldBackgroundColor == Colors.black?'assets/insight.png':'assets/insight_light.png', height: 150, width: double.infinity,), /*charts.BarChart(
                              earningsChart,
                              animate: true,
                              animationDuration: Duration(milliseconds: 1000),*/
                              // ),
                            ),
                            Spacer(),
                            Center(
                              child: Text(
                                getTranslated(context,Strings.VIEW_ALL_TRANSACTIONS)!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    letterSpacing: 0.7),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context,Strings.CURRENT_RATINGS)!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 15, letterSpacing: 0.7),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(6),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.ratingsColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('4.2'),
                                      SizedBox(width: 4),
                                      Icon(Icons.star, size: 12),
                                    ],
                                  ),
                                ),
                                Text(
                                  '1080 ' + getTranslated(context,Strings.PEOPLE_RATED)!,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                        theme.scaffoldBackgroundColor == Colors.black?'assets/ratings.png':'assets/ratings_light.png',
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ) /*charts.PieChart(
                                    ratingsChart,
                                    animate: true,
                                    animationDuration: Duration(milliseconds: 1000),
                                    defaultRenderer:
                                        charts.ArcRendererConfig(arcWidth: 35),
                                  ),*/
                                  ),
                                  // Expanded(
                                  //   child: ListView.builder(
                                  //     physics: NeverScrollableScrollPhysics(),
                                  //     shrinkWrap: true,
                                  //     itemCount: _ratings.length,
                                  //     itemBuilder: (context, index) => Row(
                                  //       children: [
                                  //         Container(
                                  //           margin: EdgeInsets.all(6),
                                  //           padding: EdgeInsets.symmetric(
                                  //               horizontal: 8, vertical: 2),
                                  //           decoration: BoxDecoration(
                                  //             color: _ratings[index].color,
                                  //             borderRadius: BorderRadius.circular(16),
                                  //           ),
                                  //           child: Row(
                                  //             children: [
                                  //               Text(_ratings[index].ratings),
                                  //               SizedBox(width: 4),
                                  //               Icon(Icons.star, size: 12),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //         Text(
                                  //           _ratings[index].noOfRatings,
                                  //           style: Theme.of(context).textTheme.caption,
                                  //         ),
                                  //         SizedBox(width: 4),
                                  //         Text('(' +
                                  //             _ratings[index].value.toString() +
                                  //             ' %)')
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                getTranslated(context,Strings.READ_ALL_REVIEWS)!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                    color: Colors.black,
                                    letterSpacing: 0.7),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          );
        },
      ),
    );
  }
}

class Ratings {
  final String ratings;
  final String noOfRatings;

  final double value;
  final Color color;

  Ratings(this.ratings, this.noOfRatings, this.value, this.color);
}
