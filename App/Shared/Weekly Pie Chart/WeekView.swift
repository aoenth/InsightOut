//
//  WeekView.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut

struct WeekView: View {
    
    let entries: [MoodEntry]
    
    var body: some View {
        VStack {
            let data = createChartData(findSavedEmojis(entries))
            WeekPieChart(entries: data)
                .padding(.bottom)
            WeekPieChartLegend(entries: data)
        }
    }
    
    func findSavedEmojis(_ entries: [MoodEntry]) -> [Mood] {
        var savedEmojis: [Mood] = []
        for mood in Mood.allCases {
            for entry in entries {
                if mood == entry.mood {
                    savedEmojis.append(entry.mood)
                }
            }
        }
        return savedEmojis
    }
    
    func createChartData(_ savedEmojis: [Mood]) -> [ChartData] {
        var chartData: [ChartData] = []
        for mood in Mood.allCases {
            var frequency: CGFloat = 0
            for savedEmoji in savedEmojis {
                if mood == savedEmoji {
                    frequency += 1
                }
            }
            if frequency != 0 {
                chartData.append(ChartData(mood: mood, value: frequency))
            }
        }
        return chartData
    }
}

struct WeekView_Previews: PreviewProvider {

    static var previews: some View {
        let entries: [MoodEntry] = {
            var entries = [MoodEntry]()
            let dates = (-30 ..< 30).map { day in
                Calendar.current.date(byAdding: .day, value: day, to: Date())!
            }

            for date in dates {
                let mood = Mood.allCases.randomElement()!
                entries.append(MoodEntry(time: date, mood: mood))
            }
            return entries
        }()

        WeekView(entries: entries)
    }
}
