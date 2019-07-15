import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

///
/// https://github.com/roughike/streaming_shared_preferences
///
class Prefs {
  final PrefStreams streams;
  final String name;

  Prefs(String name, StreamingSharedPreferences preferences) : streams = PrefStreams(preferences), name = name;

  int get lastTappedTimeMs => streams.lastTappedTimeMs.getValue();

  set lastTappedTimeMs(value) => streams.lastTappedTimeMs.setValue(value);

}

class PrefStreams {
  PrefStreams(StreamingSharedPreferences preferences) : lastTappedTimeMs = preferences.getInt("last_tapped_time_ms", defaultValue: 0);
  final Preference<int> lastTappedTimeMs;
}
