import Foundation

public enum Mood {
    case happy
}

public enum Label {
    case family
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
