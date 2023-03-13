import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Routes/page_routes.dart';
import 'package:qcabs_driver/utils/Session.dart';
import '../Assets/assets.dart';
import '../Components/background_image.dart';
import '../Components/custom_button.dart';
import '../Theme/style.dart';
import 'package:qcabs_driver/Locale/locale.dart';

class RideBookedPage extends StatefulWidget {
  @override
  _RideBookedPageState createState() => _RideBookedPageState();
}

class _RideBookedPageState extends State<RideBookedPage> {
  bool isOpened = false;
  bool rideAccepted = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return   Scaffold(
      backgroundColor: Colors.transparent,
      body: FadedSlideAnimation(
        Stack(
          children: [
            BackgroundImage(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 12,
                ),
                SafeArea(
                  child: rideAccepted
                      ? Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(getTranslated(context,Strings.GO_TO_PICKUP)!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                letterSpacing: 0.7,
                                fontSize: 16)),
                        Spacer(),
                        Text(
                          getTranslated(context,Strings.NAVIGATE)!.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              Theme.of(context).primaryColor,
                              letterSpacing: 0.7,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.navigation_rounded,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  )
                      : RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: getTranslated(context,
                                Strings.RIDE_REQUEST_RECEIVED)! +
                                '\n',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                letterSpacing: 0.5)),
                        TextSpan(
                            text: '0:30 sec left',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5)),
                      ])),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: GestureDetector(
                    onVerticalDragDown: (details) {
                      setState(() {
                        isOpened = !isOpened;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: isOpened ? 110 : 150,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        borderRadius: isOpened
                            ? BorderRadius.circular(16)
                            : BorderRadius.vertical(
                            top: Radius.circular(16)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              Assets.Driver,
                              height: 72,
                              width: 72,
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sam Smith',
                                style: theme.textTheme.headline6,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                getTranslated(context,Strings.PICKUP_DESTINATION)!,
                                style: theme.textTheme.caption,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '2nd ave, LA',
                                style: theme.textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageRoutes.reviewsPage);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppTheme.ratingsColor,
                              ),
                              child: Row(
                                children: [
                                  Text('4.2'),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.star,
                                    color: AppTheme.starColor,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Details(isOpened ? 270 : 0),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 72,
                  color:
                  isOpened ? Colors.transparent : theme.backgroundColor,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.only(
                    left: 8, top: 12, right: 8, bottom: 70),
                child: Row(
                  children: [
                    buildFlatButton(
                        Icons.call,
                        getTranslated(context,Strings.CALL_NOW,)!),
                    Spacer(),
                    buildFlatButton(Icons.close, getTranslated(context,Strings.CANCEL)!),
                    Spacer(),
                    buildFlatButton(
                        isOpened
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        isOpened
                            ? getTranslated(context,Strings.LESS)!
                            : getTranslated(context,Strings.MORE)!, () {
                      setState(() {
                        isOpened = !isOpened;
                      });
                    }),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              start: 0,
              end: 0,
              child: CustomButton(
                onTap: () {
                  if (rideAccepted)
                    Navigator.pushNamed(context, PageRoutes.beginRide);
                  setState(() {
                    rideAccepted = true;
                  });
                },
                text: rideAccepted
                    ? getTranslated(context,Strings.ARRIVED)
                    : getTranslated(context,Strings.ACCEPT_RIDE),
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Widget buildFlatButton(IconData icon, String text, [Function? onTap]) {
    return Expanded(
      flex: 10,
      child: TextButton.icon(
        onPressed: onTap as void Function()? ?? () {},
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        icon: Icon(
          icon,
          size: 18,
          color: Colors.black,
        ),
        label: Text(
          text,
          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  final double height;

  Details(this.height);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: widget.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      getTranslated(context,Strings.RIDE_INFO)!,
                      style: theme.textTheme.bodyText1!
                          .copyWith(color: theme.hintColor, fontSize: 18),
                    ),
                    trailing: Text('08 km', style: theme.textTheme.headline6),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: theme.primaryColor,
                    ),
                    title: Text('2nd ave, World Trade Center'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.navigation,
                      color: theme.primaryColor,
                    ),
                    title: Text('1124, Golden Point Street'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  buildRowItem(theme, getTranslated(context,Strings.PAYMENT_VIA)!,
                      getTranslated(context,Strings.WALLET)!, Icons.account_balance_wallet),
                  Spacer(),
                  buildRowItem(theme, getTranslated(context,Strings.RIDE_FARE)!, '\u{20B9}40.50',
                      Icons.account_balance_wallet),
                  Spacer(),
                  buildRowItem(theme, getTranslated(context,Strings.RIDE_TYPE)!,
                      getTranslated(context,Strings.GO_PRIVATE)!, Icons.drive_eta),
                ],
              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }

  Column buildRowItem(
      ThemeData theme, String title, String subtitle, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyText1!.copyWith(color: theme.hintColor),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, color: theme.primaryColor),
            SizedBox(width: 12),
            Text(
              subtitle,
              style: theme.textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }
}
