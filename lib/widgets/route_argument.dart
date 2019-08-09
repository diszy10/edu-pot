import 'package:flutter/foundation.dart';

class RouteArgument {
  final String from;
  final Object data;

  const RouteArgument({this.from, @required this.data});
}

class SubjectListArgument extends RouteArgument {
  final subject;

  const SubjectListArgument({from, data, this.subject})
      : super(from: from, data: data);
}
