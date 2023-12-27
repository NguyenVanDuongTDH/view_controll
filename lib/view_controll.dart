// ignore_for_file: must_be_immutable

library view_controll;

import 'package:flutter/material.dart';

abstract class ViewControll extends StatelessWidget {
  final _WidgetControll _globalWidget = _WidgetControll();

  ViewControll({Key? key}) : super(key: key) {
    _globalWidget.initState = () {
      initState();
    };
    _globalWidget.dispose = () {
      dispose();
    };
  }

  @override
  Widget build(BuildContext context) {
    return _globalWidget.ob(() => view(context));
  }

  void reload() {
    _globalWidget.setState(() {});
  }

  void initState() {}
  void dispose() {}

  @protected
  Widget view(BuildContext context);
}

class _WidgetControll {
  final GlobalKey<_WidgetSatefulState> _key = GlobalKey<_WidgetSatefulState>();

  Function()? initState;
  Function()? dispose;

  Widget ob(Widget Function() lamda) {
    return _WidgetSateful(
      key: _key,
      child: lamda,
      initState: initState,
      dispose: dispose,
    );
  }

  void setState(void Function() fn) => _key.currentState?.setState(fn);
}

class _WidgetSateful extends StatefulWidget {
  _WidgetSateful(
      {super.key,
      required this.child,
      required this.initState,
      required this.dispose});
  Widget Function() child;
  Function()? initState;
  Function()? dispose;

  @override
  State<_WidgetSateful> createState() => _WidgetSatefulState();
}

class _WidgetSatefulState extends State<_WidgetSateful> {
  @override
  void initState() {
    super.initState();
    if (widget.initState != null) {
      widget.initState!();
    }
  }

  @override
  void dispose() {
    if (widget.dispose != null) {
      widget.dispose!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child();
  }
}
