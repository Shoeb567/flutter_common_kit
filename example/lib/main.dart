import 'package:flutter/material.dart';
import 'package:flutter_common_kit/flutter_common_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the package
  await FlutterCommonKit.initialize(
    config: const CommonKitConfig(
      appName: 'CommonKit Showcase',
      baseUrl: 'https://jsonplaceholder.typicode.com',
      enableLogging: true,
      primaryColor: Color(0xFF2563EB),
    ),
  );

  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterCommonKit Demo',
      debugShowCheckedModeBanner: false,
      theme: CommonTheme.lightTheme(FlutterCommonKit.config),
      darkTheme: CommonTheme.darkTheme(FlutterCommonKit.config),
      themeMode: _themeMode,
      home: HomeScreen(
        onToggleTheme: _toggleTheme,
        isDark: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storageKeyController = TextEditingController();
  final _storageValueController = TextEditingController();
  String _storedValue = 'Not set';
  bool _isLoadingApi = false;
  String? _apiResultText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _storageKeyController.dispose();
    _storageValueController.dispose();
    super.dispose();
  }

  // Example API call
  Future<void> _fetchExampleData() async {
    setState(() {
      _isLoadingApi = true;
      _apiResultText = null;
    });

    final result = await FlutterCommonKit.api.get('/posts/1');

    setState(() {
      _isLoadingApi = false;
    });

    result.when(
      success: (response) {
        setState(() {
          _apiResultText = 'Title: ${response.rawData?['title'] ?? 'N/A'}';
        });
        if (mounted) {
          CommonSnackbar.showSuccess(
            context,
            title: 'API Success',
            message: 'Post fetched successfully!',
          );
        }
      },
      failure: (error) {
        setState(() {
          _apiResultText = 'Error: ${error.message}';
        });
        if (mounted) {
          CommonSnackbar.showError(
            context,
            title: 'API Failure',
            message: error.message,
          );
        }
      },
    );
  }

  // Example storage operation
  Future<void> _saveToStorage() async {
    final key = _storageKeyController.text.trim();
    final value = _storageValueController.text.trim();
    if (key.isEmpty || value.isEmpty) {
      CommonSnackbar.showWarning(
        context,
        message: 'Please enter both key and value.',
      );
      return;
    }

    await FlutterCommonKit.storage.setString(key, value);
    setState(() {
      _storedValue = FlutterCommonKit.storage.getString(key) ?? 'N/A';
    });
    if (mounted) {
      CommonSnackbar.showToast(context, message: 'Saved to storage!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityListenerWidget(
      connectivityService: FlutterCommonKit.connectivity,
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'FlutterCommonKit',
          actions: [
            IconButton(
              icon: Icon(
                widget.isDark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: widget.onToggleTheme,
              tooltip: 'Toggle Theme',
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildUiTab(),
            _buildFeedbackTab(),
            _buildNetworkStorageTab(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.widgets_outlined),
              selectedIcon: Icon(Icons.widgets),
              label: 'UI Components',
            ),
            NavigationDestination(
              icon: Icon(Icons.feedback_outlined),
              selectedIcon: Icon(Icons.feedback),
              label: 'Feedback',
            ),
            NavigationDestination(
              icon: Icon(Icons.cloud_outlined),
              selectedIcon: Icon(Icons.cloud),
              label: 'API & Storage',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUiTab() {
    return SingleChildScrollView(
      padding: AppDimensions.paddingScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Form Fields & Validation', style: CommonTextStyles.titleMedium),
          8.verticalSpace,
          CommonTextField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'john@example.com',
            prefixIcon: const Icon(Icons.email_outlined),
            validator: Validators.compose([
              Validators.required,
              Validators.email,
            ]),
          ),
          12.verticalSpace,
          CommonPasswordField(
            controller: _passwordController,
            validator: Validators.password,
          ),
          20.verticalSpace,
          const Text('Buttons', style: CommonTextStyles.titleMedium),
          12.verticalSpace,
          CommonButton(
            text: 'Primary Button',
            icon: const Icon(Icons.check, color: Colors.white, size: 18),
            onPressed: () {
              CommonSnackbar.showToast(context, message: 'Primary button clicked');
            },
          ),
          12.verticalSpace,
          CommonOutlinedButton(
            text: 'Outlined Button',
            onPressed: () {
              CommonSnackbar.showToast(context, message: 'Outlined button clicked');
            },
          ),
          12.verticalSpace,
          CommonButton.secondary(
            text: 'Secondary Button',
            onPressed: () {},
          ),
          20.verticalSpace,
          const Text('Cards & Containers', style: CommonTextStyles.titleMedium),
          12.verticalSpace,
          CommonCard(
            onTap: () {
              CommonSnackbar.showToast(context, message: 'Card tapped');
            },
            child: const Row(
              children: [
                Icon(Icons.verified, color: CommonColors.primary, size: 32),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reusable Card', style: CommonTextStyles.titleSmall),
                      Text(
                        'Supports elevation, borders, padding, and tap callbacks.',
                        style: CommonTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          const Text('Shimmer & Loaders', style: CommonTextStyles.titleMedium),
          12.verticalSpace,
          const CommonShimmerListTile(),
          12.verticalSpace,
          const CommonLoader(message: 'Loading preview...'),
        ],
      ),
    );
  }

  Widget _buildFeedbackTab() {
    return SingleChildScrollView(
      padding: AppDimensions.paddingScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Dialogs & Sheets', style: CommonTextStyles.titleMedium),
          12.verticalSpace,
          CommonButton(
            text: 'Show Confirmation Dialog',
            onPressed: () async {
              final confirmed = await CommonDialogs.confirm(
                context,
                title: 'Delete Item?',
                message: 'Are you sure you want to delete this record?',
                isDestructive: true,
                confirmText: 'Delete',
              );
              if (mounted) {
                CommonSnackbar.showToast(
                  context,
                  message: confirmed ? 'Confirmed' : 'Cancelled',
                );
              }
            },
          ),
          12.verticalSpace,
          CommonButton(
            text: 'Show Modal Bottom Sheet',
            backgroundColor: CommonColors.secondary,
            onPressed: () {
              CommonBottomSheet.show(
                context,
                title: 'Quick Filter',
                child: Column(
                  children: [
                    const Text('Configure bottom sheet contents with drag handle.'),
                    16.verticalSpace,
                    CommonButton(
                      text: 'Close Sheet',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
          20.verticalSpace,
          const Text('Snackbars & Alerts', style: CommonTextStyles.titleMedium),
          12.verticalSpace,
          CommonButton(
            text: 'Show Success SnackBar',
            backgroundColor: CommonColors.success,
            onPressed: () {
              CommonSnackbar.showSuccess(
                context,
                title: 'Operation Completed',
                message: 'Your profile updates have been saved.',
              );
            },
          ),
          12.verticalSpace,
          CommonButton(
            text: 'Show Error SnackBar',
            backgroundColor: CommonColors.error,
            onPressed: () {
              CommonSnackbar.showError(
                context,
                title: 'Operation Failed',
                message: 'Unable to connect to the authentication server.',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkStorageTab() {
    return SingleChildScrollView(
      padding: AppDimensions.paddingScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('API Service (Dio)', style: CommonTextStyles.titleMedium),
          8.verticalSpace,
          const Text(
            'Endpoint: https://jsonplaceholder.typicode.com/posts/1',
            style: CommonTextStyles.bodySmall,
          ),
          12.verticalSpace,
          CommonButton(
            text: 'Make GET Request',
            isLoading: _isLoadingApi,
            onPressed: _fetchExampleData,
          ),
          if (_apiResultText != null) ...[
            12.verticalSpace,
            CommonContainer(
              padding: const EdgeInsets.all(12),
              color: widget.isDark ? CommonColors.slate800 : CommonColors.slate100,
              borderRadius: 8,
              child: Text(
                _apiResultText!,
                style: CommonTextStyles.bodyMedium,
              ),
            ),
          ],
          24.verticalSpace,
          const CommonDivider(),
          20.verticalSpace,
          const Text('Local Preferences Storage', style: CommonTextStyles.titleMedium),
          12.verticalSpace,
          CommonTextField(
            controller: _storageKeyController,
            label: 'Key',
            hint: 'e.g. username',
          ),
          12.verticalSpace,
          CommonTextField(
            controller: _storageValueController,
            label: 'Value',
            hint: 'e.g. John Doe',
          ),
          12.verticalSpace,
          CommonButton(
            text: 'Save to Local Storage',
            onPressed: _saveToStorage,
          ),
          12.verticalSpace,
          Text(
            'Retrieved Value: $_storedValue',
            style: CommonTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          24.verticalSpace,
          const CommonDivider(),
          20.verticalSpace,
          const Text('Internet Connectivity Status', style: CommonTextStyles.titleMedium),
          12.verticalSpace,
          StreamBuilder<bool>(
            stream: FlutterCommonKit.connectivity.onConnectivityChanged,
            initialData: FlutterCommonKit.connectivity.isOnline,
            builder: (context, snapshot) {
              final online = snapshot.data ?? true;
              return Row(
                children: [
                  Icon(
                    online ? Icons.wifi : Icons.wifi_off,
                    color: online ? CommonColors.success : CommonColors.error,
                  ),
                  12.horizontalSpace,
                  Text(
                    online ? 'Internet Connected (Verified)' : 'Offline',
                    style: CommonTextStyles.bodyMedium.copyWith(
                      color: online ? CommonColors.success : CommonColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
