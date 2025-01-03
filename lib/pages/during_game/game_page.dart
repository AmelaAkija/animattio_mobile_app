import 'dart:async';
import 'dart:math';
import 'package:animattio_mobile_app/pages/after_game/result_page.dart';
import 'package:flutter/material.dart';

/// GamePage is a page where user completes a block of CPT test in form of one game.
///
/// This page contains of 60 randomly chosen images that are displayed for 250 ms with intervals where no image is shown between them.
///  The images are seperated by intervals, each interval lasts for 20 pictures and they are chosen randomly.
/// Values of intervals are: 1s, 2s and 4s.
///  [GamePage] has three parameters [listOfImages], [stimuli] and [mode].
///
class GamePage extends StatefulWidget {
  /// [stimuli] randomly chosen on InstructionPage.
  final String stimuli;

  /// [listOfImages] is a list of images corresponding to chosen theme.
  final List<String> listOfImages;

  /// [mode] is the chosen mode on ModePage.
  final String mode;

  /// Creates a [GamePage].
  const GamePage(
      {super.key,
      required this.stimuli,
      required this.listOfImages,
      required this.mode});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  /// [currentImage] is the currently displayed image.
  String? currentImage;

  /// [lastShownImage] is the last displayed image.
  String? lastShownImage;

  /// [shownImages] is a list of all of the images that were shown.
  List<String> shownImages = [];

  /// [shuffledList] is a list of all of the images that were shown.
  List<String> shuffledList = [];

  /// [tappedImages] is a list of boolean values - true when image of given index was tapped and false if not.
  List<bool> tappedImages = [];

  /// [count] is used to keep track how many images were shown.
  int count = 0;

  /// [lastIndex] is used to help track what image was tapped.
  int lastIndex = 0;

  /// [showTimer] is the length of image display and interval.
  Timer? showTimer;

  /// [hideTimer] is the length of image display - 250 ms.
  ///  It waits for 250 ms and then hides any image shown
  Timer? hideTimer;

  /// [startTime] indicates the moment the image was shown.
  DateTime? startTime;

  /// [endTime] indicates the moment image was tapped.
  DateTime? endTime;

  /// [reactionTime] is one of the parameters of the test.
  /// It is a difference between [endTime] and [startTime].
  Duration? reactionTime;

  /// [rT] is an integer value of [reactionTime].
  int? rT = 0;

  /// [intervals] is a list of available times of one cycle - interval time in ms + 250 ms
  List<int> intervals = [1250, 2250, 4250];

  /// [orderOfIntervals] is a list that saves the order the intervals appeared.
  List<int> orderOfIntervals = [];

  /// [reactionTimes] is a list of all of the calculated [rT] parameters.
  List<int> reactionTimes = [];

  /// [imagesToShow] creates a list of 20 random images from [listOfImages].
  ///
  /// It ensures the stimuli appears at least twice in list. All of the added images are shuffled to ensure they will be displayed randomly.
  ///
  ///   /// Returns:
  /// - A [List<String>] containing the random images to show during the game.
  List<String> imagesToShow() {
    List<String> listOfRandomImages = [];

    // Instance of [Random] to pick random stimuli
    Random random = Random();
    // Amount of stimulis in one list
    listOfRandomImages.add(widget.stimuli);
    listOfRandomImages.add(widget.stimuli);

    print("After adding target stimuli: $listOfRandomImages");
    // List without stimuli
    List<String> nonTargetImages = List.from(widget.listOfImages);
    nonTargetImages
        .remove(widget.stimuli); 

    while (listOfRandomImages.length < 20) {
      String image = nonTargetImages[random.nextInt(nonTargetImages.length)];
      listOfRandomImages.add(image);

      print("Img $image");
      print("Stimuli ${widget.stimuli}");
    }

    // Shuffle the list to randomize the order of images
    listOfRandomImages.shuffle(random);
    print("After adding image: $listOfRandomImages");
    return listOfRandomImages;
  }

  /// [initState] is the first method invoked when the state object is inserted into the widget tree.
  ///
  /// It is used to call the [startGame] method, responsible for showing the first 20 images of the game
  /// and for initializing a [tappedImages] list and filling it with boolean values.
  ///
  @override
  void initState() {
    super.initState();
    tappedImages = List.filled(61, false);
    shuffledList = imagesToShow();
    print("test: $shuffledList");
    startGame();
  }

