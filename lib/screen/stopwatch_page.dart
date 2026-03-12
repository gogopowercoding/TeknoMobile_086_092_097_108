import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Timer? _timer;
  int _elapsedMilliseconds = 0;
  bool _isRunning = false;
  final List<int> _laps = [];

  void _startPause() {
    if (_isRunning) {
      _pause();
      return;
    }

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedMilliseconds += 10;
      });
    });

    setState(() {
      _isRunning = true;
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _elapsedMilliseconds = 0;
      _isRunning = false;
      _laps.clear();
    });
  }

  void _lap() {
    if (!_isRunning) return;
    setState(() {
      _laps.insert(0, _elapsedMilliseconds);
    });
  }

  String _formatTime(int ms) {
    final hours = ms ~/ Duration.millisecondsPerHour;
    final minutes = (ms % Duration.millisecondsPerHour) ~/ Duration.millisecondsPerMinute;
    final seconds = (ms % Duration.millisecondsPerMinute) ~/ Duration.secondsPerMinute;
    final centis = (ms % Duration.secondsPerMinute) ~/ 10 % 100;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${centis.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${centis.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatTime(_elapsedMilliseconds),
                    style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _startPause,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                        child: Text(_isRunning ? 'Pause' : 'Start'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _reset,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          backgroundColor: Colors.redAccent,
                        ),
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _lap,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Lap'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: _laps.isEmpty
                  ? const Center(child: Text('No lap recorded yet', style: TextStyle(fontSize: 16)))
                  : ListView.separated(
                      itemCount: _laps.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final lapTime = _laps[index];
                        return ListTile(
                          title: Text('Lap ${_laps.length - index}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(_formatTime(lapTime), style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()])),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
