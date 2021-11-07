//
//  WeekView.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI

struct WeekView: View {
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
        WeekView()
    }
}
