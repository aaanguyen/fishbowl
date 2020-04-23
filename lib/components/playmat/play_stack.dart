import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fishbowl/providers/data.dart';

bool buttonTrigger = false;
enum SwiperPosition { None, Left, Right }
enum AnimationType { None, Move, Manual, Rewind }

class Swipable {
  final object;
  Widget Function(SwiperPosition, double progress) builder;

  Swipable({this.object, this.builder});
}

class PlayStack extends StatefulWidget {
  int numberOfRounds;
  int currentRound;
//  bool scoreByPoints = false;

  final List<Swipable> children;
  final int threshold;
  final int translationInterval;
  final double scaleInterval;
  final EdgeInsetsGeometry padding;

  final int historyCount;
  final void Function(int, SwiperPosition) onSwipe;
  final void Function(int, SwiperPosition) onRewind;
  final void Function() onEnd;
  final int visibleCount;

  PlayStack({
    Key key,
    @required this.children,
    this.threshold = 30,
    this.translationInterval = 0,
    this.scaleInterval = 0,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
    this.historyCount = 1,
    this.onSwipe,
    this.onRewind,
    this.onEnd,
    this.visibleCount = 2,
  })  : assert(threshold >= 1 && threshold <= 100),
        assert(visibleCount >= 2),
        assert(translationInterval >= 0),
        assert(scaleInterval >= 0),
        assert(historyCount >= 0),
        super(key: key);

  @override
  PlayStackState createState() => PlayStackState();
}

