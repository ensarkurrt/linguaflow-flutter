import 'package:flutter/widgets.dart';

import 'linguaflow_client.dart';
import 'linguaflow_models.dart';

class LinguaFlowProvider extends InheritedNotifier<LinguaFlowClient> {
  const LinguaFlowProvider({
    super.key,
    required LinguaFlowClient client,
    required super.child,
  }) : super(notifier: client);

  static LinguaFlowClient of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LinguaFlowProvider>();
    assert(
        provider != null, 'LinguaFlowProvider is missing above this widget.');
    return provider!.notifier!;
  }
}

class LinguaFlowScope extends LinguaFlowProvider {
  const LinguaFlowScope({
    super.key,
    required LinguaFlowClient client,
    required super.child,
  }) : super(client: client);

  static LinguaFlowClient of(BuildContext context) =>
      LinguaFlowProvider.of(context);
}

extension LinguaFlowText on BuildContext {
  String lf(LfKey key,
          {Map<String, Object> arguments = const {}, String fallback = ''}) =>
      LinguaFlowProvider.of(this)
          .resolve(key, arguments: arguments, fallback: fallback);
}
