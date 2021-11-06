import Foundation

public enum Mood: Int32, CaseIterable {
    case happiness = 0
    case sadness
    case love
    case fear
    case disgust
    case surprised
    case anger
}

public enum Label: Int32, CaseIterable {
    case family = 0
    case work
}

public struct MoodEntry {

    public let time: Date
    public let mood: Mood
    public let label: Label

    public init(time: Date, mood: Mood, label: Label) {
        self.time = time
        self.mood = mood
        self.label = label
    }
}
