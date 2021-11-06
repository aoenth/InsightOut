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
                ZStack {
                    ForEach(Mood.allCases, id: \.self) { mood in
                        Emoji(mood: mood)
                            .foregroundColor(.clear)
                            .frame(width: width * 0.8, height: width * 0.8)
                        Circle()
                            .fill()
                            .frame(width: width * 0.9, height: width * 0.9)
                        
                    }
                    
                }
            }
        }
    }
}

struct WeekPieChartLegend_Previews: PreviewProvider {
    static var previews: some View {
        WeekPieChartLegend()
    }
}
