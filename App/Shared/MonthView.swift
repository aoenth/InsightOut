//
//  MonthView.swift
//  InsightOut
//
//  Created by Kevin Peng on 2021-11-06.
//

import SwiftUI
import InsightOut

struct MonthView: View {

    let entries: [Date: [MoodEntry]]
    
    var body: some View {
        let columns: [GridItem] = [GridItem](repeating: GridItem(.flexible()), count: 7)

        // Limit the number of days displayed to 5 weeks
        let maxNumberOfDaysShown = 5 * 7
        let data = entries
            .sorted { $0.key < $1.key }
            .prefix(maxNumberOfDaysShown)
        LazyVGrid(columns: columns) {
            ForEach(data, id: \.0) { (date, entries) in
                let dominantMood = findMax(entries)
                ZStack {
                    HStack(spacing: 0) {
                        ForEach(entries) { entry in
                            Color("\(entry.mood)")
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Emoji(mood: dominantMood)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("\(dominantMood)"))
                }
                .frame(height: 40)
            }
        }
    }

    func findMax(_ entries: [MoodEntry]) -> Mood {
        var hashMap = [Mood: Int]()
        for entry in entries {
            hashMap[entry.mood, default: 0] += 1
        }
        var currentMax = 0
        var maxMood = Mood.happiness
        for (key, value) in hashMap {
            if value > currentMax {
                maxMood = key
                currentMax = value
            }
        }
        return maxMood
    }
}

@available(iOS 15, *)
struct MonthView_Previews: PreviewProvider {
    static let entries: [Date: [MoodEntry]] = {
        (0 ..< 3).reduce(into: [Date: [MoodEntry]]()) { prev, day in
            let date = Date(timeIntervalSince1970: Double(day) * 86400)
            let moods = Mood.allCases.shuffled().map { MoodEntry(time: date, mood: $0) }
            prev[date] = moods
        }
    }()
    
    static var previews: some View {
        MonthView(entries: entries)
            .padding()
    }
}

extension MoodEntry: Identifiable {
    public var id: String {
        String(describing: mood.rawValue) + String(describing: time)
    }
}
