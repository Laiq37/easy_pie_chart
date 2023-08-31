part of easy_pie_chart;

enum PieType { crust, triCrust, fill }

/// Extracts the values of each [PieData]. If [gap] > 0.0, includes gaps between values.
List<double> getValues(List<PieData> pies, double gap) {
  final List<double> pieValues = [];
  for (var pie in pies) {
    if (gap > 0.0) {
      pieValues.addAll([pie.value, gap]);
    } else {
      pieValues.add(pie.value);
    }
  }
  return pieValues;
}

/// Calculates the angle from given x and y coordinates and the pie chart [size].
double getAngleFromCordinates(
    double xCordinate, double yCordinate, double size) {
  return getPositiveAngle(
      atan2(yCordinate - size, xCordinate - size) * 180 / pi);
}

/// Converts a potentially negative angle to its positive equivalent.
double getPositiveAngle(double tapAngle) {
  if (tapAngle > -180 && tapAngle < 0) {
    tapAngle = 180 + (180 + tapAngle);
  }
  return tapAngle;
}

/// Converts an angle to the range between 0 and 360 degrees.
double getAngleIn360(double startAngle) {
  if (startAngle < 0) {
    startAngle = startAngle % 360;
    startAngle = 360 + startAngle;
  }
  startAngle = startAngle % 360;
  return startAngle;
}

/// Checks whether the current pie slice is tapped.
bool isCurrentPieTap(double startAngle, double sweepAngle, double tapAngle) {
  if (startAngle <= sweepAngle) {
    if (startAngle <= tapAngle && tapAngle <= sweepAngle) {
      return true;
    }
  } else {
    if (startAngle <= tapAngle || tapAngle <= sweepAngle) {
      return true;
    }
  }
  return false;
}

/// Gets the index of the tapped pie slice.
int? getIndexOfTappedPie(
    List<double> pieValues, double total, double gap, startAngle, tapAngle) {
  for (int i = 0; i < pieValues.length; i++) {
    double pieAngle = (2 * pi * (pieValues[i] / total)) * 180 / pi;
    double j = 0;
    while (j <= (gap > 0.0 ? i % 2 : 0)) {
      double sweepAngle =
          (startAngle + (pieAngle * (gap > 0.0 && i % 2 == 1 ? 0.25 : 1))) %
              360;
      if (isCurrentPieTap(startAngle, sweepAngle, tapAngle)) {
        final int index = gap > 0.0
            ? i % 2 == 1
                ? j == 0
                    ? (i - 1) ~/ 2
                    : i + 1 < pieValues.length
                        ? (i + 1) ~/ 2
                        : 0
                : i ~/ 2
            : i;
        return index;
      }
      startAngle = (startAngle +
              (pieAngle *
                  (gap > 0.0 && i % 2 == 1
                      ? j == 0
                          ? 0.75
                          : 0.25
                      : 1))) %
          360;
      j++;
    }
  }
  return null;
}
