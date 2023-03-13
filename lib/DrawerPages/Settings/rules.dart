import 'dart:async';
import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcabs_driver/Components/custom_button.dart';
import 'package:qcabs_driver/DrawerPages/Settings/theme_cubit.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Theme/style.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:sizer/sizer.dart';
import 'language_cubit.dart';
import 'package:http/http.dart' as http;

class RuleModel{
  String id,title,description;

  RuleModel(this.id, this.title, this.description);
}


class RulesRegulation extends StatefulWidget {
  @override
  _RulesRegulationState createState() => _RulesRegulationState();
}

class _RulesRegulationState extends State<RulesRegulation> {
  late LanguageCubit _languageCubit;
  late ThemeCubit _themeCubit;
  int? _themeValue;
  int? _languageValue;
  bool screenStatus = false;
  @override
  void initState() {
    super.initState();
    getRules();
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  List<RuleModel> ruleList = [];
  getRules() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
        };
        var res = await http.get(Uri.parse(baseUrl1 + "Page/get_rules_regutlation"));
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
          "Rules and Regulation",
          style: theme.textTheme.headline4,
        ),
      ),
      body: FadedSlideAnimation(
        Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(25)),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              boxHeight(20),
              ruleList.length>0?ListView.builder(
                  shrinkWrap: true,
                  itemCount: ruleList.length,
                  itemBuilder: (context,index){
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boxHeight(10),
                          text(getString1(ruleList[index].title),fontSize: 14.sp,fontFamily: fontBold,textColor: MyColorName.colorTextPrimary),
                          boxHeight(10),
                          text(getString1(ruleList[index].description),fontSize: 10.sp,fontFamily: fontMedium,textColor: MyColorName.colorTextPrimary),

                        ],
                      ),
                    );
                  }):CircularProgressIndicator(),
              SizedBox(
                height: 80,
              )
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
