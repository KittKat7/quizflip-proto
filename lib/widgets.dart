import 'dart:async';
import 'package:kkfl_lang/kkfl_lang.dart';
import 'package:kkfl_routing/kkfl_routing.dart';
import 'package:kkfl_theming/kkfl_theming.dart';
import 'package:kkfl_widgets/kkfl_widgets.dart';

import '/inout.dart';
import 'package:flutter/material.dart';
import '/study.dart';
import '/flashcard.dart';
import '/multichoice.dart';

part 'widgets/flashcard_button_widget.dart';
part 'widgets/flashcard_widget.dart';
part 'widgets/multichoice_page.dart';
part 'widgets/overwrite_confirm_widget.dart';
part 'widgets/practice_page.dart';
part 'widgets/review_page.dart';

/// A Flutter widget representing a customizable layer button.
///
/// The [LayerBtn] widget displays a button with text specified by the [layer]
/// parameter. The appearance and behavior of the button can be customized based
/// on the [isApplied] parameter, which determines whether the button is in a
/// selected state.
///
/// The [onPressed] parameter is a callback function that will be executed when
/// the button is pressed. It is of type `void Function()`.
///
/// Example usage:
/// ```dart
/// LayerBtn(
///   layer: 'Layer Name',
///   onPressed: () {
///     // Handle button press.
///   },
///   isApplied: true, // Set to true for a selected state, false otherwise.
/// )
/// ```
///
/// The button's appearance is determined by the [isApplied] parameter. If
/// [isApplied] is true, the button will have a different background color
/// indicating its selected state; otherwise, it will have a primary color
/// background. The button text is formatted using the `MarkD` widget, allowing
/// rich text and markdown-like styling.
class LayerBtn extends StatelessWidget {
  /// What text should be displayed on the button.
  final String layer;
  /// What to do when the button is pressed, should either be adding to the filter or setting the
  /// filter.
  final void Function() onPressed;
  /// Whether or not the button has already been pressed, and should be grayed out.
  final bool isApplied;

  /// Constructor
  const LayerBtn({super.key, required this.layer, required this.onPressed, this.isApplied = false});

  @override
  Widget build(BuildContext context) {
    // the child the button will display.
    Widget child = Marked(layer);
    // The styling for not selected buttons.
    ButtonStyle priStyle = ElevatedButton.styleFrom(backgroundColor: colorScheme(context).primaryContainer);
    // The styling for selected buttons.
    ButtonStyle selStyle = ElevatedButton.styleFrom(backgroundColor: colorScheme(context).surface);
    // If the button is selected (isApplied) style is the selected style, otherwise style is the
    // primary style
    ButtonStyle style = isApplied ? selStyle : priStyle;

    // The button.
    Widget button = ElevatedButton(style: style, onPressed: () => onPressed(), child: child);
    // pad the button.
    Widget paddedBtn = Padding(padding: const EdgeInsets.all(5), child: button);

    // return an ElevatedButton with the selected style, with the correct onPressed, and correct
    // child.
    return paddedBtn;
  }//e Build
}//e DeckBtn


/// A Flutter widget representing a customizable start button.
///
/// The [StartBtn] widget displays a button with an [Icon] and text specified
/// by the [icon] and [text] parameters, respectively. The appearance and
/// behavior of the button can be customized based on the specified [onPressed]
/// callback function.
///
/// The [onPressed] parameter is a callback function that will be executed when
/// the button is pressed. It is of type `void Function(BuildContext)`.
///
/// Example usage:
/// ```dart
/// StartBtn(
///   icon: Icon(Icons.play_arrow),
///   text: 'Start',
///   onPressed: (BuildContext context) {
///     // Handle button press with access to the build context.
///   },
/// )
/// ```
///
/// The button's appearance is determined by the default background color of the
/// current theme. The button content consists of an [Icon] and text, both
/// aligned in a row at the center.
class StartBtn extends StatelessWidget {
  /// The card to be displayed.
  final String text;
  final Icon icon;
  /// The function to run when the button is pressed.
  final void Function(BuildContext) onPressed;

  /// Constructor
  const StartBtn({super.key, required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: colorScheme(context).background
    );

    return ElevatedButton(
      style: style,
      onPressed: () => onPressed(context),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [icon, Marked(text)])
    );
  }//e Build
}//e StartBtn

