# LinguaFlow Flutter SDK

LinguaFlow'un uzak çeviri, çevrimdışı fallback, tip güvenli anahtar ve mobil uygulama bütünlüğü özelliklerini Flutter uygulamalarına taşır.

## Kurulum

```yaml
dependencies:
  linguaflow_sdk: ^0.1.0
```

CLI ile `.linguaconfig` içindeki branch key kullanılarak immutable build bundle'ları ve tip güvenli anahtarlar üretilir:

```bash
linguaflow sync
```

```dart
import 'package:linguaflow_sdk/linguaflow_sdk.dart';

final client = LinguaFlowClient(
  config: const LinguaFlowConfig(branchKey: 'br_live_…'),
  cache: LocalizationCache(),
);

await client.initialize(deviceLocale: 'tr-TR');
```

Çalışma zamanı önce güncel uzak release'i kullanır; ağ yoksa cihaz önbelleğine, o da yoksa build sırasında paketlenen JSON'a düşer. Açık kullanıcı seçimi cihaz dilinden önceliklidir. Sunucu locale route ve fallback kararını manifestte döndürür.

App Attest ve Play Integrity sağlayıcıları opt-in olarak eklenebilir. Üretim anahtarlarını kaynak koda koymayın; branch key herkese açık bir kimliktir, bütünlük grant'i sunucu tarafından kısa ömürlü üretilir.

Missing-key telemetrisi açıldığında SDK uygulama sürüm adı ve build/version code bilgisini iOS ve
Android host uygulamasından platform channel ile otomatik okur. Config'teki `appVersion` yalnız test
veya özel sürüm etiketi gerektiğinde kullanılan opsiyonel override'dır.

Bir App Attest veya Play Integrity provider yapılandırıldığında SDK bundle indirme/parse, Delivery
API ve ICU sonuçlarını toplu runtime telemetrisi olarak gönderir. Sunucu yalnız bütünlük doğrulamalı
raporları otomatik rollout sağlık kapılarına dahil eder.

Ayrıntılı kurulum ve güvenlik akışları repository içindeki `docs/` klasöründedir.
