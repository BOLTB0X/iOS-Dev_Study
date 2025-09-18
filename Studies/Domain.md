## Domain Layer - Entity

> 엔티티는 시스템의 내부 객체로서, 핵심 업무 데이터를 기반으로 동작하는 일련의 조그만 핵심 업무 규칙을 구체화

- 도메인의 핵심 모델

- 외부 포맷( **JSON** , **DTO** 등)과 분리된 순수 데이터 구조체

- 비즈니스적으로 꼭 필요한 정보만 가짐

---

### [`ImageEntity.swift`](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Domain/Entities/ImageEntity.swift)

```swift
struct ImageEntity {
    let id: String
    var filename: String
    let prompt: String
    let imageURL: String
    let timestamp: String
    
    init(id: String,
         filename: String,
         prompt: String,
         imageURL: String,
         timestamp: String) {
        self.id = id
        self.filename = filename
        self.prompt = prompt
        self.imageURL = imageURL
        self.timestamp = timestamp
    } // init   
}
```

- **Domain Layer** 에서 사용하는 핵심 데이터 모델

- **API** 나 **DB** 와 무관하게 앱 내부에서만 순수 Swift 타입으로 존재

- **DTO** 에서 변환(`toEntity`)되어 들어옴

- UI/ViewModel 은 반드시 Entity 를 다룸 (DTO를 직접 다루지 않음)

---

## Domain Layer - RepositoryProtocol

> Data Source 추상화

> **Domain** -> **Data** 를 이어주는 인터페이스

- **Domain** 은 데이터가 어디서 오는지(API/DB/Cache) 몰라도 됨

- 오직 `RepositoryProtocol` 만 의존

- **Data Layer** 가 이 프로토콜을 채택하여 실제 구현(API 호출, DB 쿼리 등) 담당

### [ImageRepositoryProtocol.swift](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Domain/RepositoryProtocol/ImageRepositoryProtocol.swift)

```swift
protocol ImageRepositoryProtocol {
    func fetchImages() async throws -> [ImageEntity]
    func updateImageName(id: String, newName: String) async throws -> String
}
```

- `fetchImages()` : 여러 이미지 리스트 반환

- `updateImageName(...)` : 이미지 이름 업데이트 후 메시지 반환

- **Domain** 은 **Protocol** 정의만 알고, 실제 구현체(`ImageRepository`)는 **Data Layer** 에 존재

---

## Domain Layer - UseCase

> Business Logic 단위

> 특정 행위(Use Case) 를 캡슐화

- UI / ViewModel -> **UseCase** -> **RepositoryProtocol** -> **Data Layer**

- 하나의 UseCase는 하나의 핵심 비즈니스 기능을 담당

- 테스트 용이 (`Mock Repository` 주입 가능)

---

### [FetchImagesUseCase.swift](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Domain/Usecase/FetchImagesUseCase.swift)

```swift
struct FetchImagesUseCase {
    private let repository: ImageRepositoryProtocol
    
    init(repository: ImageRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(limit: Int = 20) async throws -> [ImageEntity] {
        try await repository.fetchImages()
    } // execute
}
```

- 이미지 목록 가져오기 기능 전담

- **Repository** 를 통해 데이터를 가져오고 **Entity 반환**

---

### [UpdateFileNameUseCase.swift](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Domain/Usecase/UpdateFileNameUseCase.swift)

```swift
struct UpdateFileNameUseCase {
    private let repository: ImageRepositoryProtocol
    
    init(repository: ImageRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: String, newName: String) async throws -> String {
        try await repository.updateImageName(id: id, newName: newName)
    }
}
```

- 이미지 이름 변경하기 기능 전담

- 성공 시 메시지 문자열 반환

---

## 정리

```
DTO (ImageDTO, MessageDTO)   <- Data Layer
   ↓  Mapper
Entity (ImageEntity)         <- Domain Layer
   ↑  RepositoryProtocol
UseCase (FetchImages, UpdateImage) <- Domain Layer
   ↑
UI / ViewModel

```