//
//  MonthView.swift
//  InsightOut
//
//  Created by Kevin Peng on 2021-11-06.
//

import SwiftUI
import InsightOut

struct MonthView: View {

    let entries: [MoodEntry]
    
    var body: some View {
        let columns: [GridItem] = [GridItem](repeating: GridItem(.flexible()), count: 7)
        LazyVGrid(columns: columns) {
            ForEach(entries) { entry in
                Color("\(entry.mood)")
                    .frame(height: 40)
            }
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static let entries: [MoodEntry] = {
        (0 ..< 30).map { day in
            let date = Date(timeIntervalSince1970: Double(day) * 86400)
            let moods = Mood.allCases[day % Mood.allCases.count]
            return MoodEntry(time: date, mood: moods)

        }
    }()
    
    static var previews: some View {
        MonthView(entries: entries)
    }
}

extension MoodEntry: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(mood.rawValue)
        hasher.combine(time.hashValue)
    }

    public static func == (lhs: MoodEntry, rhs: MoodEntry) -> Bool {
        lhs.mood == rhs.mood && lhs.time == rhs.time
    }
}

extension MoodEntry: Identifiable {
    public var id: Int {
        hashValue
    }
}
