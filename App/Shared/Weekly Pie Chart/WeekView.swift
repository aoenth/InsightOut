//
//  WeekView.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut

struct WeekView: View {
    // MARK: THESE 2 Arrays could be just 1 thing, and value in chart data could just be a count of a mood type?
    let weekChartDataSet: [ChartData]
    let savedEmojis: [Mood]
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            VStack {
                
                WeekPieChart(data: weekChartDataSet)
                    .frame(width: width, height: width)
                    .padding(.bottom, width * 0.1)
                
                WeekPieChartLegend(savedEmojis:savedEmojis)
                    .frame(width: width, height: width)
                
                
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    
    static var previews: some View {
        let weekChartDataSet: [ChartData] = [
            ChartData(label: "Happines", mood: Mood.happiness, value: 3),
            ChartData(label: "Sadness", mood: Mood.sadness, value: 5),
        ]
        let savedEmojis = [
            Mood.happiness,
            Mood.sadness
        ]
        WeekView(weekChartDataSet: weekChartDataSet, savedEmojis: savedEmojis)
    }
}
