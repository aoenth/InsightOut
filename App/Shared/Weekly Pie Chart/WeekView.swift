//
//  WeekView.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut

struct WeekView: View {
    
    let weekChartDataSet: [ChartData]
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            VStack {
                
                WeekPieChart(data: weekChartDataSet)
                    .frame(width: width, height: width)
                    .padding(.bottom, width * 0.1)
                
                WeekPieChartLegend()
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
            ChartData(label: "Love", mood: Mood.love, value: 9)
        ]
        WeekView(weekChartDataSet: weekChartDataSet)
    }
}
