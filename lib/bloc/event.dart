abstract class BaseBlocEvent {
  final String analyticEventName;
  Map<String, dynamic>? eventProperties;

  BaseBlocEvent(this.analyticEventName, {this.eventProperties});
}