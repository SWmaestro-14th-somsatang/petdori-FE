import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';

class StatsValueWidget extends StatefulWidget {
  final int milliSecondCycle;
  final Function getter;

  const StatsValueWidget({
    super.key,
    required this.milliSecondCycle,
    required this.getter,
  });

  @override
  _StatsValueWidgetState createState() => _StatsValueWidgetState();
}

class _StatsValueWidgetState extends State<StatsValueWidget> {
  late Timer timer;
  late Future<String> ret;
  String value = "--";

  @override
  void initState() {
    super.initState();
    Future<String> ret = widget.getter();
    ret.then((value) {
      this.value = value;
      setState(() {});
    }).onError((error, stackTrace) {
      this.value = "--";
    });

    Future.delayed(const Duration(seconds: 3), () {
      timer = Timer.periodic(Duration(milliseconds: widget.milliSecondCycle),
          (timer) {
        if (!context.read<SessionStateProvider>().isPaused) {
          setState(() {
            Future<String> ret = widget.getter();
            ret.then((value) {
              this.value = value;
            }).onError((error, stackTrace) {
              this.value = "--";
            });
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
