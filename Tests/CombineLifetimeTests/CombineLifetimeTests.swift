import Combine
import XCTest
@testable import CombineLifetime

final class CombineLifetimeTests: XCTestCase {
    func testLifetime() {
        let subjectA = CurrentValueSubject<String?, Never>(nil)
        let subjectB = CurrentValueSubject<String?, Never>(nil)
        weak var lifetime: Lifetime?
        _ = {
            let innerLifetime = Lifetime()
            innerLifetime += subjectA.sink { value in
                subjectB.value = value
            }
            subjectA.value = "a"
            XCTAssertEqual(subjectB.value, subjectA.value)
            lifetime = innerLifetime
        }()
        XCTAssertNil(lifetime)
        subjectA.value = "b"
        XCTAssertNotEqual(subjectB.value, subjectA.value)
    }
    
    func testCancel() {
        let subjectA = CurrentValueSubject<String?, Never>(nil)
        let subjectB = CurrentValueSubject<String?, Never>(nil)
        let lifetime = Lifetime()
        lifetime += subjectA.sink { value in
            subjectB.value = value
        }
        subjectA.value = "a"
        XCTAssertEqual(subjectB.value, subjectA.value)
        lifetime.cancel()
        subjectA.value = "b"
        XCTAssertNotEqual(subjectB.value, subjectA.value)
    }
}
