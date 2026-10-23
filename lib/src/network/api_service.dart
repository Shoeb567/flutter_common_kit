import 'dart:io';
import 'package:dio/dio.dart';
import '../config/common_kit_config.dart';
import '../error_handling/error_handler.dart';
import '../models/api_response.dart';
import '../models/api_result.dart';
import 'api_interceptors.dart';

/// Centralized HTTP client providing type-safe and resilient network operations.
class ApiService {
  late final Dio _dio;
  final CommonKitConfig config;

  ApiService({
    required this.config,
    Dio? dioClient,
  }) {
    _dio = dioClient ??
        Dio(
          BaseOptions(
            baseUrl: config.baseUrl ?? '',
            connectTimeout: config.connectTimeout,
            receiveTimeout: config.receiveTimeout,
            sendTimeout: config.sendTimeout,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              ...config.defaultHeaders,
            },
          ),
        );

    // Register default interceptors
    _dio.interceptors.addAll([
      AuthInterceptor(config: config),
      AppLoggingInterceptor(enableLogging: config.enableLogging),
    ]);
  }

  /// Direct access to underlying [Dio] instance for advanced customizations.
  Dio get client => _dio;

  /// Helper to convert a raw dynamic response into an [ApiResponse<T>].
  ApiResponse<T> _parseResponse<T>(
    Response response,
    T Function(dynamic data)? decoder,
  ) {
    final raw = response.data;
    String? message;
    dynamic dataPayload = raw;
    dynamic errors;

    if (raw is Map<String, dynamic>) {
      message = raw['message']?.toString() ?? raw['msg']?.toString();
      if (raw.containsKey('data')) {
        dataPayload = raw['data'];
      }
      if (raw.containsKey('errors')) {
        errors = raw['errors'];
      }
    }

    T? parsedData;
    if (dataPayload != null) {
      if (decoder != null) {
        parsedData = decoder(dataPayload);
      } else if (dataPayload is T) {
        parsedData = dataPayload;
      }
    }

    return ApiResponse<T>(
      isSuccess: true,
      data: parsedData,
      message: message,
      statusCode: response.statusCode,
      errors: errors,
      rawData: raw,
    );
  }

  /// Executes an HTTP request safely, catching exceptions and returning [ApiResult<ApiResponse<T>>].
  Future<ApiResult<ApiResponse<T>>> _executeRequest<T>({
    required Future<Response> Function() request,
    T Function(dynamic data)? decoder,
  }) async {
    try {
      final response = await request();
      final parsed = _parseResponse<T>(response, decoder);
      return Success(parsed);
    } catch (e, stack) {
      final appError = ErrorHandler.handleError(e, stack);
      return Failure(appError);
    }
  }

  // ==================== HTTP METHODS ==================== //

  /// GET request.
  Future<ApiResult<ApiResponse<T>>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    T Function(dynamic data)? decoder,
  }) {
    return _executeRequest<T>(
      request: () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
      decoder: decoder,
    );
  }

  /// POST request.
  Future<ApiResult<ApiResponse<T>>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(dynamic data)? decoder,
  }) {
    return _executeRequest<T>(
      request: () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      decoder: decoder,
    );
  }

  /// PUT request.
  Future<ApiResult<ApiResponse<T>>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(dynamic data)? decoder,
  }) {
    return _executeRequest<T>(
      request: () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      decoder: decoder,
    );
  }

  /// PATCH request.
  Future<ApiResult<ApiResponse<T>>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(dynamic data)? decoder,
  }) {
    return _executeRequest<T>(
      request: () => _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      decoder: decoder,
    );
  }

  /// DELETE request.
  Future<ApiResult<ApiResponse<T>>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic data)? decoder,
  }) {
    return _executeRequest<T>(
      request: () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      decoder: decoder,
    );
  }

  // ==================== FILE OPERATIONS ==================== //

  /// Uploads a single file using multipart/form-data.
  Future<ApiResult<ApiResponse<T>>> uploadFile<T>(
    String path, {
    required File file,
    String fileFieldName = 'file',
    String? customFileName,
    Map<String, dynamic>? extraFields,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    T Function(dynamic data)? decoder,
  }) async {
    try {
      final fileName = customFileName ?? file.path.split(Platform.pathSeparator).last;
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );

      final formData = FormData.fromMap({
        fileFieldName: multipartFile,
        if (extraFields != null) ...extraFields,
      });

      return await post<T>(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options ?? Options(contentType: 'multipart/form-data'),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        decoder: decoder,
      );
    } catch (e, stack) {
      return Failure(ErrorHandler.handleError(e, stack));
    }
  }

  /// Uploads multiple files using multipart/form-data.
  Future<ApiResult<ApiResponse<T>>> uploadMultipleFiles<T>(
    String path, {
    required List<File> files,
    String fileFieldName = 'files',
    Map<String, dynamic>? extraFields,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    T Function(dynamic data)? decoder,
  }) async {
    try {
      final multipartFiles = <MultipartFile>[];
      for (final f in files) {
        final fileName = f.path.split(Platform.pathSeparator).last;
        multipartFiles.add(
          await MultipartFile.fromFile(f.path, filename: fileName),
        );
      }

      final formData = FormData();
      if (extraFields != null) {
        extraFields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }
      for (final file in multipartFiles) {
        formData.files.add(MapEntry(fileFieldName, file));
      }

      return await post<T>(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options ?? Options(contentType: 'multipart/form-data'),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        decoder: decoder,
      );
    } catch (e, stack) {
      return Failure(ErrorHandler.handleError(e, stack));
    }
  }

  /// Downloads a file from [urlPath] to the local destination [savePath].
  Future<ApiResult<String>> downloadFile(
    String urlPath, {
    required String savePath,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Options? options,
  }) async {
    try {
      await _dio.download(
        urlPath,
        savePath,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );
      return Success(savePath);
    } catch (e, stack) {
      return Failure(ErrorHandler.handleError(e, stack));
    }
  }
}
