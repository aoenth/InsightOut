import Foundation
public enum Mood {
    case happy
}

public enum Label {
    case family
}

public struct MoodEntry {
    let time: Date
    let mood: Mood
    let label: Label
}
