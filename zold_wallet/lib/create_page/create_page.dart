import 'package:flutter/material.dart';
import './create_page_view.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  CreatePageView createState() => CreatePageView();
}