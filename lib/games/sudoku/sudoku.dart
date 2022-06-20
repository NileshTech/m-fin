import 'dart:async';
import 'package:finance/ads/ads.dart';
import 'package:finance/common/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'Styles.dart';
import 'Alerts.dart';

class Sudoku extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SudokuState();
}

class SudokuState extends State<Sudoku> {
  bool firstRun = true;
  bool gameOver = false;
  int timesCalled = 0;
  bool isButtonDisabled = false;
  late List<List<List<int>>> gameList;
  late List<List<int>> game;
  late List<List<int>> gameCopy;
  late List<List<int>> gameSolved;
  static String? currentDifficultyLevel;
  static String? currentTheme;
  static String? currentAccentColor;
  static String? platform;
  static late bool isDesktop;

  @override
  void initState() {
    super.initState();
    try {
      doWhenWindowReady(() {
        appWindow.minSize = Size(800, 800);
      });
    } on UnimplementedError {}
    getPrefs().whenComplete(() {
      if (currentDifficultyLevel == null) {
        currentDifficultyLevel = 'easy';
        setPrefs('currentDifficultyLevel');
      }
      if (currentTheme == null) {
        if (MediaQuery.maybeOf(context)?.platformBrightness != null) {
          currentTheme =
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? 'light'
                  : 'dark';
        } else {
          currentTheme = 'dark';
        }
        setPrefs('currentTheme');
      }
      if (currentAccentColor == null) {
        currentAccentColor = 'Blue';
        setPrefs('currentAccentColor');
      }
      newGame(currentDifficultyLevel);
      changeTheme('set');
      changeAccentColor(currentAccentColor, true);
    });
    if (kIsWeb) {
      platform = 'web-' +
          defaultTargetPlatform
              .toString()
              .replaceFirst("TargetPlatform.", "")
              .toLowerCase();
      isDesktop = false;
    } else {
      platform = defaultTargetPlatform
          .toString()
          .replaceFirst("TargetPlatform.", "")
          .toLowerCase();
      isDesktop = ['windows', 'linux', 'macos'].contains(platform);
    }
  }

  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentDifficultyLevel = prefs.getString('currentDifficultyLevel');
      currentTheme = prefs.getString('currentTheme');
      currentAccentColor = prefs.getString('currentAccentColor');
    });
  }

  setPrefs(String property) async {
    final prefs = await SharedPreferences.getInstance();
    if (property == 'currentDifficultyLevel') {
      prefs.setString('currentDifficultyLevel', currentDifficultyLevel!);
    } else if (property == 'currentTheme') {
      prefs.setString('currentTheme', currentTheme!);
    } else if (property == 'currentAccentColor') {
      prefs.setString('currentAccentColor', currentAccentColor!);
    }
  }

  void changeTheme(String mode) {
    setState(() {
      if (currentTheme == 'light') {
        if (mode == 'switch') {
          Styles.primaryBackgroundColor = Styles.darkGrey;
          Styles.secondaryBackgroundColor = Styles.grey;
          Styles.foregroundColor = Styles.white;
          currentTheme = 'dark';
        } else if (mode == 'set') {
          Styles.primaryBackgroundColor = Styles.white;
          Styles.secondaryBackgroundColor = Styles.white;
          Styles.foregroundColor = Styles.darkGrey;
        }
      } else if (currentTheme == 'dark') {
        if (mode == 'switch') {
          Styles.primaryBackgroundColor = Styles.white;
          Styles.secondaryBackgroundColor = Styles.white;
          Styles.foregroundColor = Styles.darkGrey;
          currentTheme = 'light';
        } else if (mode == 'set') {
          Styles.primaryBackgroundColor = Styles.darkGrey;
          Styles.secondaryBackgroundColor = Styles.grey;
          Styles.foregroundColor = Styles.white;
        }
      }
      setPrefs('currentTheme');
    });
  }

  void changeAccentColor(String? color, [bool firstRun = false]) {
    setState(() {
      if (Styles.accentColors.keys.contains(color)) {
        Styles.primaryColor = Styles.accentColors[color!];
      } else {
        currentAccentColor = 'Blue';
        Styles.primaryColor = Styles.accentColors[color!];
      }
      if (color == 'Red') {
        Styles.secondaryColor = Styles.orange;
      } else {
        Styles.secondaryColor = Styles.lightRed;
      }
      if (!firstRun) {
        setPrefs('currentAccentColor');
      }
    });
  }

  void checkResult() {
    try {
      if (SudokuUtilities.isSolved(game)) {
        isButtonDisabled = !isButtonDisabled;
        gameOver = true;
        Timer(Duration(milliseconds: 500), () {
          showAnimatedDialog<void>(
              animationType: DialogTransitionType.fadeScale,
              barrierDismissible: true,
              duration: Duration(milliseconds: 350),
              context: context,
              builder: (_) => AlertGameOver()).whenComplete(() {
            if (AlertGameOver.newGame) {
              newGame();
              AlertGameOver.newGame = false;
            } else if (AlertGameOver.restartGame) {
              restartGame();
              AlertGameOver.restartGame = false;
            }
          });
        });
      }
    } on InvalidSudokuConfigurationException {
      return;
    }
  }

  static List<List<List<int>>> getNewGame([String? difficulty = 'easy']) {
    late int emptySquares;
    switch (difficulty) {
      case 'test':
        {
          emptySquares = 2;
        }
        break;
      case 'beginner':
        {
          emptySquares = 18;
        }
        break;
      case 'easy':
        {
          emptySquares = 27;
        }
        break;
      case 'medium':
        {
          emptySquares = 36;
        }
        break;
      case 'hard':
        {
          emptySquares = 54;
        }
        break;
    }
    SudokuGenerator generator = new SudokuGenerator(emptySquares: emptySquares);
    return [generator.newSudoku, generator.newSudokuSolved];
  }

  void setGame(int mode, [String? difficulty = 'easy']) {
    if (mode == 1) {
      game = new List.generate(9, (i) => [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameCopy = SudokuUtilities.copySudoku(game);
      gameSolved = SudokuUtilities.copySudoku(game);
    } else {
      gameList = getNewGame(difficulty);
      game = gameList[0];
      gameCopy = SudokuUtilities.copySudoku(game);
      gameSolved = gameList[1];
    }
  }

  void showSolution() {
    setState(() {
      game = SudokuUtilities.copySudoku(gameSolved);
      isButtonDisabled =
          !isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = true;
    });
  }

  void newGame([String? difficulty = 'easy']) {
    setState(() {
      setGame(2, difficulty);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  void restartGame() {
    setState(() {
      game = SudokuUtilities.copySudoku(gameCopy);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  Color? buttonColor(int k, int i) {
    Color? color;
    if (([0, 1, 2].contains(k) && [3, 4, 5].contains(i)) ||
        ([3, 4, 5].contains(k) && [0, 1, 2, 6, 7, 8].contains(i)) ||
        ([6, 7, 8].contains(k) && [3, 4, 5].contains(i))) {
      if (Styles.primaryBackgroundColor == Styles.darkGrey) {
        color = Styles.grey;
      } else {
        color = Colors.grey[300];
      }
    } else {
      color = Styles.primaryBackgroundColor;
    }

    return color;
  }

  double buttonSize() {
    double size = 50;
    if (SudokuState.platform!.contains('android') ||
        SudokuState.platform!.contains('ios')) {
      size = 38;
    }
    return size;
  }

  double buttonFontSize() {
    double size = 20;
    if (SudokuState.platform!.contains('android') ||
        SudokuState.platform!.contains('ios')) {
      size = 16;
    }
    return size;
  }

  BorderRadiusGeometry buttonEdgeRadius(int k, int i) {
    if (k == 0 && i == 0) {
      return BorderRadius.only(topLeft: Radius.circular(5));
    } else if (k == 0 && i == 8) {
      return BorderRadius.only(topRight: Radius.circular(5));
    } else if (k == 8 && i == 0) {
      return BorderRadius.only(bottomLeft: Radius.circular(5));
    } else if (k == 8 && i == 8) {
      return BorderRadius.only(bottomRight: Radius.circular(5));
    }
    return BorderRadius.circular(0);
  }

  List<Widget> createButtons() {
    if (firstRun) {
      setGame(1);
      firstRun = false;
    }
    MaterialColor? emptyColor;
    if (gameOver) {
      emptyColor = Styles.primaryColor;
    } else {
      emptyColor = Styles.secondaryColor;
    }
    SizedBox? sizedBox = SizedBox();
    List<SizedBox> buttonList;
    // ignore: unnecessary_null_comparison
    buttonList = [];
    for (var i = 0; i <= 8; i++) {
      buttonList.add(sizedBox);
    }

    for (var i = 0; i <= 8; i++) {
      var k = timesCalled;
      buttonList[i] = SizedBox(
        width: buttonSize(),
        height: buttonSize(),
        child: TextButton(
          onPressed: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () {
                  showAnimatedDialog<void>(
                      animationType: DialogTransitionType.fade,
                      barrierDismissible: true,
                      duration: Duration(milliseconds: 300),
                      context: context,
                      builder: (_) => AlertNumbersState()).whenComplete(() {
                    callback([k, i], AlertNumbersState.number);
                    AlertNumbersState.number = null;
                  });
                },
          onLongPress: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () => callback([k, i], 0),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(buttonColor(k, i)),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return gameCopy[k][i] == 0
                    ? emptyColor
                    : Styles.foregroundColor;
              }
              return game[k][i] == 0
                  ? buttonColor(k, i)
                  : Styles.secondaryColor;
            }),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
              borderRadius: buttonEdgeRadius(k, i),
            )),
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
              color: Styles.foregroundColor,
              width: 1,
              style: BorderStyle.solid,
            )),
          ),
          child: Text(
            game[k][i] != 0 ? game[k][i].toString() : ' ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: buttonFontSize()),
          ),
        ),
      );
    }
    timesCalled++;
    if (timesCalled == 9) {
      timesCalled = 0;
    }
    return buttonList;
  }

  Row? oneRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: createButtons(),
    );
  }

  Widget? widgetToPass;
  List<Widget> createRows() {
    SizedBox? sizedBox = SizedBox();
    List<Widget> rowList = <Widget>[];
    for (var i = 0; i <= 8; i++) {
      rowList.add(sizedBox);
    }
    for (var i = 0; i <= 8; i++) {
      rowList[i] = oneRow()!;
    }
    if (rowList != null) {
      return rowList;
    } else {
      List<Widget>? emptyList;

      return emptyList!;
    }
  }

  void callback(List<int> index, int? number) {
    setState(() {
      if (number == null) {
        return;
      } else if (number == 0) {
        game[index[0]][index[1]] = number;
      } else {
        game[index[0]][index[1]] = number;
        checkResult();
      }
    });
  }

  showOptionModalSheet(BuildContext context) {
    BuildContext outerContext = context;
    showModalBottomSheet(
        context: context,
        backgroundColor: Styles.secondaryBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          final TextStyle customStyle =
              TextStyle(inherit: false, color: Styles.foregroundColor);
          return Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.refresh, color: Styles.foregroundColor),
                title: Text('Restart Game', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 200), () => restartGame());
                },
              ),
              ListTile(
                leading: Icon(Icons.add_rounded, color: Styles.foregroundColor),
                title: Text('New Game', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 200),
                      () => newGame(currentDifficultyLevel));
                },
              ),
              ListTile(
                leading: Icon(Icons.lightbulb_outline_rounded,
                    color: Styles.foregroundColor),
                title: Text('Show Solution', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 200), () => showSolution());
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.build_outlined, color: Styles.foregroundColor),
                title: Text('Set Difficulty', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                      Duration(milliseconds: 300),
                      () => showAnimatedDialog<void>(
                              animationType: DialogTransitionType.fadeScale,
                              barrierDismissible: true,
                              duration: Duration(milliseconds: 350),
                              context: outerContext,
                              builder: (_) => AlertDifficultyState(
                                  currentDifficultyLevel)).whenComplete(() {
                            if (AlertDifficultyState.difficulty != null) {
                              Timer(Duration(milliseconds: 300), () {
                                newGame(AlertDifficultyState.difficulty);
                                currentDifficultyLevel =
                                    AlertDifficultyState.difficulty;
                                AlertDifficultyState.difficulty = null;
                                setPrefs('currentDifficultyLevel');
                              });
                            }
                          }));
                },
              ),
              ListTile(
                leading: Icon(Icons.invert_colors_on_rounded,
                    color: Styles.foregroundColor),
                title: Text('Switch Theme', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 200), () {
                    // changeTheme('switch');
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.color_lens_outlined,
                    color: Styles.foregroundColor),
                title: Text('Change Accent Color', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                      Duration(milliseconds: 200),
                      () => showAnimatedDialog<void>(
                              animationType: DialogTransitionType.fadeScale,
                              barrierDismissible: true,
                              duration: Duration(milliseconds: 350),
                              context: outerContext,
                              builder: (_) => AlertAccentColorsState(
                                  currentAccentColor)).whenComplete(() {
                            if (AlertAccentColorsState.accentColor != null) {
                              Timer(Duration(milliseconds: 300), () {
                                currentAccentColor =
                                    AlertAccentColorsState.accentColor;
                                changeAccentColor(
                                    currentAccentColor.toString());
                                AlertAccentColorsState.accentColor = null;
                                setPrefs('currentAccentColor');
                              });
                            }
                          }));
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded,
                    color: Styles.foregroundColor),
                title: Text('About', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                      Duration(milliseconds: 200),
                      () => showAnimatedDialog<void>(
                          animationType: DialogTransitionType.fadeScale,
                          barrierDismissible: true,
                          duration: Duration(milliseconds: 350),
                          context: outerContext,
                          builder: (_) => AlertAbout()));
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;

    return new WillPopScope(
      onWillPop: () async {
        await showAnimatedDialog<void>(
            animationType: DialogTransitionType.fadeScale,
            barrierDismissible: true,
            duration: Duration(milliseconds: 350),
            context: context,
            builder: (_) => AlertExit());

        return true;
      },
      child: Scaffold(
        backgroundColor: Styles.primaryBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: AppBar(
            centerTitle: true,
            title: Text('Sudoku'),
            backgroundColor: black,
          ),
        ),
        body: Builder(builder: (builder) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: createRows(),
                ),
                InkWell(
                  onTap: () {
                    showOptionModalSheet(context);
                  },
                  child: Container(
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: white,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("more .."),
                    ),
                  ),
                ),
                MFinAds()
              ],
            ),
          );
        }),
        // floatingActionButton: Container(
        //   height: screenSize.height * 0.05,
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       width: 1,
        //       color: white,
        //     ),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text("more .."),
        //   ),
        // ),

        //   FloatingActionButton(
        //     foregroundColor: Styles.primaryBackgroundColor,
        //     backgroundColor: Styles.primaryColor,
        //     onPressed: () => showOptionModalSheet(context),
        //     child: Icon(Icons.menu_rounded),
        //   ),
      ),
    );
  }
}
