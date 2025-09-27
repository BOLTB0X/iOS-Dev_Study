import XCTest

class Calculator {
    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}

class CalculatorTests: XCTestCase {

    func testAddition() {
        // Arrange
        let calculator = Calculator()
        let a = 5
        let b = 3

        // Act
        let result = calculator.add(a, b)

        // Assert
        XCTAssertEqual(result, 8, "5 + 3은 8이어야 합니다.")
    }
}

CalculatorTests.defaultTestSuite.run()


// 1. 프로토콜로 서비스의 '계약'을 정의
protocol Fetching {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void)
}

// 2. 실제 네트워크 요청 로직이 담긴 구현체
class NetworkService: Fetching {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        // URLSession.shared.dataTask..
    }
}

// 3. Mock 구현체
class MockNetworkService: Fetching {
    // 테스트 성공/실패 시 반환할 데이터를 미리 저장
    var shouldSucceed = true
    var mockData: Data? = "Mocked Data".data(using: .utf8)

    // 실제 통신 대신 이 Mock 함수가 호출
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        if shouldSucceed, let data = mockData {
            // 성공 케이스 시뮬레이션
            completion(.success(data))
        } else {
            // 실패 케이스 시뮬레이션
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
} // MockNetworkService
