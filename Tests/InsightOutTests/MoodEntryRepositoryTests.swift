import XCTest
@testable import InsightOut

final class MoodEntryRepositoryTests: XCTestCase {

    func test_saveMood_shouldPersistMood() throws {
        let (_, sut) = makeSUT()
        let date = Date(timeIntervalSince1970: 1)
        sut.saveMood(.surprised, date: date, label: .work)

        let moods = sut.moods(forDate: date)
        XCTAssertEqual(moods.count, 1)

        XCTAssertEqual(moods[0].mood, .surprised)
        XCTAssertEqual(moods[0].label, .work)
    }


    func test_saveMultipleMoods_shouldBePersisted() throws {
        let (_, sut) = makeSUT()
        let dates = [1, 86400, 8640000].map(Date.init(timeIntervalSince1970:))
        let moods = Mood.allCases
        let labels = Label.allCases

        for mood in moods {
            for label in labels {
                for date in dates {
                    sut.saveMood(mood, date: date, label: label)
                }
            }
        }

        for date in dates {
            let result = sut.moods(forDate: date)
            XCTAssertEqual(result.count, moods.count * labels.count)
        }
    }

    func test_moodsForWeekStarting_shouldReturnMoodsForGivenWeek() {
        let (_, sut) = makeSUT()

        for day in 1 ..< 400 {
            let day = Double(day - 1)
            let date = Date(timeIntervalSince1970: day * 86400)
            if 3 ... 5 ~= day {
                continue
            } else {
                sut.saveMood(.anger, date: date, label: .work)
            }
        }

        let startDate = Date(timeIntervalSince1970: 1)
        let result = sut.moods(forWeekStarting: startDate)

        XCTAssertEqual(result.count, [1, 2, 6, 7].count)
    }

    // MARK: - Helpers

    private func makeSUT() -> (context: NSManagedObjectContext, sut: MoodEntryRepository) {
        let context = CoreDataStack(inMemory: true).context
        let sut = MoodEntryRepository(context: context)
        return (context, sut)
    }
}
