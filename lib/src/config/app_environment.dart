/// Environment types for multi-environment deployments.
enum EnvironmentType {
  development,
  staging,
  production,
}

/// Helper model for holding environment-specific configuration values.
class AppEnvironment {
  final EnvironmentType type;
  final String name;
  final String baseUrl;
  final Map<String, dynamic> extraConfig;

  const AppEnvironment({
    required this.type,
    required this.name,
    required this.baseUrl,
    this.extraConfig = const {},
  });

  bool get isDevelopment => type == EnvironmentType.development;
  bool get isStaging => type == EnvironmentType.staging;
  bool get isProduction => type == EnvironmentType.production;
}
