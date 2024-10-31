// import 'package:skeen/cores/cores.dart';
// import 'package:skeen/features/features.dart';

// class MedicalHistoryView extends StatelessWidget {
//   const MedicalHistoryView({super.key});

//   static const String route = '/medical_history';
//   @override
//   Widget build(BuildContext context) {
//     return BaseScaffold(
//       body: Column(
//         children: [
//           Center(
//             child: ImageWidget(
//               url: Assets.medicalHistory,
//             ),
//           ),
//           kXtremeLarge.verticalSpace,
//           const TextWidget(
//             'Medical history',
//             fontWeight: w600,
//             fontSize: kfsExtraLarge,
//             textColor: Palette.primaryColor,
//           ),
//           kfs8.verticalSpace,
//           const TextWidget(
//             'We would like to ask you some questions to get your medical records.',
//             textAlign: TextAlign.center,
//           ),
//           kXtremeLarge.verticalSpace,
//           Button(
//             onTap: () => goTo(MedicalInfoView.route),
//             text: 'Continue',
//           ),
//           kfsTiny.verticalSpace,
//           Button(
//             text: 'Skip',
//             color: Palette.backgroundColor,
//             onTap: () => clearPath(NavBarView.route),
//             textColor: Palette.primaryColor,
//           )
//         ],
//       ),
//       useSingleScroll: true,
//     );
//   }
// }
