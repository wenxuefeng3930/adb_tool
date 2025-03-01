import 'package:adb_tool/app/controller/devices_controller.dart';
import 'package:adb_tool/themes/app_colors.dart';
import 'package:adb_tool/utils/dex_server.dart';
import 'package:app_manager/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_repository/global_repository.dart';

class AppManagerWrapper extends StatefulWidget {
  const AppManagerWrapper({
    Key key,
    @required this.devicesEntity,
  }) : super(key: key);
  final DevicesEntity devicesEntity;

  @override
  _AppManagerWrapperState createState() => _AppManagerWrapperState();
}

class _AppManagerWrapperState extends State<AppManagerWrapper> {
  @override
  void initState() {
    super.initState();
    startServer();
  }

  Future<void> startServer() async {
    await DexServer.startServer(
      widget.devicesEntity.serial,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!DexServer.serverStartList.contains(widget.devicesEntity.serial)) {
      return SpinKitDualRing(
        color: AppColors.accent,
        size: 20.w,
        lineWidth: 2.w,
      );
    }
    return AppManagerEntryPoint(
      // 直接进到设备的shell
      process: YanProcess()
        ..exec('adb -s ${widget.devicesEntity.serial} shell'),
    );
  }
}
