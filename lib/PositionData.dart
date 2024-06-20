/// A class to represent the current position, buffered position, and duration of an audio track.
class PositionData {
  /// The current position of the audio track.
  /// This is the current playback position.
  final Duration position;

  /// The buffered position of the audio track.
  /// This indicates how much of the audio track has been buffered and is available for playback.
  final Duration bufferedPosition;

  /// The total duration of the audio track.
  /// This is the total length of the audio track.
  final Duration duration;

  /// Creates an instance of [PositionData] with the given [position], [bufferedPosition], and [duration].
  PositionData(this.position, this.bufferedPosition, this.duration);
}
