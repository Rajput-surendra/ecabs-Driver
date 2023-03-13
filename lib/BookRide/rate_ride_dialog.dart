import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Routes/page_routes.dart';
import 'package:qcabs_driver/utils/Session.dart';
import '../Assets/assets.dart';
import '../Components/custom_button.dart';
import '../Components/entry_field.dart';
import '../Theme/style.dart';
import 'package:qcabs_driver/Locale/locale.dart';

class RateRideDialog extends StatefulWidget {
  @override
  _RateRideDialogState createState() => _RateRideDialogState();
}

class _RateRideDialogState extends State<RateRideDialog> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: FadedSlideAnimation(
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Theme.of(context).primaryColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  Assets.Driver,
                                  height: 72,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Sam Smith',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
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
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '(128)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Theme.of(context).hintColor),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated(context,Strings.RIDE_FARE)!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Theme.of(context).hintColor),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\u{20B9}50.04',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(height: 24),
                              Text(
                                getTranslated(context,Strings.PAYMENT_VIA)!,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context).hintColor, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: theme.primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    getTranslated(context,Strings.WALLET)!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    ListTile(
                      title: Text(
                        getTranslated(context,Strings.RIDE_INFO)!,
                        style: theme.textTheme.headline6!
                            .copyWith(color: theme.hintColor),
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
                    SizedBox(height: 20,),
                    Divider(),
                    SizedBox(height: 20,),
                    Center(
                      child: Text(getTranslated(context,Strings.RATE_YOUR_PASSENGER)!,
                          style: theme.textTheme.headline6!
                              .copyWith(color: theme.hintColor)),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: theme.primaryColor,
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    EntryField(
                      hint: getTranslated(context,Strings.ADD_COMMENT),
                    ),
                    SizedBox(height: 80,),

                  ],
                ),
              ),
              PositionedDirectional(
                start: 0,
                end: 0,
                child: CustomButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: getTranslated(context,Strings.SUBMIT_REVIEW),
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
