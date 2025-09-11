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
│       └── UpdateImageUseCase
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

- [DTO]()

- [Repository]()

- [API]()

---

## Test

TODO

---


## 참고

- [블로그 참고 - UIKit 코드베이스 프로젝트 세팅(공대생)](https://thingjin.tistory.com/entry/UIKit-%EC%BD%94%EB%93%9C%EB%B2%A0%EC%9D%B4%EC%8A%A4-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%84%B8%ED%8C%85)

- [블로그 참고 - iOS Preview 보면서 codebase로 작업하기(천원의 개발)](https://1000one.tistory.com/69)

- [블로그 참고 - Clean Architecture 도입 전 개념 정리(강철곰탱이)](https://steelbeartaeng2.tistory.com/144)

- [블로그 참고 - UIImageView 기본 사용법과 CornerRadius 와 Shadow 넣기(통스)](https://tong94.tistory.com/20)

- [블로그 참고 - 이미지 캐시 (ImageCache) 구현 방법, URLSession, NSCache (애플 공식 문서 방법)(김종권의 iOS)](https://ios-development.tistory.com/743)

- [유튜브 참고 - Clean Architecture 도대체 왜 쓰는거죠? | feat. MVC, MVVM, 클린아키텍쳐 | 주니어 개발자 꿀팁(리디의 삶은 개발)](youtube.com/watch?v=V0PZmJ7eDvo&t=262)