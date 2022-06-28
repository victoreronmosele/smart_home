/// Holds information about the normal level of a routine
class NormalLevel {
  /// The highest normal threshold for a routine
  double? maximum;

  /// The lowest normal threshold for a routine
  double? minimum;

  NormalLevel({required this.maximum, required this.minimum})
      : assert(maximum != null && minimum != null,
            'maximum and minimum can not both be null');
}
