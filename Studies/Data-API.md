# Data Layer - API

> 이 레이어는 네트워크 통신을 추상화하고, 외부 API와 데이터를 주고받는 책임만 가치는 레이어

*“네트워크 호출의 구체적인 구현을 `Repository` 나 `UseCase` 가 알 필요 없게”* 만들어주고, **관심사 분리(SOC)** 를 통해 **재사용성** 과 **테스트 용이성** 들만 고려

---

## [`Endpoint.swift`](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/API/Endpoint.swift)

```swift
struct Endpoint<Response: Decodable> {
    let path: String
    var method: HTTPMethod
    var headers: [String: String]
    var query: [String: String]?
    var body: Data?

    // ...
}
```

- 하나의 API 요청 정의를 캡슐화

- `makeRequest(baseURL:)` 메서드를 통해 구체적인 `URLRequest`를 만드는 것만 수행

---

## [`APIError.swift`](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/API/APIError.swift)

```swift
enum APIError: Error {
    case invalidURL
    case decodingFailed
    case unknown
    case networkError(Error)
    case invalidResponse(Int) // HTTP 상태 코드
}
```

- API 호출 과정에서 발생하는 오류들을 이 곳에서 모아 둠

- `Repository`나 `ViewModel` 이 `URLSession` 의 다양한 Error를 몰라도 됨, `APIError` 만 다루면 됨

---

## [`APIBuilder.swift`](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/API/APIBuilder.swift)

- **실제 HTTP 요청을 보내고, 응답을 디코딩하는 객체**

- `Endpoint<Response>` 를 받아서, 해당 요청을 실행하고 결과를 `Response` 타입으로 반환

- 네트워크 호출 + 디코딩만 책임

```swift
protocol APIBuilderProtocol {
    associatedtype Response: Decodable
    
    var endpoint: Endpoint<Response> { get }
    
    @discardableResult
    func request(baseURL: URL, session: URLSession) async throws -> Response
    
    func decode(data: Data) throws -> Response
}
```

- `request(baseURL:session:)` : 네트워크 호출 실행

- `decode(data:)` : `JSONDecoder` 로 응답 변환

- `Endpoint<Response>` : 제네릭으로 받아 응답 타입을 강력한 타입으로 반환

```swift
final class APIBuilder<Response: Decodable>: APIBuilderProtocol { ... }
```

- 실제 구현체

- `APIBuilderProtocol` 을 따르기 때문에, 나중에 `APIBuilder` 말고 다른 방식(ex. `MockBuilder`)을 쉽게 끼워넣어 테스트 가능

---

## [`APIService.swift`](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/API/APIService.swift)

```swift
protocol APIServiceProtocol {
    func request<T: Decodable>(
        endpoint: Endpoint<T>,
        baseURL: URL,
        session: URLSession) async throws -> T

    func fetchImages() async throws -> [ImageDTO]
    func updateImageName(id: String, newName: String) async throws -> MessageDTO
}

extension APIServiceProtocol {
    
    
    func request<T: Decodable>(
        endpoint: Endpoint<T>,
        baseURL: URL,
        session: URLSession
    ) async throws -> T {
        let builder = APIBuilder(endpoint: endpoint)
        return try await builder.request(baseURL: baseURL, session: session)
    }
    
}
```

- `Repository` 가 사용할 **"서비스 인터페이스"**

- 네트워크 계층의 구체 구현을 몰라도, **Repository** 는 이 프로토콜만 의존하면 됨

    - `ImageRepository` -> `APIServiceProtocol` 에만 의존

    - 실제 구현체는 `APIService` (Data Layer)

```swift
final class APIService: APIServiceProtocol { ... }
```

- 실제 서버와 통신하는 구체적 구현체

- `fetchImages()` : `GET` -> `[ImageDTO]`

- `updateImageName(...)` : `PUT` -> `MessageDTO`

- 새로운 API 엔드포인트가 필요하면 `APIService` `extension` 에 메서드 추가

- **Repository** 는` APIService`의 구체적 구현 대신 Protocol에 의존

---

## 정리

```
[Domain Layer]
UseCase
   ↓
ImageRepositoryProtocol
   ↓
[Data Layer]
ImageRepository → APIServiceProtocol
                        ↓
                 APIService (구현체)
                        ↓
                  APIBuilder
                        ↓
                   URLSession

```