// TODO doc comment and update function
Widget deckBtns(List<String> layers, void Function() updateState) {
  // All the buttons generated and to be displayed.
  List<Widget> children = [];
  
  // Add a button to reset the filter and display all decks / cards.
  children.add(LayerBtn(
    layer: getLang('btn_all_cards'),
    onPressed: () { Flashcard.setFilter([]); updateState(); },
    isApplied: true,
  ));

  // For every layer in the applied filter, make a button allowing going directly back to that
  // layer.
  for (int i = 0; i < Flashcard.filter.length; i++) {
    // A string containing the layers that the button should revert to.
    String str = "";
    // The top layer, which should be displayed as the text for the button.
    String layer = Flashcard.filter[i];
    // For every layer up to the layer i, add it to str, then add layer i.
    for (int j = 0; j < i; j++) {
      str += "${Flashcard.filter[j]}/";
    } str += "${Flashcard.filter[i]}/";
    //e for

    if (!str.startsWith("#") && !str.startsWith("/")) {
      str = "/$str";
    }//e if
    
    List<String> fltr = str.split("/")..removeWhere((element) => element.isEmpty);
    // Add the DeckBtn with the string of layers split by "/".
    children.add(LayerBtn(
      layer: layer,
      onPressed: () { Flashcard.setFilter(fltr); updateState(); },
      isApplied: true
    ));
  }//e for
  
  // For every layer in the provided list of layers, add a button which onPress pushes that layer
  // onto the filter.
  for (String layer in layers) {
    children.add(LayerBtn(
      layer: layer,
      onPressed: () { Flashcard.pushFilter(layer); updateState(); }
    ));
  }//e for

  Widget wrap = Align(alignment: Alignment.topLeft, child: Wrap(alignment: WrapAlignment.start, children: children,));
  return wrap;
}//e deckBtns


/// Generates a widget containing start buttons for different actions.
///
/// The [startBtns] method creates a widget containing three start buttons for
/// different actions: practice, review, and multitest. Each button includes an
/// icon, text, and an [onPressed] callback to navigate to the corresponding
/// screen using the [Navigator].
///
/// Example usage:
/// ```dart
/// Widget startButtonsWidget = startBtns();
/// ```
///
/// The method uses the [StartBtn] widget to create individual buttons for
/// practice, review, and multitest. These buttons are then arranged in a
/// [Wrap] widget for a flexible layout. Additionally, the buttons are also
/// displayed in a [GridView] with three columns for a more organized display.
Widget startBtns() {

  Widget practice = StartBtn(
    icon: const Icon(Icons.play_arrow),
    text: getLang('btn_practice'),
    // onPressed: (context) => Navigator.of(context).pushNamed(getRoute('practice'))
    onPressed: (context) => Navigator.of(context).push(genRoute(const PracticePage(title: "")))
  );
  Widget review = StartBtn(
    icon: const Icon(Icons.fast_forward),
    text: getLang('btn_review'),
    // onPressed: (context) => Navigator.of(context).pushNamed(getRoute('review'))
    onPressed: (context) => Navigator.of(context).push(genRoute(const ReviewPage(title: "")))
  );
  Widget multitest = StartBtn(
    icon: const Icon(Icons.check_box),
    text: getLang('btn_multitest'),
    // onPressed: (context) => Navigator.of(context).pushNamed(getRoute('multichoice'))
    onPressed: (context) => Navigator.of(context).push(genRoute(const MultiChoicePage(title: "")))
  );

  Widget wrap = Align(alignment: Alignment.topCenter, child: Wrap(alignment: WrapAlignment.start, children: [practice, review, multitest]));

  Widget startBtns = GridView.count(
    primary: false,
    shrinkWrap: true,
    crossAxisCount: 3,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 4,
    children: [practice, review, multitest],
  );

  startBtns = Padding(padding: const EdgeInsets.only(bottom: 10), child: wrap);

  return startBtns;
}//e startBtns()


