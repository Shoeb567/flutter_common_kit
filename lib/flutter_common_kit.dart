/// A production-ready, batteries-included toolkit for Flutter applications.
/// Provides reusable UI components, centralized Dio API services, local & secure storage,
/// connectivity detection, error handling, models, and utility functions.
library flutter_common_kit;

// Initialization Hub
export 'src/flutter_common_kit_init.dart';

// Configuration
export 'src/config/app_environment.dart';
export 'src/config/common_kit_config.dart';

// Constants
export 'src/constants/app_constants.dart';
export 'src/constants/app_dimensions.dart';

// Theme
export 'src/theme/common_colors.dart';
export 'src/theme/common_text_styles.dart';
export 'src/theme/common_theme.dart';

// Network & API
export 'src/network/api_interceptors.dart';
export 'src/network/api_service.dart';
export 'src/network/network_exceptions.dart';

// Storage
export 'src/storage/auth_storage_helper.dart';
export 'src/storage/secure_storage_service.dart';
export 'src/storage/storage_service.dart';

// Connectivity
export 'src/connectivity/connectivity_listener.dart';
export 'src/connectivity/connectivity_service.dart';

// Error Handling
export 'src/error_handling/app_error.dart';
export 'src/error_handling/error_handler.dart';

// Models
export 'src/models/api_response.dart';
export 'src/models/api_result.dart';
export 'src/models/pagination_model.dart';

// Utilities
export 'src/utils/app_logger.dart';
export 'src/utils/currency_utils.dart';
export 'src/utils/datetime_utils.dart';
export 'src/utils/debouncer.dart';
export 'src/utils/json_utils.dart';

// Validators
export 'src/validators/validators.dart';

// Extensions
export 'src/extensions/context_extensions.dart';
export 'src/extensions/num_extensions.dart';
export 'src/extensions/string_extensions.dart';

// Widgets
export 'src/widgets/common_app_bar.dart';
export 'src/widgets/buttons/common_button.dart';
export 'src/widgets/feedback/common_bottom_sheet.dart';
export 'src/widgets/feedback/common_dialogs.dart';
export 'src/widgets/feedback/common_snackbar.dart';
export 'src/widgets/layout/common_card.dart';
export 'src/widgets/layout/common_container.dart';
export 'src/widgets/layout/common_dividers.dart';
export 'src/widgets/layout/responsive_helper.dart';
export 'src/widgets/loaders/common_loader.dart';
export 'src/widgets/loaders/common_shimmer.dart';
export 'src/widgets/states/common_empty_widget.dart';
export 'src/widgets/states/common_error_widget.dart';
export 'src/widgets/states/no_internet_widget.dart';
export 'src/widgets/text_fields/common_input_decoration.dart';
export 'src/widgets/text_fields/common_text_field.dart';
