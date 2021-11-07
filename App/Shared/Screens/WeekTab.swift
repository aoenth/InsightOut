//
//  WeekTab.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/7/21.
//

import SwiftUI
import InsightOut

struct WeekTab: View {
    
    @EnvironmentObject var loader: Loader
    @State private var entries = [MoodEntry]()
    
    var body: some View {
        WeekView(entries: entries)
            .onAppear {
                load()
            }
    }
    
    private func load() {
//        let startDay = Calendar.current.date(byAdding: .day, value: -7, to: Date())
//        let moods = loader.moods(forWeekStarting: startDay!)
//        entries = moods.values.flatMap { $0 }
        
        let dates = (-30 ..< 30).map { day in
            Calendar.current.date(byAdding: .day, value: day, to: Date())!
        }
        
        for date in dates {
            let mood = Mood.allCases.randomElement()!
            entries.append(MoodEntry(time: date, mood: mood))
        }
    }
}

struct WeekTab_Previews: PreviewProvider {
    static var previews: some View {
        WeekTab()
            .environmentObject(MoodEntryRepository(context: CoreDataStack.preview.context))
    }
}