  /// [startGame] method is responsible for showing the first 20 images of the game.
  ///
  /// It picks randomly the first value of the interval that will be displayed for all of the 20 images and adds it to [orderOfIntervals]
  /// simultaneously removing it from the [intervals] list to ensure the values are not repeated.
  ///
  /// The method sets the [showTimer] with picked value and displays all of the twenty images
  ///  picked from [imagesToShow] function, calling [setState] and [startTime] every time new image is shown.
  ///  All of the show images are added to [shownImages].
  ///
  ///  The method checks if [count] reached two values 60 and 20:
  /// if it reached 60 then it navigates to the ResultPage while passing the
  /// parameters [shownImages], [tappedImages], [stimuli], [mode], [reactionTimes], [orderOfIntervals],
  /// if it reached 20 then it calls the [continueGame] function.
  ///
  void startGame() {
    int interval = intervals.elementAt(Random().nextInt(intervals.length));
    orderOfIntervals.add(interval);
    // first interval
    for (int i = 0; i < intervals.length; i++) {
      if (interval == intervals[i]) {
        intervals.removeAt(i);
      }
    }
    // if 60 images were shown end the game
    showTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (count >= 60) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes,
              intervals: orderOfIntervals,
            );
          }),
        );
      } else {
        /// move on to continueGame()
        if (count >= 20) {
          timer.cancel();
          continueGame();
          return;
        }
        setState(() {
          List<String> block1 = shuffledList;
          currentImage = block1[count % block1.length]; // calculates the remainder when count is divided by block1.length
          print("block1 $block1");
          startTime = DateTime.now();
          lastShownImage = currentImage;
          shownImages.add(currentImage!);
          lastIndex++;
          // ignore: avoid_print
          print("Images shown ${shownImages.length}");
          print("Stimuli: ${widget.stimuli}");
          print("Interval $interval");
          count++;
        });

        hideTimer = Timer(const Duration(milliseconds: 250), () { // Ensures that each image is visible only 250 milliseconds
          setState(() {
            currentImage = null;
          });
        });
      }
    });
  }

  /// [continueGame] method is responsible for showing the next 20 images of the game (from 20 to 40).
  ///
  /// It picks randomly the second value of the interval that will be displayed for all of the 20 images and adds it to [orderOfIntervals].
  ///
  /// The method sets the [showTimer] with picked value and displays all of the twenty images
  ///  picked from [imagesToShow] function, calling [setState] and [startTime] every time new image is shown.
  ///  All of the show images are added to [shownImages].
  ///
  ///  The method checks if [count] reached two values 60 and 40:
  /// if it reached 60 then it navigates to the ResultPage while passing the
  /// parameters [shownImages], [tappedImages], [stimuli], [mode], [reactionTimes], [orderOfIntervals],
  /// if it reached 40 then it calls the [endGame] function.
  ///
  void continueGame() {
    List<String> block2 = shuffledList;
          block2.shuffle();
    int interval = intervals.elementAt(Random().nextInt(intervals.length));
    orderOfIntervals.add(interval);
    for (int i = 0; i < intervals.length; i++) {
      if (interval == intervals[i]) {
        intervals.removeAt(i);
      }
    }
    // if 60 images were shown end the game
    showTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (count >= 60) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes,
              intervals: orderOfIntervals,
            );
          }),
        );
      } else {
          // move on to endGame()
        if (count >= 40) {
          timer.cancel();
          endGame();
          return;
        }
        setState(() {
                    print("block2: $block2");

          currentImage = block2[count % block2.length];
          startTime = DateTime.now();
          lastShownImage = currentImage;
          shownImages.add(currentImage!);
          lastIndex++;
          // ignore: avoid_print
          print("Images shown ${shownImages.length}");
          print("Stimuli: ${widget.stimuli}");
          print("Interval $interval");

          count++;
        });

        hideTimer = Timer(const Duration(milliseconds: 250), () { // Ensures that each image is visible only 250 milliseconds
          setState(() {
            currentImage = null;
          });
        });
      }
    });
  }

  /// [continueGame] method is responsible for showing the last 20 images of the game (from 40 to 60).
  ///
  /// It picks the last value of the intervals list that will be displayed for all of the 20 images and adds it to [orderOfIntervals].
  ///
  /// The method sets the [showTimer] with picked value and displays all of the twenty images
  ///  picked from [imagesToShow] function, calling [setState] and [startTime] every time new image is shown.
  ///  All of the show images are added to [shownImages].
  ///
  ///  The method checks if [count] reached 60:
  /// if yes then it navigates to the ResultPage while passing the
  /// parameters [shownImages], [tappedImages], [stimuli], [mode], [reactionTimes], [orderOfIntervals],
  ///
  void endGame() {
        List<String> block3 = shuffledList;
          block3.shuffle();
          print("block3: $block3");
    int interval = intervals.elementAt(Random().nextInt(intervals.length));
    orderOfIntervals.add(interval);
    // if 60 images were shown end the game
    showTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (count >= 60) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes,
              intervals: orderOfIntervals,
            );
          }),
        );
      } else {
        setState(() {
                    print("block3: $block3");
          currentImage = block3[count % block3.length];
          startTime = DateTime.now();
          lastShownImage = currentImage;
          shownImages.add(currentImage!);
          lastIndex++;
          // ignore: avoid_print
          print("Images shown ${shownImages.length}");
          print("Stimuli: ${widget.stimuli}");
          print("Interval $interval");

          count++;
        });

        hideTimer = Timer(const Duration(milliseconds: 250), () {
          setState(() {
            currentImage = null;
          });
        });
      }
    });
  }

  /// [tappedImage] method is responsible for tracking which images were tapped.
  ///
  /// It sets the value of [endTime] and calculates [reactionTime] of every tapped image,
  /// then convert it into [rT] parameter and adds it to [reactionTimes].
  ///
  /// The method sets the [showTimer] with picked value and displays all of the twenty images
  ///  picked from [imagesToShow] function, calling [setState] and [startTime] every time new image is shown.
  ///  All of the show images are added to [shownImages].
  ///
  ///  The method checks the value of [lastIndex] and then sets the value of [tappedImages] with given index to true
  ///  indicating that image with this index was tapped.
  ///
  void tappedImage() {
    if (!tappedImages[lastIndex]) { // check if the value of tappedImages[lastIndex] is false to prevent double tap
      endTime = DateTime.now();
      reactionTime = endTime!.difference(startTime!);
      rT = reactionTime?.inMilliseconds;

      print("Current mode: ${widget.mode}");
      print("Last shown image: $lastShownImage");
      print("Stimuli: ${widget.stimuli}");

      if ((widget.mode ==
                  'Kliknij na ekran tylko wtedy, gdy wyświetlony jest dany symbol' &&
              lastShownImage == widget.stimuli) ||
          (widget.mode ==
                  'Kliknij na ekran tylko wtedy, gdy dany symbol NIE jest wyświetlany' &&
              lastShownImage != widget.stimuli) ||
              (widget.mode == "Click on the screen only when given symbol is displayed" &&  lastShownImage == widget.stimuli) ||
                (widget.mode == "Click on the screen only when given symbol is NOT displayed" &&  lastShownImage != widget.stimuli) ||
          (widget.mode == 'mode1' && lastShownImage == widget.stimuli) ||
          (widget.mode == 'mode2' && lastShownImage != widget.stimuli)) {
        print("Adding reaction time $reactionTime");
        reactionTimes.add(rT!);
      } else {
        print("Condition not met, reaction time not added.");
      }

      tappedImages[lastIndex] = true;

      // ignore: avoid_print
      print("Tapped image $lastIndex");
    } else {
      print("Image $lastIndex already tapped");
    }
  }

  @override

  /// [dispose] function disposes of the timers when the widget is removed from the widget tree.
  void dispose() {
    showTimer?.cancel();
    hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Color definitions used throughout the page.
    Color pageColor = const Color(0xFFFEFFD9);
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child:
    Scaffold(
      backgroundColor: pageColor,
      body: GestureDetector(
        // When screen is tapped the tappedImage() function is called
        onTap: () => tappedImage(),
        // Display of the value of current image, if it is null displays transparent container if not Image.asset
        child: Center(
          child: currentImage != null
              ? Image.asset(currentImage!)
              : Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
      ),
    ));
  }
}
