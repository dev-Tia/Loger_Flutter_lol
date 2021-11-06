# KeyStore 폴더경로
- [flutter] 프로젝트폴더 상위 ../ [GitHub] 와 같은 경로에 [KeyStore] 폴더

# KeyStore (절대 유출금지!!!)
- storePassword=System.getenv('KeyStorePassword')
- keyPassword=System.getenv('KeyPassword')
- keyAlias=System.getenv('Key')
- storeFile=System.getenv('KeyStore')

# 빌드방법
- F5 - 에뮬레이터 실행 (flutter run 과 동일 하지만 apk 를 생성하지는 않는다)
- flutter run - debug apk 를 생성하고 연결된 기계로 실행한다
- 
- flutter clean - 현재 빌드되어있는(혹은 이뮤트 되어있는) 모든 빌드파일을 삭제한다
  
> # 아래 부터는 패키징 Key 있어야 함
> - flutter build {XXX} - XXX 파일로 빌드시킨다(relese Mode)
> - flutter install - 위에서 빌드한 파일을 인스톨한다
> - (연결된 기계가 여럿일경우 flutter -d device_ID install)

# Android
- Select your firebase project
- Select Android
- Open terminal inside your flutter project
- cd android
- ./gradlew signingReport or gradlew signingReport
- Paste your package name and your SHA1 key
- Download Client Information
- Download and replace the google-services.json
- flutter clean
- 
# IOS:
- Select your Firebase project
- Select IOS
- Enter your Bundle ID
- Download credetials
- Download and replace GoogleService-info.plist

### AndroidManifest.xml의 package="com.example.loger_lol_flutter" 를 수정하면 릴리즈 빌드 안됨

> ### webview_flutter: ^0.3.19+9 추가후 usesCleartextTraffic 권한설정
> android:usesCleartextTraffic="true"

> ### Flutter 앱에 AdMob 광고 달기 (firebase_admob)
> https://clein8.tistory.com/entry/Flutter-%EC%95%B1%EC%97%90-Admob-%EA%B4%91%EA%B3%A0-%EB%8B%AC%EA%B8%B0-firebaseadmob?category=711806
> firebase_core, firebase_admob 패키지 추가
> AndroidManifest.xml파일에 [ADMOB_APP_ID] 입력




import 'package:provider/provider.dart';
import 'package:gaap/Providers/CheckProvider.dart';

final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);
providerCheckOS.getadUnitID