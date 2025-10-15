# Endpoint

> **API** : 우체국과 같은 개념, 우편 시스템 전체를 의미

> **Endpoint** : 편지를 보내려는 특정 주소, 편지가 올바른 곳으로 전달되려면 정확한 주소가 있어야 하듯이, **API 통신도 정확한 Endpoint 로 요청을 보내야 함**

엔드포인트(Endpoint)는 API가 제공하는 특정 기능이나 데이터에 접근하기 위한 고유한 URL 주소

---

## Http 통신으로 API 요청 흐름

```
Client (Swift)
     ↓
[1] Endpoint 구성
     ↓
[2] URLRequest 생성
     ↓
[3] URLSession 통해 전송
     ↓
[4] Server가 JSON 응답
     ↓
[5] JSONDecoder로 디코딩
```

1. 요청 전에 → `Endpoint`를 구성
→ 어떤 API를 호출할지, 어떤 데이터와 함께 보낼지를 정의

2. 요청 시 → `Endpoint`를 기반으로 `URLRequest`를 생성
→ `URL` + `HTTPMethod` + `Header` + `Query` + `Body` 가 합쳐져 실제 네트워크 요청 객체가 됨

3. 응답 시 → 서버의 **JSON** 데이터를 `Decodable` 모델로 변환

---

## `headers` : 요청의 “메타정보”

서버에게 *“이 요청은 어떤 형식이며, 어떤 권한으로 보낸 건지”* 알려주는 요청의 설정값들

```
headers: [
    "Content-Type": "application/json", // 본문이 JSON임을 명시
    "X-Auth-Token": "token", // 인증용 토큰
    "Accept": "application/json" // 서버에 JSON 응답을 요청
]
```

| 헤더 키                             | 설명                                                            |
| -------------------------------- | ------------------------------------------------------------- |
| `Content-Type`                   | 요청 Body의 타입 지정 (예: `application/json`, `multipart/form-data`) |
| `Accept`                         | 클라이언트가 받고 싶은 응답 타입                                            |
| `Authorization` / `X-Auth-Token` | 인증 토큰 또는 API 키                                                |
| `User-Agent`                     | 클라이언트 앱 정보 전달 (서버 로깅용)                                        |


---

## `query` — URL 뒤에 붙는 “요청 파라미터”

`GET` 이나 `DELETE` 요청처럼 `body` 가 없는 경우, **URL** 에 데이터를 붙여 전달하는 방식

- *ex* : `/users` 리소스를 `offset=10`, `limit=5` 조건으로 서버에 요청하는 것

    ```bash
    https://api.example.com/users?offset=10&limit=5
    ```

    ---

- **swift**

    ```swift
    let endpoint = Endpoint<UserListResponse>(
    path: "/users",
    method: .get,
    query: ["offset": "10", "limit": "5"]
    )
    ```

    - 내부적으로 `URLComponents` 를 이용해 `queryItems` 로 변환되어 **URL** 에 자동 붙음

---

## `body` — 요청의 “실제 데이터 내용”

`POST` / `PUT` / `PATCH` 같은 요청에서 서버로 보내야 할 실제 데이터를 **JSON** 으로 포함시키는 공간

- `GET` 요청엔 `body` 를 넣지 않음

- 항상 `Content-Type: application/json` 헤더를 같이 지정해야 서버가 올바르게 해석

```swift
struct LoginRequest: Codable {
    let email: String
    let password: String
}

let body = LoginRequest(email: "user@example.com", password: "1234")

let endpoint = try Endpoint<LoginResponse>(
    path: "/login",
    method: .post,
    body: body
)
```

```json
{
  "email": "user@example.com",
  "password": "1234"
}
```

## 대략적인 ex

```swift
let endpoint = try Endpoint<UserResponse>(
    path: "/users/update",
    method: .put,
    headers: [
        "X-Auth-Token": "abc123",
        "Content-Type": "application/json"
    ],
    query: ["include": "profile"], // URL 뒤에 붙음
    body: UserUpdateRequest(name: "B0X", age: 32) // JSON으로 body에 들어감
)
```

```
PUT https://api.example.com/users/update?include=profile
Header: 
  X-Auth-Token: abc123
  Content-Type: application/json

Body:
  {
    "name": "B0X",
    "age": 32
  }
```

## 참고

- [블로그 참고 - API 와 Endpoint ? (둘 다 정확히 알고 있다면 안 봐도 되는 글)(토찌)](https://blog.naver.com/ghdalswl77/222401162545)