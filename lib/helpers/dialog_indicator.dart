import 'package:flutter/material.dart';

class DialogIndicator {
  DialogIndicator(this.context);
  final BuildContext context;

  void showLoadingIndicator([String text = '']) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: null,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(3.0),
              ),
            ),
            elevation: 0.0,
            backgroundColor: Color(0xFF121314).withOpacity(0.5),
            content: LoadingIndicator(text: text),
          ),
        );
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }

  void popDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({this.text = ''});
  final String text;


  @override
  Widget build(BuildContext context) {
    var displayedText = text;


    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getLoadingIndicator(),
          _getHeading(context),
          _getText(displayedText),
        ],
      ),
    );
  }

  Padding _getLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
        ),
        width: 40,
        height: 40,
      ),
    );
  }

  Widget _getHeading(context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text(
        'please wait',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
    );
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}

