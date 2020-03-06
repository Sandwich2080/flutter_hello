import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

typedef ValueChanged<T1, T2,T3> = void Function(T1, T2,T3);

class MyHorizontalDragGestureRecognizer
    extends HorizontalDragGestureRecognizer {
  final ValueChanged<bool, double,double> onVelocityChanged;

  final Map<int, VelocityTracker> _velocityTrackers = <int, VelocityTracker>{};

  MyHorizontalDragGestureRecognizer({Object debugOwner, this.onVelocityChanged})
      : super(debugOwner: debugOwner);

  @override
  void handleEvent(PointerEvent event) {
    super.handleEvent(event);
    if (!event.synthesized &&
        (event is PointerDownEvent || event is PointerMoveEvent)) {
      final VelocityTracker tracker = _velocityTrackers[event.pointer];
      assert(tracker != null);
      tracker.addPosition(event.timeStamp, event.position);
    }
  }

  @override
  void addPointer(PointerEvent event) {
    super.addPointer(event);
    _velocityTrackers[event.pointer] = VelocityTracker();
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    final double minVelocity = minFlingVelocity ?? kMinFlingVelocity;
    final double minDistance = minFlingDistance ?? kTouchSlop;
    final VelocityTracker tracker = _velocityTrackers[pointer];

    /// 计算速度
    final VelocityEstimate estimate = tracker.getVelocityEstimate();
    bool isFling = false;
    if (estimate != null && estimate.pixelsPerSecond != null) {
      isFling = estimate.pixelsPerSecond.dx.abs() > minVelocity &&
          estimate.offset.dx.abs() > minDistance;
    }

    if (onVelocityChanged != null) {
      onVelocityChanged(isFling, estimate.pixelsPerSecond.dx,estimate.pixelsPerSecond.dy);
    }

    _velocityTrackers.clear();

    super.didStopTrackingLastPointer(pointer);
  }

  @override
  void dispose() {
    _velocityTrackers.clear();
    super.dispose();
  }
}
