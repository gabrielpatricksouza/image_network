abstract class BoxFitWeb {
  /// Abstract const constructor to enable subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const BoxFitWeb();

  static const Fit fill = Fit("fill");
  static const Fit cover = Fit("cover");
  static const Fit contain = Fit("contain");
  static const Fit scaleDown = Fit("scale-down");

  String name(Fit instance) => instance.fit;
}

class Fit extends BoxFitWeb {
  /// Creates a fit String.
  const Fit(this.fit);
  final String fit;
}