/// Displays a theme mode selection popup in the specified [context].
///
/// The [themeModePopup] method creates an AlertDialog containing a column of
/// ElevatedButtons, each representing a different theme mode option. The
/// options include setting the theme to light mode, dark mode, or automatic
/// mode.
///
/// Example usage:
/// ```dart
/// themeModePopup(context);
/// ```
///
/// The method utilizes the [getAppThemeMode] function to access the
/// `AppThemeMode` instance and sets the theme mode based on the user's
/// selection.
void themeModePopup(BuildContext context) {

  var themeModeList = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ElevatedButton(
        onPressed: () => appTheme.setLightMode(),
        child: Marked(getLang('btn_light_theme'))),
      ElevatedButton(
        onPressed: () => appTheme.setDarkMode(),
        child: Marked(getLang('btn_dark_theme'))),
      ElevatedButton(
        onPressed: () => appTheme.setSystemMode(),
        child: Marked(getLang('btn_auto_theme'))),
  ]);

  // showDialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Marked(getLang('btn_theme_brightness_menu')),
        content: themeModeList,
        actions: <Widget>[
          TextButton(
            child: Text(getLang('close')),
            onPressed: () {
              Navigator.of(context).pop();
            },//e onPressed
          ),//e TextButton
        ],//e <Widget>[]
      );//e AlertDialog
    },//e builder
  );//e showDialog
}//e createCardPopup

/// Displays a theme color selection popup in the specified [context].
///
/// The [themeColorPopup] method creates an AlertDialog containing a column of
/// ElevatedButtons, each representing a different theme color option. The
/// available theme colors are retrieved using the [getAvailableThemeColors]
/// function. When a color button is pressed, the method uses the
/// [getColorTheme] function to set the color theme accordingly.
///
/// Example usage:
/// ```dart
/// themeColorPopup(context);
/// ```
///
/// The method dynamically generates the color buttons based on the available
/// theme colors and their corresponding names.
void themeColorPopup(BuildContext context, AppTheme theme) {

  final List<MaterialColor> colors = getAvailableColors();

  List<Widget> colorButtons = [];

  for (MaterialColor color in colors) {
    String c = '${color.red}, ${color.green}, ${color.blue}';
    colorButtons.add(
      ElevatedButton(
        onPressed:() => theme.setColor(color),
        child: Marked("${c.substring(0, 1).toUpperCase()}${c.substring(1).toLowerCase()}"))
    );
  }

  var themeModeList = Column(
    mainAxisSize: MainAxisSize.min,
    children: colorButtons);

  // showDialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Marked(getLang('btn_theme_brightness_menu')),
        content: themeModeList,
        actions: <Widget>[
          TextButton(
            child: Text(getLang('close')),
            onPressed: () {
              Navigator.of(context).pop();
            },//e onPressed
          ),//e TextButton
        ],//e <Widget>[]
      );//e AlertDialog
    },//e builder
  );//e showDialog
}//e themeColorPopup


/// A Flutter widget that adds a long-press gesture to a child widget.
///
/// The [LongPressWidget] class allows you to wrap any widget with a
/// long-press gesture. It takes a [child] widget and a [onLongPress] callback
/// function that will be executed when the user performs a long-press on the
/// wrapped widget.
///
/// Example usage:
/// ```dart
/// LongPressWidget(
///   child: YourWidget(),
///   onLongPress: () {
///     // Handle long-press action.
///   },
/// )
/// ```
class LongPressWidget extends StatelessWidget {

  final Widget child;
  final void Function() onLongPress;

  LongPressWidget({required this.child, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    // create widget
    Widget longPress = GestureDetector(onLongPress: () => onLongPress(), child: child,);
    return longPress;
  }//e buidl()
}//e LongPressWidget

/// A Flutter widget representing a confidence button with additional long-press functionality.
///
/// The [ConfidenceBtn] class combines an [IconButton] with a long-press gesture,
/// allowing users to perform both regular press and long-press actions. It takes
/// an [icon] for the regular press action, [onPressed] callback for the regular
/// press event, and [onLongPress] callback for the long-press event.
///
/// Example usage:
/// ```dart
/// ConfidenceBtn(
///   icon: Icon(Icons.thumb_up),
///   onPressed: () {
///     // Handle regular press action.
///   },
///   onLongPress: () {
///     // Handle long-press action.
///   },
/// )
/// ```
class ConfidenceBtn extends StatelessWidget {
  
