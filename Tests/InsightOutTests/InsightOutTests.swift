import XCTest
@testable import InsightOut

final class InsightOutTests: XCTestCase {
    func test_init() throws {
        let context = CoreDataStack.preview.context
        let sut = MoodEntryObject(context: context)
        let testTime = Date(timeIntervalSince1970: 0)
        sut.time = testTime

        XCTAssertEqual(testTime, sut.time, "MoodEntryObject's date should be settable")
    }

    func test_persistence() throws {
        let context = CoreDataStack.preview.context
        let sut = MoodEntryObject(context: context)
        let testTime = Date(timeIntervalSince1970: 0)
        sut.time = testTime
        sut.label = 1

        try context.save()

        let fetch = MoodEntryObject.createFetchRequest()
        fetch.predicate = NSPredicate(format: "label = %d", 1)

        let results = try context.fetch(fetch)

        let result = results[0]

        XCTAssertEqual(result.time, testTime, "MoodEntryObject's time is not persisted")
        XCTAssertEqual(result.label, 1, "MoodEntryObject's label is not persisted")
    }
}
