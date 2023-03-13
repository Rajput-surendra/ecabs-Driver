import 'dart:async';
import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/DrawerPages/Settings/rules.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Theme/style.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'app_drawer.dart';
import 'package:http/http.dart' as http;
class FAQs {
  final Strings title;
  final Strings subtitle;

  FAQs(this.title, this.subtitle);
}

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  void initState() {
    super.initState();
    getFaq();
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  List<RuleModel> ruleList = [];
  getFaq() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
        };
        var res = await http.get(Uri.parse(baseUrl1 + "Page/faq"));
        Map response = jsonDecode(res.body);
        print(response);
        print(response);
        bool status = true;
        String msg = response['message'];
        setSnackbar(msg, context);
        if (response['status']) {
          for(var v in response['data']){
            setState(() {
              ruleList.add(new RuleModel(v['id'], v['title'], v['description']));
            });
          }
        } else {}
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
      }
    } else {
      setSnackbar("No Internet Connection", context);
    }
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          getTranslated(context,Strings.FAQS)!,
          style: theme.textTheme.headline4,
        ),
      ),
      drawer: AppDrawer(false),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text(
                  getTranslated(context,Strings.READ_FAQS)!,
                  style:
                      theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                ),
              ),
              SizedBox(height: 20),
              ruleList.length>0?Container(
                color: theme.backgroundColor,
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ruleList.length,
                  itemBuilder: (context, index) =>    Container(
                    decoration: boxDecoration(radius: 10,showShadow: true),
                    margin: EdgeInsets.all(getWidth(10)),
                    child: ExpansionTile(
                      tilePadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      title: Text(
                        getString1(ruleList[index].title),
                        style: theme.textTheme.headline6,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(getString1(ruleList[index].description)),
                        )
                      ],
                      expandedAlignment:Alignment.centerLeft ,
                      trailing: Icon(
                        Icons.keyboard_arrow_down,
                        color: theme.primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ):Center(child: CircularProgressIndicator(),)
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
