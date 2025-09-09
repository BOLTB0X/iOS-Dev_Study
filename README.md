# iOS-Dev_Study

![라센간](https://t1.daumcdn.net/cafeattach/mEr9/05174e6f76f09a92519478418bc5f51d9f5b860d)

## 클린 아키텍쳐 기반

```
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
│
├── Presentation (UI Layer)
│   ├── ImageList
│   │   ├── View
│   │   │   └── ImageListViewController.swift
│   │   ├── ViewModel
│   │   │   └── ImageListViewModel.swift
│   │   └── Cell
│   │       └── ImageCollectionViewCell.swift
│   ├── ImageList
│   │   ├── View
│   │   │   └── ImageDetailViewController.swift
│   │   ├── ViewModel
│   │       └── ImageDetailViewModel.swift
│   └── Common
│       ├── Extensions
│       │   └── Bundle.swift
│       │   └── UIViewControllerRepresentable.swift
│       └── UIComponents
│           └── LoadingIndicator.swift
│
├── Domain (Business Layer)
│   ├── Entity
│   │   └── ImageEntity.swift
│   ├── Repository
│   │   └── ImageRepository.swift
│   └── UseCase
│       ├── FetchImagesUseCase.swift
│       └── UpdateImageUseCase.swift
│       └── LoadUseCase.swift
│
├── Data (Data Layer)
│   ├── DTO
│   │   └── ImageDTO.swift
│   │   └── MessageDTO.swift
│   ├── Repository
│   │   └── ImageRepository.swift
│   │   └── LoadRepository.swift
│   └── API
│       └── APIBuilder.swift
│       └── APIError.swift
│       └── APIService.swift
│       └── Endpoint.swift
│
└── Resources
    └── Assets.xcassets
```

- TDD

---


## 참고

- [블로그 참고 - UIKit 코드베이스 프로젝트 세팅(공대생)](https://thingjin.tistory.com/entry/UIKit-%EC%BD%94%EB%93%9C%EB%B2%A0%EC%9D%B4%EC%8A%A4-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%84%B8%ED%8C%85)

- [블로그 참고 - iOS Preview 보면서 codebase로 작업하기(천원의 개발)](https://1000one.tistory.com/69)

- [블로그 참고 - Clean Architecture 도입 전 개념 정리(강철곰탱이)](https://steelbeartaeng2.tistory.com/144)

- [블로그 참고 - UIImageView 기본 사용법과 CornerRadius 와 Shadow 넣기(통스)](https://tong94.tistory.com/20)

- [블로그 참고 - 이미지 캐시 (ImageCache) 구현 방법, URLSession, NSCache (애플 공식 문서 방법)(김종권의 iOS)](https://ios-development.tistory.com/743)

