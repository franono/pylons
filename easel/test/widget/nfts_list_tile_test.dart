import 'package:easel_flutter/repository/repository.dart';
import 'package:easel_flutter/screens/creator_hub/creator_hub_view_model.dart';
import 'package:easel_flutter/screens/creator_hub/widgets/nfts_list_tile.dart';
import 'package:easel_flutter/utils/constants.dart';
import 'package:easel_flutter/utils/extension_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../extensions/size_extension.dart';
import '../mock/creator_hub_viewmodel.mocks.dart';
import '../mock/mock_constants.dart';
import '../mock/mock_repository.dart';

void main() {
  final viewModel = MockCreatorHubViewModel();
  GetIt.I.registerLazySingleton<Repository>(() => MockRepositoryImp());
  GetIt.I.registerLazySingleton<CreatorHubViewModel>(() => viewModel);

  group(
    "NFTs List Tile Test",
    () {
      testWidgets(
        "Testing Banner text for Pylons NFT having price",
        (tester) async {
          await tester.setScreenSize();
          await tester.testAppForWidgetTesting(
            Scaffold(
              body: ChangeNotifierProvider(
                create: (ctx) => GetIt.I.get<CreatorHubViewModel>(),
                builder: (context, _) {
                  return NFTsListTile(
                    publishedNFT: MOCK_PRICED_NFT,
                    viewModel: viewModel,
                  );
                },
              ),
            ),
          );

          await tester.pump();
          final banner = find.byKey(Key("${MOCK_PRICED_NFT.ibcCoins.getCoinWithProperDenomination(MOCK_PRICED_NFT.price)} ${MOCK_PRICED_NFT.ibcCoins.getAbbrev()}"));
          expect(banner, findsOneWidget);
        },
      );

      testWidgets(
        "Testing Banner text for USD NFT having price",
        (tester) async {
          await tester.setScreenSize();
          await tester.testAppForWidgetTesting(
            Scaffold(
              body: ChangeNotifierProvider(
                create: (ctx) => GetIt.I.get<CreatorHubViewModel>(),
                builder: (context, _) {
                  return NFTsListTile(
                    publishedNFT: MOCK_PRICED_NFT_USD,
                    viewModel: viewModel,
                  );
                },
              ),
            ),
          );

          await tester.pump();
          final banner = find.byKey(Key("${MOCK_PRICED_NFT_USD.ibcCoins.getCoinWithProperDenomination(MOCK_PRICED_NFT_USD.price)} ${MOCK_PRICED_NFT_USD.ibcCoins.getAbbrev()}"));
          expect(banner, findsOneWidget);
        },
      );

      testWidgets(
        "Testing Price Banner for free NFT",
        (tester) async {
          await tester.setScreenSize();
          await tester.testAppForWidgetTesting(
            Scaffold(
              body: ChangeNotifierProvider(
                create: (ctx) => GetIt.I.get<CreatorHubViewModel>(),
                builder: (context, _) {
                  return NFTsListTile(
                    publishedNFT: MOCK_NFT_FREE,
                    viewModel: viewModel,
                  );
                },
              ),
            ),
          );

          await tester.pump();
          final banner = find.byKey(Key("${MOCK_NFT_FREE.ibcCoins.getCoinWithProperDenomination(MOCK_NFT_FREE.price)} ${MOCK_NFT_FREE.ibcCoins.getAbbrev()}"));

          expect(banner, findsNothing);
        },
      );
      testWidgets(
        "can user tap on whole publish tile",
        (tester) async {
          await tester.setScreenSize();
          await tester.testAppForWidgetTesting(
            Scaffold(
              body: ChangeNotifierProvider(
                create: (ctx) => GetIt.I.get<CreatorHubViewModel>(),
                builder: (context, _) {
                  return NFTsListTile(
                    publishedNFT: MOCK_PRICED_NFT,
                    viewModel: viewModel,
                  );
                },
              ),
            ),
          );

          await tester.pump();
          final publishTile = find.byKey(const Key(kNftTileKey));
          await tester.tap(publishTile);
        },
      );
    },
  );
}
