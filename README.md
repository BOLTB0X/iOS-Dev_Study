# iOS-Dev_Study

![라센간](https://t1.daumcdn.net/cafeattach/mEr9/05174e6f76f09a92519478418bc5f51d9f5b860d)

## 클린 아키텍쳐

```
├── App
│   ├── AppDelegate
│   └── SceneDelegate
│
├── Presentation (UI Layer)
│   ├── ImageList
│   │   ├── View
│   │   │   └── ImageListViewController
│   │   ├── ViewModel
│   │   │   └── ImageListViewModel
│   │   └── Cell
│   │       └── ImageCollectionViewCell
│   ├── ImageList
│   │   ├── View
│   │   │   └── ImageDetailViewController
│   │   └── ViewModel
│   │       └── ImageDetailViewModel
│   └── Common
│       ├── Extensions
│       │   └── Bundle
│       │   └── UIViewControllerRepresentable
│       └── UIComponents
│           └── LoadingIndicator
│
├── Domain (Business Layer)
│   ├── Entity
│   │   └── ImageEntity
│   ├── RepositoryProtocol
│   │   └── ImageRepositoryProtocol
│   │   └── LoadRepositoryProtocol
│   └── UseCase
│       ├── FetchImagesUseCase
│       └── UpdateFileNameUseCase
│       └── LoadUseCase
│
├── Data (Data Layer)
│   ├── DTO
│   │   └── ImageDTO
│   │   └── MessageDTO
│   ├── Repository
│   │   └── ImageRepository
│   │   └── LoadRepository
│   └── API
│       └── APIBuilder
│       └── APIError
│       └── APIService
│       └── Endpoint
│
└── Resources
    └── Assets.xcassets
```

---

### Domain (Business Layer)

> 비즈니스 로직을 담당

> Entity와 UseCase 가 대부분

**Domain layer** 에서는 외부( **Data Layer** , **UI Layer** 등) 가 어떤 기술을 쓰는지 전혀 몰라도 되고 오직 비즈니스 행위에만 집중

- 순수 Swift 코드 (플랫폼/프레임워크 의존 X)

- 테스트하기 쉬움 (`Mock Repository` 주입 가능)

- Data/Infra 교체돼도 Domain은 그대로 유지

```
├── Domain (Business Layer)
│   ├── Entity
│   │   └── ImageEntity
│   ├── RepositoryProtocol
│   │   └── ImageRepositoryProtocol
│   │   └── LoadRepositoryProtocol
│   └── UseCase
│       ├── FetchImagesUseCase
│       └── UpdateFileNameUseCase
│       └── LoadUseCase
```

- [Entity](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/Studies/Domain.md#domain-layer---entity)

- [RepositoryProtocol](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/Studies/Domain.md#domain-layer---repositoryprotocol)

- [UseCase](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/Studies/Domain.md#domain-layer---usecase)

```css
        [ Domain Layer ]
───────────────────────────
        Entity (Business Model)
            │
            ▼
      ┌──────────────────────┐
      │       Entity         │
      │   - ImageEntity      │
      │   - (다른 엔티티들)  │
      └──────────────────────┘
            │
            ▼
   ┌─────────────────────────┐
   │ Repository Protocol     │ (Interface)
   │ - fetchImages()         │
   │ - updateImageName()     │
   └─────────────────────────┘
            │
            ▼
      ┌──────────────────────┐
      │       UseCase        │ (Business Logic 단위)
      │ - FetchImagesUseCase │
      │ - UpdateImageUseCase │
      │ - LoadUseCase        │
      └──────────────────────┘
            │
            ▼
       [ Presentation Layer ]
         (ViewModel / UI)

```

---

### Data (Data Layer)

> 실제 데이터 저장소(데이터베이스, 서버 등)에 접근하는 로직을 담당하는 계층


- **Domain** layer의 데이터 저장 방식( *ex. Repository 패턴* )에 대한 의존성을 갖지 않도록 하고 실제 데이터의 입출력을 담당

    - **의존성 방향** : `Data Layer` 는 `Domain Layer` 와 `UI Layer`로부터 의존성을 받음. 즉, 외부 레이어에 의존하여 해당 레이어의 요청에 응답

    ---

- **Repository** 를 통해 외부 데이터 소스에 접근하는 진입점을 제공

    - **데이터 저장 방식 추상화** :  `Domain Layer` 는 데이터 소스의 종류나 방식에 대해 알 필요가 없도록 데이터 저장 방식에 대한 의존성을 끊음

    ---

```
Data (Data Layer)
│
├── DTO
│    └── ImageDTO.swift
│    └── MessageDTO.swift
│
├── Repository
│    └── ImageRepository.swift
│    └── LoadRepository.swift
│
└── API
     └── APIBuilder.swift
     └── APIError.swift
     └── APIService.swift
     └── Endpoint.swift
```

- [DTO](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/Studies/Data-DTO.md)

- [Repository](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/Studies/Data-Repository.md)

- [API](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/Studies/Data-API.md)

```css
        [ Data Layer ]        
─────────────────────────── 
        API/DB/Cache
            │
            ▼
      ┌────────────┐
      │   DTO      │   (Data Transfer Object)
      │ ImageDTO   │   - 네트워크/DB 포맷 그대로
      │ MessageDTO │
      └────────────┘
            │
            ▼
      ┌────────────┐
      │  Mapper    │   (toEntity)
      │ DTO→Entity │
      └────────────┘
            │
            ▼
      ┌──────────────────────┐
      │        Entity        │   (Domain-friendly model)
      │      ImageEntity     │
      │     MessageEntity?   │
      └──────────────────────┘
            │
            ▼
   ┌──────────────────────┐
   │  Repository (구현체)   │
   │ - DTO fetch          │
   │ - Entity 변환         │
   └──────────────────────┘
            │
            ▼
   ┌──────────────────────┐
   │ Domain Repository    │ (Protocol)
   │ - fetchImages()      │
   │ - updateImageName()  │
   └──────────────────────┘
            │
            ▼
      [ UseCase / Service ]

```

---

## Unit Test

### Unit Test 란 무엇인가?

> SW의 가장 작은 단위(Unit), 즉 함수, 메소드 또는 클래스 하나가 의도한 대로 정확하게 작동하는지 검증하는 과정

iOS 개발에서는 보통 Swift의 **`Class`** 나 **`Struct`** 에 정의된 특정 기능(메소드)이 **하나의 유닛**


1. **목표**

      - **격리 (Isolation)** : 테스트 대상 코드가 외부 환경(네트워크, 데이터베이스, 파일 등)이나 다른 복잡한 모듈에 의존하지 않도록 분리하여 테스트하는 것이 핵심(`Mock` 객체를 사용하는 이유)

      - **자동화** : 한 번 작성된 테스트 코드는 언제든지 버튼 하나로 빠르고 반복적으로 실행될 수 있어야 함

      ---

2. **TDD와 유닛 테스트의 관계: 개발 방식의 변화**

      1. 테스트 코드 작성 → 코드 작성 → 리팩토링 (반복)

      2. 구현할 기능을 명세하고, 기능이 올바르게 설계되었는지 확인

      3. 테스트가 '설계 도구'이자 '안전망' 역할

      ---

3. `Mock` 객체의 역할: *현실 세계의 시뮬레이션*

   iOS 앱은 서버 API, 로컬 데이터베이스, 사용자 설정 등 다양한 외부 의존성을 가져오는데,
   
   유닛 테스트를 할 때 이러한 외부 요소를 그대로 사용하면 문제가 발생하는 경우가 잦음 -> 이를 보완하는 것이 `Mock`

   - `Mock`의 필요성: 서버가 다운되면 클라이언트 코드의 테스트도 실패할지, 않할지, 내 코드가 아닌 서버의 문제인지 알수 있음

   - `Mock` 객체는 실제 외부 의존성을 대신하는 **가짜 객체**

   - 네트워크 통신이 필요할 때 → `MockNetworkManager` 를 만들어 *"성공 데이터"* 를 즉시 반환하도록 설정

   - 사용자 데이터 저장이 필요할 때 → `MockDatabase` 를 만들어 실제로 저장하는 대신, *"저장 함수가 올바른 인수로 호출되었는지"* 만 검증함

---

### Unit Test 작성

>  **프로토콜(Protocol)** 을 활용한 **의존성 주입(Dependency Injection, DI)**

TODO


## 참고

- [블로그 참고 - UIKit 코드베이스 프로젝트 세팅(공대생)](https://thingjin.tistory.com/entry/UIKit-%EC%BD%94%EB%93%9C%EB%B2%A0%EC%9D%B4%EC%8A%A4-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%84%B8%ED%8C%85)

- [블로그 참고 - iOS Preview 보면서 codebase로 작업하기(천원의 개발)](https://1000one.tistory.com/69)

- [블로그 참고 - Clean Architecture 도입 전 개념 정리(강철곰탱이)](https://steelbeartaeng2.tistory.com/144)

- [블로그 참고 - UIImageView 기본 사용법과 CornerRadius 와 Shadow 넣기(통스)](https://tong94.tistory.com/20)

- [블로그 참고 - 이미지 캐시 (ImageCache) 구현 방법, URLSession, NSCache (애플 공식 문서 방법)(김종권의 iOS)](https://ios-development.tistory.com/743)

- [유튜브 참고 - Clean Architecture 도대체 왜 쓰는거죠? | feat. MVC, MVVM, 클린아키텍쳐 | 주니어 개발자 꿀팁(리디의 삶은 개발)](youtube.com/watch?v=V0PZmJ7eDvo&t=262)

- [블로그 참고 - 아키텍처 - 업무규칙 (Entity, Use case)(Jook의 Tech 생각:티스토리)](https://share-factory.tistory.com/33)

- [블로그 참고 - 유닛테스트(Unit Test) 테스트 코드를 작성해보자(개발자 소들이)](https://babbab2.tistory.com/199)

- [블로그 참고 -  Swift - Unit Test/ 유닛테스트(티피커피)](https://toughie-ios.tistory.com/270)