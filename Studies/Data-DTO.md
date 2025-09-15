# Data Layer - DTO

> Data Transfer Object

> 네트워크 데이터 전송용, API 응답/요청을 위한 모델

- **DTO** 는 오직 데이터 전달만 책임짐, 비즈니스 로직 X

- **DTO** 는 **Domain의 Entity** 로 변환 (`toEntity`) 가능

    - 반대로 **Domain** -> **DTO** 변환도 필요하다면 extension 가능

---

## [`ImageDTO.swift`](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/DTO/ImageDTO.swift)

```swift
struct ImageDTO: Codable {
    let id: String
    let filename: String
    let prompt: String
    let imageURL: String
    let timestamp: String

    enum CodingKeys: String, CodingKey {
        case id, filename, prompt, timestamp
        case imageURL = "image_url"
    }
}
```

- 서버 API에서 내려주는 **JSON 데이터** 를 그대로 담는 모델

- API 응답을 **Decoding** 하거나 요청을 **(Encoding** 할 때 사용

- `Codable` 채택 -> `JSONDecoder`/`JSONEncoder` 로 직렬화 가능

- 네트워크 계층에만 필요한 정보이므로 **Domain Layer** 와는 분리

   ```swift
    extension ImageDTO {
        // MARK: - toEntity
        func toEntity(baseURL: String) -> ImageEntity {
            ImageEntity(
                id: id,
                filename: filename,
                prompt: prompt,
                imageURL: baseURL + "/" + imageURL,
                timestamp: timestamp
            )
        } // toEntity
    } // Mapper
   ```

---

## [`MessageDTO.swift`](https://github.com/BOLTB0X/iOS-Dev_Study/blob/main/iOS-API/iOS-API/Data/DTO/MessageDTO.swift)

```swift
struct MessageDTO: Codable {
    let message: String
}
```

- 서버에서 작업 성공/실패 메시지를 반환할 때 사용되는 **DTO**

    - 단순한 문자열 응답도 `Codable`로 추상화해서 일관성 유지
    
    - *ex.)* `updateImageName` **API** 의 `"message": "updated successfully"` 같은 응답을 줄 때 사용

---

## 정리

```
DTO (ImageDTO, MessageDTO)
   ↓  Mapper
Entity (ImageEntity)  <- Domain에서 사용하는 데이터 모델
```