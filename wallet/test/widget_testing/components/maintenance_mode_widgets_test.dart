import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pylons_wallet/components/maintenance_mode_widgets.dart';
import 'package:pylons_wallet/pages/home/home.dart';
import 'package:pylons_wallet/services/third_party_services/remote_config_service/remote_config_service.dart';
import '../extension/size_extension.dart';

// class MockRemoteConfigService extends Mock implements RemoteConfigService {
//   @override
//   bool getMaintenanceMode() {
//     return true;
//   }
// }

class MockRemoteConfigService extends Mock implements RemoteConfigService {}

@GenerateMocks([MockRemoteConfigService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late RemoteConfigService remoteConfigService;
  remoteConfigService = MockRemoteConfigService();
  GetIt.I.registerLazySingleton<RemoteConfigService>(() => remoteConfigService);


  testWidgets('test case for maintenance mode banner widget', (tester) async {
    when(remoteConfigService.getMaintenanceMode()).thenAnswer((realInvocation) => true);
    await tester.setScreenSize();
    await tester.testAppForWidgetTesting(const HomeScreen());
    await tester.pumpAndSettle();
    final maintenanceModeBannerWidget = find.byType(MaintenanceModeBannerWidget);
    await tester.ensureVisible(maintenanceModeBannerWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(maintenanceModeBannerWidget, findsOneWidget);
  });
}