  final Icon icon;
  final void Function() onPressed;
  final void Function() onLongPress;
  const ConfidenceBtn({super.key, required this.icon, required this.onPressed, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    var iconBtn = IconButton(onPressed: onPressed, icon: icon);
    var longPressWidget = LongPressWidget(onLongPress: onLongPress, child: iconBtn);
    return longPressWidget;
  }//e build()
}//e ConfidenceBtn

/// Generates a row of confidence buttons with regular and long-press actions.
///
/// The [confidenceBtns] method takes the [currentConfidence] level and a
/// [setConfidence] callback function to update the confidence level. It creates
/// a row of three [ConfidenceBtn] widgets, each representing a different
/// confidence level (low, medium, high). The [onPressed] callback sets the
/// confidence level when the button is pressed, and the [onLongPress] callback
/// resets the confidence level to -1 when the button is long-pressed.
///
/// Example usage:
/// ```dart
/// Widget confidenceButtonsWidget = confidenceBtns(
///   currentConfidenceLevel,
///   (int confidenceLevel) {
///     // Handle setting confidence level logic.
///   },
/// );
/// ```
Widget confidenceBtns(currentConfidence, void Function(int p) setConfidence) {
  Widget expand(Widget child) {
    return Expanded(flex: 1, child: child);
  }
  var confidenceBtns = Row(children: [
    expand(ConfidenceBtn(
      icon: Icon(currentConfidence == 0? Icons.remove_circle : Icons.remove_circle_outline),
      onPressed: () => setConfidence(0),
      onLongPress: () => setConfidence(-1),
    )),
    expand(ConfidenceBtn(
      icon: Icon(currentConfidence == 1? Icons.circle : Icons.circle_outlined),
      onPressed: () => setConfidence(1),
      onLongPress: () => setConfidence(-1),
    )),
    expand(ConfidenceBtn(
      icon: Icon(currentConfidence == 2? Icons.add_circle : Icons.add_circle_outline),
      onPressed: () => setConfidence(2),
      onLongPress: () => setConfidence(-1),
    )),
  ]);
  return confidenceBtns;
}//e confidenceBtns

/// Displays an alert popup with custom title, message, and buttons.
///
/// The [alertPopup] method shows an alert dialog using [showDialog] with a
/// custom title, message, and buttons. It takes the [context] for building the
/// dialog, [title] and [message] for the alert content, and lists of [btnStrings]
/// and [btnActions] for the button labels and corresponding actions.
///
/// Example usage:
/// ```dart
/// alertPopup(
///   context,
///   "Error",
///   "An error occurred. Please try again.",
///   ["OK"],
///   [() {
///     // Handle OK button action.
///   }],
/// );
/// ```
void alertPopup(
  BuildContext context,
  String title,
  String message,
  List<String> btnStrings,
  List<Function> btnActions
) {

  List<Widget> actions = [];
  for (int i = 0; i < btnStrings.length && i < btnActions.length; i++) {
    actions.add(
      TextButton(
        child: Marked(btnStrings[i]),
        onPressed: () { Navigator.of(context).pop(); btnActions[i](); },
      )
    );
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Marked(title),
        content: Marked(message),
        actions: actions,
      );
    }//e builder
  );//e showDialog
}//e alertPopup


/// Display markdown text but bigger than normal.
/// 
/// The [HeaderMarkd] class displays given text formatted in markdown. Unlike [Markd] this class
/// displays the text at a specified scale increase. This is used in places where some text would
/// need to act like a heading, IE the question for a flashcard.
class HeaderMarkd extends StatelessWidget {
  final String data;
  final double scale = 1.5;

  const HeaderMarkd(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Marked(data, scale: scale);
  }//e build()
}//e HeaderMarkd



/// Displays a divider for separating terms from definitions
/// 
/// [ThickDivider] A divider which is used to separate the term and definitions of flashcards.
class ThickDivider extends StatelessWidget {
  
  const ThickDivider({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Divider(thickness: 3);
  }//e build()
}//e ThickDivider



/// Displays a divider for separating fields
/// 
/// [ThinDivider] A divider which is used to separate fields.
class ThinDivider extends StatelessWidget {
  
  const ThinDivider({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Divider(thickness: 1, indent: 5, endIndent: 5,);
  }//e build()
}//e ThinDivider

/// Returns a widget with padding on the left and right.
/// 
/// This method takes [widget] as a parameter, and returns [widget] with [padding] on its left and
/// right sides.
Padding padLeftRight(Widget? widget, double padding) {
  return Padding(padding: EdgeInsets.only(left: padding, right: padding), child: widget,);
}//e padLeftRight