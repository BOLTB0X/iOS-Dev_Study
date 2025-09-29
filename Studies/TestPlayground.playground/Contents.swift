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

//CalculatorTests.defaultTestSuite.run()


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

// 4. 테스트 대상 클래스 (ViewModel)
class ContentViewModel {
    private let fetcher: Fetching // <- 실제 구현체가 아닌 프로토콜에 의존
    var content: String?

    init(fetcher: Fetching) { // <- 생성자 주입 (DI)
        self.fetcher = fetcher
    }

    func loadContent() {
        fetcher.fetchData { result in
            if case .success(let data) = result {
                self.content = String(data: data, encoding: .utf8)
            }
        }
    }
} // ContentViewModel

class ContentViewModelTests: XCTestCase {

    func testLoadContent_Success() {
        // 1. Arrange (준비): Mock 객체와 테스트 대상 객체를 설정
        let mockFetcher = MockNetworkService()
        // Mock이 성공 결과를 반환하도록 설정
        mockFetcher.shouldSucceed = true
        mockFetcher.mockData = "Hello, TDD!".data(using: .utf8)
        
        let sut = ContentViewModel(fetcher: mockFetcher) // SUT: System Under Test

        // 2. Act (실행): 테스트 대상의 메소드를 실행
        sut.loadContent()

        // 3. Assert (단언): 기대하는 결과가 나왔는지 검증
        
        // 기대값: ViewModel의 content가 "Hello, TDD!"가 되어야 함.
        XCTAssertEqual(sut.content, "Hello, TDD!")
    }

    func testLoadContent_Failure() {
        // 실패 테스트 케이스
        let mockFetcher = MockNetworkService()
        // Mock이 실패 결과를 반환하도록 설정
        mockFetcher.shouldSucceed = false

        let sut = ContentViewModel(fetcher: mockFetcher)

        sut.loadContent()

        // 기대값: 실패했으므로 content는 nil이어함
        XCTAssertNil(sut.content, "네트워크 실패 시 Content는 nil이어야 합니다.")
    }
}
