import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran/Controller/provider/text_size.dart';

import 'constans.dart';


class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;

  NetworkSensitive({
    this.child,
    this.opacity = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Data) {
      return child;
    }
    if (connectionStatus == ConnectivityStatus.Offline) {
      return SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            child,
            Positioned(
              left: 0.0,
              right: 0.0,
              height: 40.0,
              child: AnimatedContainer(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().setHeight(350),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFEE4400),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "لا يوجد اتصال بالانترنت",
                      style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: 12.0,
                      height: ScreenUtil().setHeight(12),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Opacity(
      opacity: 0.1,
      child: child,
    );
  }
}
