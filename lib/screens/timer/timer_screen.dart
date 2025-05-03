import 'dart:async';
import 'package:brain_buddy/config/app_color.dart';
import 'package:flutter/material.dart';
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
  int _inputMinutes = 0;
  int _inputSeconds = 0;

  // Alarm
  TimeOfDay? _alarmTime;
  Timer? _alarmTimer;

  @override
  void initState() {
    super.initState();
    _startStopwatchTimer();
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
    final alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final difference = alarmDateTime.difference(now);
    if (difference.isNegative) return;

    _alarmTimer?.cancel();
    _alarmTimer = Timer(difference, () {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Alarm Triggered!')));
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
              color: _currentTab == i ? AppColors.primary : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              tabs[i],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    _currentTab == i
                        ? AppColors.textPrimary
                        : AppColors.primary,
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
    final milliseconds =
        (elapsed.inMilliseconds.remainder(1000) ~/ 100).toString();

    return Padding(
      padding: const EdgeInsets.only(top: 110),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        height: 300,
        width: double.infinity,

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$minutes:$seconds.$milliseconds',
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _stopwatch.start,
                    child: const Text(
                      "Start",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _stopwatch.stop,
                    child: const Text(
                      "Stop",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _stopwatch.reset();
                      setState(() {});
                    },
                    child: const Text(
                      "Reset",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final minutes = _currentTimer.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = _currentTimer.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.only(top: 110),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        height: 350,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$minutes:$seconds',
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Min'),
                      onChanged:
                          (value) => _inputMinutes = int.tryParse(value) ?? 0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Sec'),
                      onChanged:
                          (value) => _inputSeconds = int.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _timerDuration = Duration(
                          minutes: _inputMinutes,
                          seconds: _inputSeconds,
                        );
                        _currentTimer = _timerDuration;
                      });
                      _startCountdownTimer();
                    },
                    child: const Text(
                      "Start Timer",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentTimer = _timerDuration;
                      });
                    },
                    child: const Text(
                      "Reset Timer",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _countdownTimer?.cancel();
                      setState(() {
                        _currentTimer = Duration.zero;
                      });
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TimeOfDay> _alarmHistory = [];

  Widget _buildAlarm() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          children: [
            StreamBuilder<DateTime>(
              stream: Stream.periodic(
                const Duration(seconds: 1),
                (_) => DateTime.now(),
              ),
              builder: (context, snapshot) {
                final time = snapshot.data ?? DateTime.now();
                final formattedTime =
                    "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
                return Text(
                  formattedTime,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        timePickerTheme: const TimePickerThemeData(
                          dialBackgroundColor: Colors.white,
                          dialHandColor: AppColors.secondary,
                          dialTextColor: AppColors.primary,
                          entryModeIconColor: AppColors.primary,
                          hourMinuteTextColor: AppColors.primary,
                          hourMinuteColor: Color.fromARGB(255, 238, 235, 235),
                          backgroundColor: Colors.white,
                        ),
                        colorScheme: ColorScheme.light(
                          primary: AppColors.primary, // for OK/Cancel button
                          onSurface: AppColors.primary, // for text color
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (time != null) {
                  setState(() {
                    _alarmTime = time;
                    _alarmHistory.add(time);
                    _setAlarm(time);
                  });
                }
              },
              child: const Text(
                "Set Alarm",
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 20),
            if (_alarmHistory.isNotEmpty) ...[
              const Text(
                "Past Alarms:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: _alarmHistory.length,
                  itemBuilder: (context, index) {
                    final time = _alarmHistory[index];
                    return ListTile(
                      leading: const Icon(
                        Icons.alarm,
                        color: AppColors.primary,
                      ),
                      title: Text(
                        time.format(context),
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
