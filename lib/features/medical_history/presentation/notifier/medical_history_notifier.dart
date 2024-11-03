import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

final medicalHistoryProvider =
    NotifierProvider<MedicalHistoryNotifier, AppState<Map<int, String>>>(
  MedicalHistoryNotifier.new,
);

class MedicalHistoryNotifier extends Notifier<AppState<Map<int, String>>>
    with NotifierHelper<Map<int, String>> {
  late final MedicalHistoryRepository _medicalHistoryRepository;
  late final SessionManager _sessionManager;

  static const int totalQuestions = 5;

  final List<String> _questions = [
    'Do you have any existing skin conditions (e.g. acne, eczema)?',
    'Have you noticed recent changes in your skin?',
    'Are you using any skincare products or medications?',
    'Do you have allergies to skincare ingredients?',
    'Is there a family history of skin conditions?',
  ];

  @override
  AppState<Map<int, String>> build() {
    _medicalHistoryRepository = ref.read(medicalHistoryRepositoryProvider);
    _sessionManager = ref.read(sessionManagerProvider);
    final savedHistory = _sessionManager.getMedicalHistory();
    if (savedHistory != null) {
      final Map<int, String> indexedAnswers = {};
      savedHistory.forEach((question, answer) {
        final index = _questions.indexOf(question);
        if (index != -1) {
          indexedAnswers[index] = answer;
        }
      });
      return AppState.initial(data: indexedAnswers);
    }
    return AppState.initial(data: {});
  }

  void setResponse(int questionIndex, String response) {
    state = state.copyWith(
      data: {...state.data ?? {}, questionIndex: response},
    );
    _sessionManager.storeMedicalHistory(_getQuestionsAndAnswers);
  }

  bool canMoveNext(int currentIndex) {
    return state.data?[currentIndex] != null;
  }

  bool isCompleted() {
    return state.data?.length == totalQuestions &&
        !state.data!.containsValue(null);
  }

  void reset() {
    state = AppState.initial(data: {});
    _sessionManager.deleteStoredBuiltInType(medicalHistoryKey);
  }

  Map<String, dynamic> get _getQuestionsAndAnswers {
    final Map<String, dynamic> result = {};
    state.data?.forEach((key, value) {
      result[_questions[key]] = value;
    });
    return result;
  }

  Future<void> uploadMedicalHistory() async {
    // notifyOnLoading();

    // final res = await _medicalHistoryRepository
    //     .uploadMedicalHistory(_getQuestionsAndAnswers);
    AppLogger.logSuccess("Here are your answers $_getQuestionsAndAnswers");
    await _sessionManager.storeMedicalHistory(_getQuestionsAndAnswers);

    // res.fold(
    //   (l) {
    //     notifyOnError(state_: state, error: l);
    //   },
    //   (r) {
    notifyOnSuccess(state_: state);
    //   },
    // );
  }
}
