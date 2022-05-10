
## 코딩규칙
코딩 규칙은 Google 팀의 pedantic 룰을 따른다. [여기에서](https://pub.dev/packages/pedantic)
상세 내용을 확인할 수 있다. Dart 에서 공식으로 추천하는 lint 스타일인
[Effective Dart](https://dart.dev/guides/language/effective-dart)
에서 [몇가지 추가사항](https://pub.dev/packages/pedantic#stricter-than-effective-dart)
이 포함된 룰이다. Coding Standard 는 언제까지나 가독성을 위한 것이기 때문에
언제든 협의를 통해 변경할 수 있다. 기본으로 사용되지 않는 lint 룰은 [여기서](https://pub.dev/packages/pedantic#unused-lints)
확인 가능하고 기본으로 사용되는 lint 룰은 [여기서](https://github.com/google/pedantic/blob/master/lib/analysis_options.1.9.0.yaml)
확인 가능하다. `flutter analyze` 를 실행하면 린트를 실행할 수 있다.

## 폴더구조
```
+-- android
+-- assets (이미지, 폰트 및 앱에 탑재되는 static 파일)
+-- build
+-- ios
+-- lib
|   +-- components (컴포넌트 폴더)
|   +-- controllers (GetX 컨트롤러 - ViewModel)
|   +-- layouts (스크린 레아이웃 폴더)
|   +-- models (모델 폴더)
|   +-- services (서비스 폴더)
|   +-- screens (스크린 위젯 폴더)
|   +-- utils (공용 함수 폴더 - Form Validation 등)
```

## components

### 컴포넌트 폴더 구조
Building Block 이 되는 위젯들이 위치하는 공간이다. 각 컴포넌트를 타입별로
정리하고 각 타입의 이름을 그대로 따온 파일에 각 타입의 컴포넌트들을 export 한다.

**예제**
```
+-- components
|       +-- default_card.dart
|       +-- card.dart
|       +-- card.dart (default_card 및 card 모두 export)
```

### 위젯 코드정리
각 컴포넌트의 세부 위젯들은 공유가 되는 위젯들이 아니면 위젯 내부의 함수를 사용해서
코드 정리를 한다. 더 나아가 최상위 위젯의 `build` 함수에는 최대한 위젯을 직접
코딩하지 않도록 한다. 각 컴포넌트를 최대한 세부 위젯으로 나눠서 해당 세부 위젯을
리턴해주는 함수 또는 또다른 위젯을 코딩하여 `build` 함수를 위젯 구조대로
정리한다. 레이아웃이나 Row 또는 Column 등 위치를 세팅하는 위젯은 `build` 함수에
사용해도 된다.

**예제**
*Good*
```
renderCenterMessage() {
    return Text(
        '스플래시 스크린\n토큰 체크 후 메인화면 또는 로그인 화면 이동',
        textAlign: TextAlign.center,
    );
}

renderNextPageButton(){
    return RaisedButton(
        child: Text(
            '홈 이동',
        ),
        onPressed: () {
            Get.toNamed('/');
        },
    );
}

build (ctx) {
    return Column(
        children: [
            renderCenterMessage(),
            renderNextPageButton(),
        ],
    );
}
```
*bad*
```
build (ctx) {
    return Column(
        children: [
            Text(
                '스플래시 스크린\n토큰 체크 후 메인화면 또는 로그인 화면 이동',
                textAlign: TextAlign.center,
            ),
            RaisedButton(
                child: Text(
                    '홈 이동',
                ),
                onPressed: () {
                    Get.toNamed('/');
                },
            ),
        ],
    );
}
```

> 컴포넌트를 세로로 나누면 어떻게 정리해야 할지 감이 온다.
> 위에서 아래 방향으로 봤을때 확실히 성격이 다른 위젯들끼리 나눠주면 된다.
> 기능상의 목적보단 가독성의 영역이기 때문에 가독성을 해치지 않는 한에서
> 자유롭게 위젯을 나눠주면 된다.
> 추가적으로 렌더링 함수의 이름은 `render` 로 항상 시작하고 언더스코어를 사용하지
> 않는다. 렌더링 함수의 이름은 이름이 길어지더라도 최대한 한번에 이해하기 쉬운
> 이름을 채택한다.


### Gesture Detector vs InkWell
InkWell 리플이펙트가 적용이 가능하면 InkWell 을 최대한 사용해준다. 이미지이거나
특수한 상황에 리플이펙트가 적용이 어렵다면 GestureDetector 를 사용해서 액션을
받는다.

## Controllers

### Controller 이름
컨트롤러는 MVVM 에서 View Model 에 해당되는 부분이다. 각 View Model 의
이름은 아키텍처상 xxxViewModel 이라고 부르는게 맞지만 GetX 의 스탠다드를 따라서
xxxController 라고 부르도록 하겠다. (쉬프트 한번만 눌러도 되서 편하다는
장점도 있다 :thumbsup:). 모든 컨트롤러는 한 controllers.dart 파일에서
한번에 export 한다.

**컨트롤러 이름**
*good*
```
class PostController extends BaseController {}
```

*bad*
```
class PostViewModel extends BaseController {}
```

### 컨트롤러 상속
Controller 는 abstract 클래스인 BaseController 를 상속한다. 컨트롤러에서
공용으로 사용될 여지가 있는 함수들은 BaseController 에 포함시킨다. 예를들면
일부 캐시 관련된 기능이 되겠다.

이 프로젝트에서 복잡핸 캐싱을 사용할 일은 없기 때문에 캐시 관리는 각 ViewModel
에서 진행 하도록 한다. 캐싱이 사용될 페이지 수가 적기때문에 컨트롤러간의 캐시 간섭은
없다고 생각해도 무방하다. 그러니 중앙화된 캐싱 시스템은 사용하지 않는다.

## Layouts
레이아웃 폴더는 각 스크린의 베이스가 될 구조를 잡는 위젯들이 위치한 폴더다. 예를들어
appbar 의 뒤로가기 버튼이 customize 되어야 할 경우 이를 컴포넌트 위젯으로
사용하기보다 build 함수의 전체를 Layout 으로 wrapping 한다. 레이아웃 위젯들
또한 layouts.dart 에서 한번에 export 한다.

## Models
모델 폴더는 MVVM 의 모델들이 위치하는 폴더다. Model 클래스 또한 BaseModel
을 상속해서 공용으로 사용될 기능들을 BaseModel 에 위치한다. 모든 모델은
models.dart 폴더에서 한번에 export 한다.

**예**
```
class Post extends BaseModel {}
```

## Services
Services 폴더는 HTTP 요청에 해당되는 함수들을 모두 관리한다. Service 는
요청의 특성별로 클래스를 나누고 BaseService 클래스를 상속한다. BaseService
클래스에서 암호화, 복호화를 비롯한 모든 HTTP 요청 관련된 함수를 작성하고
각각의 클래스에 API 엔드포인트별 method 를 작성한다. Service 는 나중에
RootService 에 모두 모아서 Controller 에 inject 시킨다. 모든 서비스는
services.dart 폴더에서 한번에 export 한다.

**예제**
```
class RootService {
    final postsService;
    final commentsService;
    ...
}

final rootService = RootService();

Get.put(PostController(service:rootService));
```

## Screens
앱의 각 스크린에 해당되는 위젯들을 관리하는 폴더다. 세부 route 마다 해당 route 에
해당되는 새로운 폴더를 제작해서 안에 파일을 관리한다. NextJS 를 사용 해봤다면
NexJS pages 구조와 비슷하다고 보면 되겠다. 다만 NextJS 에서 세부 폴더에
들어가면 index.tsx 로 해당 route 의 루트를 지정하지만 이 프로젝트에선 그냥
라우트 이름을 사용하겠다. 이름을 지을땐 부모 route 는 따로 서술하지 않는다.

**예제**
```
/main-tabs/request

class RequestScreen ...
```

다른 route 의 세부 스크린 이름과 곂칠 가능성이 상당히 높지만 이름 자체가 길어지는
것보단 낫다.

## Navigation

### GetX
Navigation 은 절대적으로 GetX 패키지만을 사용한다. 일관성을 유지하는게 나중에 firebase
analytics 를 효율적으로 활용하는데도 큰 도움이 된다. 더 나아가 일반적인 위젯 push 형태가
아닌 named route 를 사용해서 효율적으로 스크린 정리를 한다.

### URL 네이밍 룰
URL은 단어와 단어 사이에 '-' 하이픈을 사용해서 지정하며 url 이 끝나는 부분에
'/' 슬래시를 따로 추가하지 않는다.

**예제**
```
/main-tabs
```

### URL Parameter
URL에 파라미터가 존재할 경우 파라미터 변수를 ':'과 함께 변수 명칭을 입력하여 표현한다.

**예제**
```dart
/post/:id

final id = Get.parameters['id'];
```

### URL Query
URL에 query 가 들어갈 여지가 있다면 (예: initState 후 즉시 필터 적용시) 꼭
어떤 query 가 들어갈 수 있는지 페이지 세팅에 명시한다.

**예제**
```dart
/**
* Query
* [filter] : String - new, done, error
* [sort] : String - id-asc, id-desc, price-asc
* [id] : int - 1,2,3,4...
*/
GetPage(
  name: '/list',
)
```

variant 의 경우 (상세 페이지인데 ID에 따라 모델이 변경됨) 필수적으로 parameter 를
사용하고 이외 특정 액션을 명시하는경우 (필터등) query 를 사용한다. 일반적인 웹 URL
패턴과 같다고 생각하면 결정하기 쉽다.

### 리턴 argument
특정 URL에서 return 값을 받아야 하는경우 argument 를 필수로 클래스화 하여 전송한다.
짧은 스트링 하나만 받는다고 해도 하루만 지나면 분명 어떤 값이었는지 잊게 되어있다. 그뿐아니라
여러 화면에서 불리는 상세화면의 경우 argument를 클래스화 했을때 리펙터링에 굉장히 용이하다.
코멘트까지 작성하면 완벽!

```dart
class PageTwoResult{
  // 새로 입력한 프로필명
  final String name;

  PageTwoResult(
    @required String name,
  ) : assert(name != null,),
      this.name = name;
}

// Page 1
final resp = await Get.to(PageTwo());

// Page 2
Get.back(result: PageTwoResult(name: 'Code'));
```

리턴 아규먼트의 이름은 페이지이름 + Result 로 지정한다.

### 새 페이지 argument
새 페이지를 열때 argument 를 입력 해야한다면 (GetX 를 잘 활용하면 이런 경우가 거의
없을 가능성이 높다. 혹시 쓰고싶다면 정말 GetX로 해결이 안되는 부분인지 다시한번 생각해보자.)
리턴 argument 처럼 클래스를 새로 생성해서 argument 로 활용한다.

```dart
class PageTwoArgument{
  final String name;

  PageTwoArgument(
    @required String name,
  ) : assert(name != null),
      this.name = name;
}

// Page 1
Get.to(PageTwo(), arguments: PageTwoArgument(name: 'Code'));

// Page 2
final args = Get.arguments();
```

## Packages

### 외부 패키지 semantic versioning
외부 패키지를 사용할땐 ^를 사용해서 절대로 major 버전이 함부로 업데이트 되지 않도록
한다.

**예제**
```yaml
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.0
  get: ^3.24.0
```

## Assets

### Images
네트워크 이미지를 다룰때는 무조건 cached_network_image 를 사용한다. 데이터를 세이브하고
로딩 속도를 많이 올려줄 수 있다.

특정 패턴대로 이미지를 정리 해두면 Flutter 에서 자동으로 해상도별 이미지를 활용한다.
한가지 아쉬운점은 우리가 일반적으로 사용하는 mdpi, hdp, xhdpi...가 아닌 x2.0, x3.0
... 등 배수를 사용해 사이즈별 이미지를 적용한다. 상세내용은 [여기서](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware)
볼 수 있다. `AssetImage` 위젯을 사용해서 이미지를 렌더링하면 된다.

이 프로젝트는 해상도에 상당히 민감히 대처할 수 있도록 기획하고 있기 때문에 이미지
파일을 모두 svg 를 사용하도록 한다. 2x 3x 등 배수 파일들을 따로 관리하는 것보다 용량도
적게들고 Flutter 의 높은 퍼포먼스 덕분에 클라이언트 로드도 없다고 봐도 무방하다.

## Themes

### Material Theme
경험상 Material Theme 에 ThemeData 는 거의 쓸모가 없다. 빠르게 prototyping 할
계획이면 효율적으로 제공되는 컴포넌트만을 사용해서 MVP 를 만들어 볼 수 있겠지만 커스텀
위젯이 많은경우 자연스럽게 따로 상수들을 만들어서 쓰게 되어있다. 그래서 이 프로젝트는
utils/theme.dart 에서 모든 테마 관련 상수를 정리 할 계획이다. _ITheme 인터페이스는
현재로서는 딱히 쓸모 없어 보이지만 왠지 미래에 필요할 것 같아서 미리 준비 해두었다.
일반적으로 테마에서 상수를 끌어올때 `Theme().bgColor` 이런식으로 하면 되지만 안타깝게도
우리는 해상도별로 다른 테마를 적용할 계획이기에 `ThemeFactory.of(context).theme.bgColor`
이런식으로 상수를 불러와야 한다. 이후 theme getter 의 사이즈별 조건값만 변경해주면
스크린 사이즈별 다른 테마를 적용할 수 있다.

```dart
_BaseTheme get theme{
    // 테마 예제
    // 사이즈별로 다른 테마를
    // 리턴해주는 함수를 이용해서
    // 텍스트 사이즈 및 컨테이너 사이즈 조절
    if(MediaQuery.of(context).size.width > 200){
        return _normal;
    }else{
        return _large;
    }
}
```

### Color Scheme
Design System 내부에 존재하는 칼라들은 테마에 따로 정리를 해놨다.

```
primaryBlueColor -> #1D1F75
secondaryBlueColor -> #4042AB
primaryOrangeColor -> #F29061
primaryRedColor -> #DC5050
primaryGreyColor -> #EEEFF3
primaryYellowColor -> #FDD84F
primaryGreenColor -> #6CC4BF
primarySkyBlueColor -> #FF9B95
primaryVioletColor -> #8B6ADC
```

다만 몇페이지 작업 해보니 디자인에 사용된 회색을 정리하는건 거의 불가능하다. 회색이
한두개도 아니고 상당히 많은 variation 의 회색이 사용되고 있다. 이 회색들은
테마의 회색 중 하나로 변경할 수 있으면 변경을 하고 아니면 코드내에 직접 hexcode
를 삽입하는 방식으로 진행한다.


### json serializable command

일회성 코드 생성 명령어

```
flutter pub run build_runner build
```

위의 Command 를 프로젝트 루트에서 실행하면, 모델의 JSON 직렬화 코드를 생성할 수 있다.
이 명령은 소스 코드를 살펴보며 관련된 부분을 찾고, 필요한 직렬화 코드를 생성해내는 일회성 빌드.


지속적인 코드 생성 명령어

```
flutter pub run build_runner watch
```

watcher 가 소스 코드 생성과정을 좀 더 편리하게 만들어 준다.
이는 프로젝트 파일들의 변화를 지켜 보고 자동으로 필요한 파일을 빌드한다.
프로젝트 루트에서 flutter pub run build_runner watch를 실행하여 watcher를 사용한다.


pub finished with exit code 78 Error 발생시 명령어

```
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

위의 명령어를 실행한 후에 전체적으로 리빌드 되고 나면 정상적으로 작동한다.


## 주석 규칙
코드에는 다음과 같은 주석을 달아야 합니다.

- ### 목적
  - 다른 개발자에게 최소한의 정보 전달

- ### 작성방식

  import와 클래스 선언 사이에 아래 양식의 주석을 넣는다.

~~~
/*
 작성일 : (파일 작성 날짜)
 작성자 : (작성자 이름 입력)
 화면명 : (화면 코드 입력, 필요없으면 입력 안해도 됨)
 경로 : (GetX용 경로, 필요없으면 입력 안해도 됨)
 클래스 : (클래스 이름)
 설명 : (클래스 설명 입력)
 수정자 : (파일 작성 날짜)
 수정일 : (작성자 이름 입력)
*/
~~~

- 예시

~~~
import 'package:flutter/material.dart';

/*
 작성일 : 2021-03-22
 작성자 : Phil
 화면명 : 
 클래스 : 
 경로 : /
 설명 : 메인화면
 수정자 :
 수정일 :
*/

class MainTabs extends StatefulWidget {
    // ...
~~~

### 기술 일지 
