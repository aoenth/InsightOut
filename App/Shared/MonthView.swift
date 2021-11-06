//
//  MonthView.swift
//  InsightOut
//
//  Created by Kevin Peng on 2021-11-06.
//

import SwiftUI
import InsightOut

struct MonthView: View {
    
    let moods: [Mood]
    
    var body: some View {
        let columns: [GridItem] = [GridItem](repeating: GridItem(.flexible(minimum: 40, maximum: 400)), count: 7)
        LazyVGrid(columns: columns) {
            ForEach(moods) { mood in
                Color("\(mood)")
                    .frame(height: 20)
            }
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static let moods = [[Mood]](repeating: Mood.allCases, count: 20).flatMap { $0 }
    
    static var previews: some View {
        MonthView(moods: moods)
    }
}

extension Mood: Identifiable {
    public var id: Int32 {
        rawValue
    }
}
