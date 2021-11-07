//
//  WeekPieChartLegend.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut

struct WeekPieChartLegend: View {
    let entries: [ChartData]
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let total = calculateTotal(entries)
            ScrollView {
                
                ForEach(0..<entries.count) { index in
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color(String(describing: entries[index].mood)))
                                .frame(width: width * 0.12, height: width * 0.12)
                            
                            Emoji(mood: entries[index].mood)
                                .foregroundColor(Color(String(describing: entries[index].mood)))
                                .frame(width: width * 0.08, height: width * 0.08)
                            
                        }
                        let frequency = entries[index].value
                        
                        let percentage = frequency / total
                        Text(" \(String(format: "%.0f", round(percentage * 100)))%")
                            .font(Font.system(size: width * 0.1, weight: .bold))
                    }
                    
                }
            }
            .frame(width: width, height: width * 0.5)
        }
    }
    func calculateTotal(_ entries: [ChartData]) -> CGFloat {
        var total: CGFloat = 0
        for entry in entries {
            total += entry.value
        }
        return total
    }
}

struct WeekPieChartLegend_Previews: PreviewProvider {
    static var previews: some View {
        let entries: [ChartData] = [
            ChartData(mood: Mood.fear, value: 7),
            ChartData(mood: Mood.surprised, value: 3),
            ChartData(mood: Mood.anger, value: 3)
        ]
        WeekPieChartLegend(entries: entries)
    }
}
