import '../../../home/data/model/gemma_response.dart';

class ProductScannerState {
  final bool isLoading;
  final GemmaResponse? scanResult;
  final String? error;

  ProductScannerState({
    this.isLoading = false,
    this.scanResult,
    this.error,
  });

  ProductScannerState copyWith({
    bool? isLoading,
    GemmaResponse? scanResult,
    String? error,
  }) {
    return ProductScannerState(
      isLoading: isLoading ?? this.isLoading,
      scanResult: scanResult ?? this.scanResult,
      error: error ?? this.error,
    );
  }
}
