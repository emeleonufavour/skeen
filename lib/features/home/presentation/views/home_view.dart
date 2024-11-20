import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

import '../widgets/recommendation_section.dart';

class TipsAndTricksService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a single image to Firebase Storage
  Future<String> _uploadImage(String imagePath, String fileName) async {
    try {
      final File imageFile = File(imagePath);
      final Reference storageRef =
          _storage.ref().child('tips_images/$fileName');

      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image');
    }
  }

  Future<void> setupTipsAndTricks() async {
    try {
      final CollectionReference tipsCollection =
          _firestore.collection('tips_and_tricks');

      // Tips and tricks data with local image paths
      final List<Map<String, dynamic>> tipsAndTricks = [
        {
          "localImagePath": Assets.healthyFood,
          "fileName": "healthy_food.jpg",
          "title": "Eat Well",
          "tip":
              "Include fruits, veggies, and healthy fats in your diet for glowing skin.",
        },
        {
          "localImagePath": Assets.manDrinking,
          "fileName": "man_drinking.jpg",
          "title": "Stay Hydrated",
          "tip":
              "Drink plenty of water throughout the day for plump, healthy-looking skin.",
        },
        {
          "localImagePath": Assets.nightSkinCare,
          "fileName": "night_skincare.jpg",
          "title": "Night Routine",
          "tip":
              "Never skip your nighttime skincare. Always remove makeup before bed.",
        },
        {
          "localImagePath": Assets.skinCareOil,
          "fileName": "skincare_oil.jpg",
          "title": "Face Oils",
          "tip":
              "Use facial oils for extra moisture and nourishment when needed.",
        },
        {
          "localImagePath": Assets.womanSun,
          "fileName": "woman_sun.jpg",
          "title": "Sun Smart",
          "tip":
              "Apply SPF 30+ daily, even on cloudy days. Your future skin will thank you!",
        },
      ];

      // Use a batch write for Firestore
      final WriteBatch batch = _firestore.batch();

      // Process each tip
      for (var tip in tipsAndTricks) {
        // Upload image and get URL
        final String imageUrl =
            await _uploadImage(tip['localImagePath'], tip['fileName']);

        // Create the document data
        final Map<String, dynamic> docData = {
          "img": imageUrl, // Store the Firebase Storage URL
          "title": tip['title'],
          "tip": tip['tip'],
          "created_at": FieldValue.serverTimestamp(),
        };

        // Add to batch
        DocumentReference docRef = tipsCollection.doc();
        batch.set(docRef, docData);
      }

      // Commit the batch
      await batch.commit();
      print('Successfully uploaded all tips and images');
    } catch (e) {
      print('Error setting up tips and tricks: $e');
      throw Exception('Failed to setup tips and tricks');
    }
  }
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String route = '/home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(userDetailsNotifier.notifier).execute();
        ref.read(getTipsAndTrickNotifier.notifier).execute();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(userDetailsNotifier).data;
    return BaseScaffold(
      body: Column(
        children: [
          HomeAppBar(
            name: userDetails?.fullName ?? '',
          ),
          kfsMedium.verticalSpace,
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const TipsAndTrickWidget(),
                const SkeenActivities(),
                const RecommendationSection(),
                // (screenHeight * .1).verticalSpace,
              ].separate(kGlobalPadding.verticalSpace),
            ).padding(horizontal: kfsExtraLarge.w, vertical: 0),
          ).expand(),
        ],
      ),
      padding: EdgeInsets.zero,
      useSingleScroll: false,
    );
  }
}
