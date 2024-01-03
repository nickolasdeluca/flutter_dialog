import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  const BaseAlertDialog({
    this.content,
    super.key,
  });

  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      content: content,
    );
  }
}

class HiddenContent extends StatefulWidget {
  const HiddenContent({
    super.key,
    required this.visibleText,
    required this.hiddenText,
  });

  final String visibleText;
  final String hiddenText;

  @override
  State<HiddenContent> createState() => _HiddenContentState();
}

class _HiddenContentState extends State<HiddenContent> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        width: double.maxFinite,
        duration: const Duration(seconds: 5),
        curve: Curves.bounceOut,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: !isExpanded,
              child: Text(widget.visibleText),
            ),
            Visibility(
              visible: isExpanded,
              child: Text(
                widget.hiddenText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalDialog {
  static simple({
    required BuildContext context,
    required String title,
    required String buttonText,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BaseAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.transparent,
                height: 18,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF303F9F),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              const Divider(
                color: Color(0xFFDBDDE0),
                height: 36,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFFFCE444)),
                    minimumSize:
                        MaterialStatePropertyAll(Size(double.infinity, 35)),
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Color(0xFF25282B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static detailed({
    required BuildContext context,
    required String title,
    required String message,
    String? detail,
    required String buttonText,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BaseAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.transparent,
                height: 18,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF303F9F),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              const Divider(
                color: Colors.transparent,
                height: 9,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF52575C),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const Divider(
                color: Color(0xFFDBDDE0),
                height: 36,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFFFCE444)),
                    minimumSize:
                        MaterialStatePropertyAll(Size(double.infinity, 35)),
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Color(0xFF25282B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Color(0xFFDBDDE0),
                height: 36,
              ),
              Visibility(
                visible: detail != null,
                child: Align(
                  alignment: Alignment.center,
                  child: HiddenContent(
                    visibleText: "Show details",
                    hiddenText: detail ?? "",
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static waiting({
    required BuildContext context,
    required String message,
    String? detail,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BaseAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.transparent,
                height: 18,
              ),
              const Center(
                child: LinearProgressIndicator(color: Color(0xFF303F9F)),
              ),
              const Divider(
                color: Colors.transparent,
                height: 18,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF25282B),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Visibility(
                visible: detail != null,
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.transparent,
                      height: 6,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        detail ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF52575C),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.transparent,
                height: 12,
              ),
            ],
          ),
        );
      },
    );
  }
}