class PlayStackState extends State<PlayStack>
    with SingleTickerProviderStateMixin {
  Animation<double> _xAnimation;
  Animation<double> _yAnimation;
  AnimationController _playStackController;

  double _left = 0;
  double _top = 0;
  final List<Map<String, dynamic>> _history = [];

  double _progress = 0;
  SwiperPosition _currentItemPosition = SwiperPosition.None;

  bool _isTop = false;
  bool _isLeft = false;

  AnimationType _animationType = AnimationType.None;

  BoxConstraints _baseContainerConstraints;

  int get currentIndex => widget.children.length - 1;

  @override
  void initState() {
    _playStackController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _playStackController.addListener(() {
      Provider.of<Data>(context, listen: false).updateCardsRemaining(
          (widget.children.length == 0)
              ? Provider.of<Data>(context, listen: false).deckSize
              : widget.children.length);
      // if anything has moved at all, update _left, _top, _progress, _currentItemPosition
      if (_playStackController.status == AnimationStatus.forward) {
        if (_xAnimation != null) {
          _left = _xAnimation.value;
        }
        if (_yAnimation != null) {
          _top = _yAnimation.value;
        }
        if (buttonTrigger) {
          _progress = (100 / _baseContainerConstraints.maxWidth) *
              (_yAnimation.value * 0.75).abs();
        } else {
          _progress = (100 / _baseContainerConstraints.maxWidth) * _left.abs();
        }
        _currentItemPosition = (_left.toInt() == 0)
            ? SwiperPosition.None
            : (_left.toInt() < 0) ? SwiperPosition.Left : SwiperPosition.Right;
        setState(() {});
      }
    });

    _playStackController.addStatusListener((status) {
      // once the last animation is complete
      if (status == AnimationStatus.completed) {
        // add current item and corresponding info to _history
        if (_animationType != AnimationType.Rewind &&
            _animationType != AnimationType.None) {
          if (widget.historyCount > 0) {
            _history.add({
              'item': widget.children[widget.children.length - 1],
              'position': _currentItemPosition,
              'left': _left,
              'top': _top,
              'object': widget.children[widget.children.length - 1].object
            });
            // remove item from head of history queue if full
            if (_history.length > widget.historyCount) {
              _history.removeAt(0);
            }
          }
          // if animation was rewind
        } else if (_animationType == AnimationType.Rewind) {
          // if an onRewind function exists, do it with (length of stack - 1) and the last historic item's SwiperPosition
          if (widget.onRewind != null) {
            widget.onRewind(widget.children.length - 1,
                _history[_history.length - 1]['position']);
          }
          // remove item from tail of history queue
          _history.removeAt(_history.length - 1);
        }

        // if current animation is not None and not Rewind
        if (_animationType != AnimationType.None &&
            _animationType != AnimationType.Rewind) {
          if (_animationType == AnimationType.Move) {
            widget.children.insert(
                0, widget.children.elementAt(widget.children.length - 1));
          }
          if (buttonTrigger) {
            Provider.of<Data>(context, listen: false).addToCurrentTeamScore(
                widget.children[widget.children.length - 1].object['value']);
            print(
                'team ${Provider.of<Data>(context, listen: false).countingScoreForTeam1 ? '1' : '2'} just got ${widget.children[widget.children.length - 1].object['value']} points, total is now ${Provider.of<Data>(context, listen: false).countingScoreForTeam1 ? Provider.of<Data>(context, listen: false).team1Score : Provider.of<Data>(context, listen: false).team2Score}');
          }
          widget.children.removeAt(widget.children.length - 1);

          // if an onSwipe function exists
          if (widget.onSwipe != null) {
            widget.onSwipe(widget.children.length, _currentItemPosition);
          }
        }

        _left = 0;
        _top = 0;
        _progress = 0;
        _currentItemPosition = SwiperPosition.None;
        _animationType = AnimationType.None;
        setState(() {});
        _playStackController.reset();
        buttonTrigger = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    for (var obj in widget.children) {
//      print('${obj.object['name']}');
//    }
    widget.numberOfRounds = Provider.of<Data>(context).numberOfRounds;
    widget.currentRound = Provider.of<Data>(context).currentRound;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      _baseContainerConstraints = constraints;

      if (widget.children.length == 0) return Container();

      return Container(
        padding: widget.padding,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              overflow: Overflow.visible,
              fit: StackFit.expand,
              children: widget.children
                  .asMap()
                  .map((int index, _) {
                    return MapEntry(index, _item(constraints, index));
                  })
                  .values
                  .toList(),
            );
          },
        ),
      );
    });
  }

  Widget _item(BoxConstraints constraints, int index) {
    if (index != widget.children.length - 1) {
      double scaleReduced =
          (widget.scaleInterval * (widget.children.length - index));
      scaleReduced -= ((widget.scaleInterval * 2) / 100) * _progress;
      final double scale = 1 - scaleReduced;

      double positionReduced =
          ((widget.translationInterval * (widget.children.length - index - 1)))
              .toDouble();
      positionReduced -= (widget.translationInterval / 100) * _progress;
      final double position = positionReduced * -1;

      return Visibility(
        visible: (widget.children.length - index) <= widget.visibleCount,
        child: Positioned(
            bottom: position,
            child: Transform.scale(
                scale: scale,
                alignment: Alignment.bottomCenter,
                child: Container(
                    constraints: constraints,
                    child: widget.children[index]
                        .builder(SwiperPosition.None, 0)))),
      );
    }

    return Positioned(
      left: _left,
      top: _top,
      child: GestureDetector(
          child: Container(
              constraints: constraints,
              child: widget.children[index]
                  .builder(_currentItemPosition, _progress)),
          onPanStart: (DragStartDetails dragStartDetails) {
            RenderBox getBox = context.findRenderObject();
            var local = getBox.globalToLocal(dragStartDetails.globalPosition);

            _isLeft = local.dx < getBox.size.width / 2;
            _isTop = local.dy < getBox.size.height / 2;

            double halfHeight = getBox.size.height / 2;
          },
          onPanUpdate: (DragUpdateDetails dragUpdateDetails) {
            _left += dragUpdateDetails.delta.dx;
            _top += dragUpdateDetails.delta.dy;

            _progress =
                (100 / _baseContainerConstraints.maxWidth) * _left.abs();
            _currentItemPosition = (_left.toInt() == 0)
                ? SwiperPosition.None
                : (_left < 0) ? SwiperPosition.Left : SwiperPosition.Right;
            setState(() {});
          },
          onPanEnd: _onPandEnd),
    );
  }

  void _onPandEnd(_) {
    setState(() {});
    if (_progress < widget.threshold) {
      _goFirstPosition();
    } else {
      _animationType = AnimationType.Move;
      _xAnimation = Tween<double>(
              begin: _left,
              end: _baseContainerConstraints.maxWidth * (_left < 0 ? -1 : 1))
          .animate(_playStackController);
      _yAnimation = Tween<double>(begin: _top, end: _top + _top)
          .animate(_playStackController);
      _playStackController.forward();
    }
  }

  void _goFirstPosition() {
    _xAnimation =
        Tween<double>(begin: _left, end: 0.0).animate(_playStackController);
    _yAnimation =
        Tween<double>(begin: _top, end: 0.0).animate(_playStackController);
    _playStackController.forward();
  }

  void swipeLeft() {
    if (widget.children.length > 0 &&
        _playStackController.status != AnimationStatus.forward) {
      _animationType = AnimationType.Manual;
      _xAnimation =
          Tween<double>(begin: 0, end: _baseContainerConstraints.maxWidth * -1)
              .animate(_playStackController);
      _yAnimation = Tween<double>(
              begin: 0, end: (_baseContainerConstraints.maxHeight / 2) * -1)
          .animate(_playStackController);
      _playStackController.forward();
    }
  }

  void swipeRight() {
    if (widget.children.length > 0 &&
        _playStackController.status != AnimationStatus.forward) {
      _animationType = AnimationType.Manual;
      _xAnimation =
          Tween<double>(begin: 0, end: _baseContainerConstraints.maxWidth)
              .animate(_playStackController);
      _yAnimation = Tween<double>(
              begin: 0, end: (_baseContainerConstraints.maxHeight / 2) * -1)
          .animate(_playStackController);
      _playStackController.forward();
    }
  }

  void rewind() {
    if (_history.length > 0 &&
        _playStackController.status != AnimationStatus.forward) {
      _animationType = AnimationType.Rewind;

      final lastHistory = _history[_history.length - 1];

      widget.children.add(lastHistory["item"]);
      _xAnimation = Tween<double>(begin: lastHistory["left"], end: 0)
          .animate(_playStackController);
      _yAnimation = Tween<double>(begin: lastHistory["top"], end: 0)
          .animate(_playStackController);
      _playStackController.forward();
    }
  }

  void cardGuessed() {
//    setState(() {});
    _animationType = AnimationType.Manual;
    buttonTrigger = true;
    _xAnimation =
        Tween<double>(begin: 0.0, end: 0.0).animate(_playStackController);
    _yAnimation =
        Tween<double>(begin: _top, end: _baseContainerConstraints.maxHeight)
            .animate(_playStackController);
    _playStackController.forward();
//    currentTeam.incrementScore(widget.scoreByPoints,
//        widget.children[widget.children.length - 1].object['value']);
    if (widget.children.length == 1 && widget.onEnd != null) {
      Provider.of<Data>(context, listen: false).updateCurrentRound();
      widget.onEnd();
    }
  }

  void clearHistory() => _history.clear();

  @override
  void dispose() {
    _playStackController.dispose();
    super.dispose();
  }
}
