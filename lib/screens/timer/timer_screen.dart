import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _currentTab = 0;

  // Stopwatch
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _stopwatchTimer;

  // Countdown Timer
  Duration _timerDuration = const Duration(minutes: 1);
  Timer? _countdownTimer;
  Duration _currentTimer = const Duration(minutes: 1);
  int _inputMinutes = 1;
  int _inputSeconds = 0;

  // Alarm
  TimeOfDay? _alarmTime;
  Timer? _alarmTimer;

  @override
  void initState() {
    super.initState();
    _startStopwatchTimer();
    _initializeTimeZone();
  }

  Future<void> _initializeTimeZone() async {
    final location = await FlutterTimezone.getLocalTimezone();
    print('Current time zone: $location');
  }

  void _startStopwatchTimer() {
    _stopwatchTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _currentTimer = _timerDuration;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentTimer.inSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _currentTimer -= const Duration(seconds: 1);
        });
      }
    });
  }

  void _setAlarm(TimeOfDay time) {
    final now = DateTime.now();
    final alarmDateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final difference = alarmDateTime.difference(now);
    if (difference.isNegative) return;

    _alarmTimer?.cancel();
    _alarmTimer = Timer(difference, () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alarm Triggered!')),
      );
    });
  }

  @override
  void dispose() {
    _stopwatchTimer.cancel();
    _countdownTimer?.cancel();
    _alarmTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenCom(
      children: [
        const SizedBox(height: 20),
        _buildTabBar(),
        const SizedBox(height: 20),
        _buildTabContent(),
      ],
    );
  }

  Widget _buildTabBar() {
    const tabs = ['Stopwatch', 'Timer', 'Alarm'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        tabs.length,
        (i) => GestureDetector(
          onTap: () => setState(() => _currentTab = i),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: _currentTab == i ? Colors.pink[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              tabs[i],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _currentTab == i ? Colors.pink[800] : Colors.grey[700],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_currentTab) {
      case 0:
        return _buildStopwatch();
      case 1:
        return _buildTimer();
      case 2:
        return _buildAlarm();
      default:
        return Container();
    }
  }

  Widget _buildStopwatch() {
    final elapsed = _stopwatch.elapsed;
    final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (elapsed.inMilliseconds.remainder(1000) ~/ 100).toString();

    return Column(
      children: [
        Text('$minutes:$seconds.$milliseconds',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _stopwatch.start,
              child: const Text("Start"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _stopwatch.stop,
              child: const Text("Stop"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _stopwatch.reset();
                setState(() {});
              },
              child: const Text("Reset"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimer() {
    final minutes = _currentTimer.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _currentTimer.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Column(
      children: [
        Text('$minutes:$seconds', style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Min'),
                onChanged: (value) => _inputMinutes = int.tryParse(value) ?? 0,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 70,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Sec'),
                onChanged: (value) => _inputSeconds = int.tryParse(value) ?? 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _timerDuration = Duration(minutes: _inputMinutes, seconds: _inputSeconds);
              _currentTimer = _timerDuration;
            });
            _startCountdownTimer();
          },
          child: const Text("Start Timer"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _currentTimer = _timerDuration;
            });
          },
          child: const Text("Reset Timer"),
        ),
      ],
    );
  }

  Widget _buildAlarm() {
    return Column(
      children: [
        if (_alarmTime != null)
          Text('Alarm set for: ${_alarmTime!.format(context)}', style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
            if (time != null) {
              setState(() => _alarmTime = time);
              _setAlarm(time);
            }
          },
          child: const Text("Set Alarm"),
        )
      ],
    );
  }
}
