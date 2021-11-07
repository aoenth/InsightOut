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
        GeometryReader { proxy in
            let width = proxy.size.width
            VStack {
                let data = createChartData(findSavedEmojis(entries))
                WeekPieChart(entries: data)
                    .frame(width: width, height: width)
                    .padding(.bottom, width * 0.3)
                
                
                WeekPieChartLegend(entries: data)
                    .frame(width: width, height: width)
                
            }
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
        let entries = [
            MoodEntry(time: Date(), mood: Mood.sadness),
            MoodEntry(time: Date(), mood: Mood.happiness),
            MoodEntry(time: Date(), mood: Mood.love),
            MoodEntry(time: Date(), mood: Mood.love),
            MoodEntry(time: Date(), mood: Mood.love)
        ]
        WeekView(entries: entries)
    }
}
