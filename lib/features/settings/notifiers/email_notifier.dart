import 'package:skeen/cores/cores.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final emailLauncherProvider = Provider<EmailLauncher>((ref) => EmailLauncher());

class EmailLauncher {
  Future<void> sendEmail({
    required String to,
    String subject = '',
    String body = '',
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client';
    }
  }
}

class EmailButton extends ConsumerWidget {
  const EmailButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Button(
      onTap: () async {
        try {
          await ref.read(emailLauncherProvider).sendEmail(
                to: 'emeleonufavour15@gmail.com',
                subject: 'Message from Skeen User',
                body: '',
              );
        } catch (e) {
          Toast.showErrorToast(message: e.toString());
          AppLogger.logError(e.toString(), tag: "EmailButton");
        }
      },
      text: "Send a message",
    );
  }
}
