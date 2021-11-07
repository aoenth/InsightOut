//
//  WeekPieChartLegend.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut
struct WeekPieChartLegend: View {

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            HStack {
                
                ForEach(Mood.allCases, id: \.self) { mood in
                    ZStack {
                        Circle()
                            .fill(Color(String(describing: mood)))
                            .frame(width: width * 0.12, height: width * 0.12)
                        
                        Emoji(mood: mood)
                            .foregroundColor(Color(String(describing: mood)))
                            .frame(width: width * 0.08, height: width * 0.08)
                    }
                }
            }
            .frame(width: width, height: width * 0.12)
        }
    }
}

struct WeekPieChartLegend_Previews: PreviewProvider {
    static var previews: some View {
        WeekPieChartLegend()
    }
}
