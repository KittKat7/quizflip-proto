
part of '../widgets.dart';

Future<bool> overwriteConfirmAlertPopup(context, Function(bool a) applyToAll, String cardID) async {
  bool overwriteThis = false;
  void _setOverwriteThis(bool overwrite) => overwriteThis = overwrite;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return OverwriteConfirmAlert(overwriteThis: _setOverwriteThis, applyToAll: applyToAll, cardID: cardID);
    }
  );
  return overwriteThis;
}//e overwriteConfirmAlertPopup()

class OverwriteConfirmAlert extends StatefulWidget {

  final String cardID;
  final void Function(bool applyAll) applyToAll;
  final void Function(bool overwrite) overwriteThis;

  const OverwriteConfirmAlert({super.key, required this.applyToAll, required this.overwriteThis, required this.cardID});

  @override
  State<OverwriteConfirmAlert> createState() => _OverwriteConfirmAlertState();
}//e OverwriteConfirmAlert

class _OverwriteConfirmAlertState extends State<OverwriteConfirmAlert> {

  bool applyAll = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        actions: [
          Checkbox(value: applyAll, onChanged: (a) {
            setState(() => applyAll = a ?? false );
            widget.applyToAll(applyAll);
          }),
          Marked(getLang('bnt_apply_to_all')),
          TextButton(
            onPressed: () { Navigator.of(context).pop(); widget.overwriteThis(false); },
            child: Marked(getLang('skip'))
          ),
          TextButton(
            onPressed: () { Navigator.of(context).pop(); widget.overwriteThis(true); },
            child: Marked(getLang('overwrite'))
          ),
        ],
        title: Marked(getLang('header_confirm_overwrite')),
        content: Marked(getLang('msg_confirm_overwrite', [widget.cardID])),
      )
    );
  }//e build()
}