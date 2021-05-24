import 'package:flutter/material.dart';
import 'package:im_api_example/im/friendSelector.dart';
import 'package:im_api_example/utils/sdkResponse.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class SetFriendInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetFriendInfoState();
}

class SetFriendInfoState extends State<SetFriendInfo> {
  String nickname = '';
  String faceUrl = '';
  String selfSignature = "";
  int? gender;
  int? allowType;
  String? customInfo;
  List<String> users = List.empty(growable: true);
  String? friendRemark;
  Map<String, dynamic>? resData;
  setFriendInfo() async {
    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager
        .getFriendshipManager()
        .setFriendInfo(
          friendRemark: friendRemark,
          userID: users.first,
          // friendCustomInfo: Map<String, String>.from(
          //   {"test": "test"},
          // ),自定义字段需要先去控制台设置，然后才能调用接口设置，先注释
        );
    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              FriendSelector(
                onSelect: (data) {
                  setState(() {
                    users = data;
                  });
                },
                switchSelectType: true,
                value: users,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(users.length > 0 ? users.toString() : "未选择"),
                ),
              )
            ],
          ),
          new Row(
            children: [
              Expanded(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: "好友备注",
                          hintText: "好友备注",
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (res) {
                          setState(() {
                            friendRemark = res;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          new Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: setFriendInfo,
                  child: Text("设置好友信息"),
                ),
              )
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
