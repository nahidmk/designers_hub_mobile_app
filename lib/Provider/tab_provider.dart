

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier{
  CupertinoTabController tabController = CupertinoTabController(initialIndex: 0);
}