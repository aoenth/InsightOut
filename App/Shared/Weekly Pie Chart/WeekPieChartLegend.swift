//
//  WeekPieChartLegend.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut
struct WeekPieChartLegend: View {
    let savedEmojis: [Mood] // TODO: it might be MoodEntry instead?
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            VStack {
                ForEach(savedEmojis, id: \.self) { emoji in
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color(String(describing: emoji)))
                                .frame(width: width * 0.12, height: width * 0.12)
                            
                            Emoji(mood: emoji)
                                .foregroundColor(Color(String(describing: emoji)))
                                .frame(width: width * 0.08, height: width * 0.08)
                            
                        }
                        Text("Percentage %")
                            .font(Font.system(size: width * 0.1, weight: .bold))
                    }
                }
            }
            .frame(width: width, height: width * 0.12)
        }
    }
}

struct WeekPieChartLegend_Previews: PreviewProvider {
    static var previews: some View {
        let savedEmojis = [
            Mood.happiness,
            Mood.sadness
        ]
        WeekPieChartLegend(savedEmojis: savedEmojis)
    }
}
