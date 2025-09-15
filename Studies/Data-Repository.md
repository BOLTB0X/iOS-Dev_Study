# Data Layer - Repository

> **Repository** 는 “데이터 소스 관리”만 책임집니다.

- API 호출, 캐시, 로컬 DB 등 복잡한 로직을 숨기고 **Domain** 에는 Entity만 전달

- Repository → Protocol 에 의존

    Domain은 RepositoryProtocol만 바라봄

**Data Layer와 Domain Layer 사이의 중간 다리 (Bridge)**

---

## [`ImageRepository.swift`](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/Repository/ImageRepository.swift)

```swift
final class ImageRepository: ImageRepositoryProtocol {
    
    private let baseURL: String
    private let apiService: APIServiceProtocol
    
    // MARK: - init
    init() {
        self.baseURL = Bundle.main.apiURL!
        self.apiService = APIService(baseURL: URL(string:baseURL)!)
    } // init
    
    init(baseURL: String, apiService: APIServiceProtocol) {
        self.baseURL = baseURL
        self.apiService = apiService
    } // 테스트 init , DI
    
} // ImageRepository
```

- **Domain** 의 `ImageRepositoryProtocol` 의 구현체

    - 여기서 비로소 어떻게(How) 데이터를 가져오고 변환하는지 구현

    - Domain Layer는 **Data Source(API/DB/캐시)** 가 뭔지 몰라도 됨

    - `APIService` 에서 **DTO** 를 받아 -> **Domain Entity** 로 변환 -> **UseCase/ViewModel** 에서 사용

    - `apiService.fetchImages()` -> [ImageDTO] -> [ImageEntity] 변환 로직 포함



    ```swift
    extension ImageRepository {
    // MARK: - fetchImages
        func fetchImages() async throws -> [ImageEntity] {
            let dtos = try await apiService.fetchImages()
            return dtos.map {
                $0.toEntity(baseURL: baseURL)
            }
        } // fetchImages
    
        // MARK: - updateImageName
        func updateImageName(id: String,
                            newName: String) async throws -> String {
            let dto = try await apiService.updateImageName(id: id, newName: newName)
            return dto.message
        } // updateImageName
    
    }
    ```

    ---

- **DIP(의존성 역전 원칙) 적용** : Repository는 `APIServiceProtocol` 에 의존 (구현체에 직접 의존하지 않음)

---

## 정리

```
UseCase → ImageRepositoryProtocol
             ↑
[Data Layer] ImageRepository
             ├── APIServiceProtocol (Remote API)
             └── LocalDataSource? (Optional, 로컬 캐시 저장소 역할)
```