//
//  WeekPieChart.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
// WITH GREAT HELP FROM : https://github.com/BLCKBIRDS/Pie-Chart-in-SwiftUI

import SwiftUI
import InsightOut

struct WeekPieChart: View {
    let separatorColor = Color.white
    let accentColors = pieColors
    let entries: [ChartData]
    @State private var touchLocation: CGPoint = .init(x: -1, y: -1)
    
    var pieSlices: [PieSlice] {
        var slices = [PieSlice]()
        
        entries.enumerated().forEach {(index, data) in
            let value = normalizedValue(index: index, data: self.entries)
            let mood = self.entries[index].mood
            if let last = slices.last {
                slices.append(.init(startDegree: last.endDegree, endDegree: (value * 360 + last.endDegree), mood: mood))
            } else {
                slices.append((.init(startDegree: 0, endDegree: value * 360, mood: mood)))
            }
        }
        return slices
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ForEach(0 ..< pieSlices.count) { i in
                    WeekPieChartSlice(
                        mood: pieSlices[i].mood,
                        center: CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY),
                        radius: geometry.frame(in: .local).width/2,
                        startDegree: pieSlices[i].startDegree,
                        endDegree: pieSlices[i].endDegree,
                        isTouched: sliceIsTouched(index: i, inPie: geometry.frame(in:  .local)),
                        accentColor: Color(String(describing: pieSlices[i].mood)),
                        separatorColor: separatorColor,
                        size: geometry.frame(in: .local).width)
                }
                .gesture(DragGesture(minimumDistance: 0).onChanged { position in
                    touchLocation = position.location
                })
            }
        }
        .aspectRatio(contentMode: .fit)
    }
    
    func sliceIsTouched(index: Int, inPie pieSize: CGRect) -> Bool {
        guard let angle = angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation) else { return false }
        
        return pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) == index
    }
}

struct WeekPieChart_Previews: PreviewProvider {
    static let entries: [ChartData] = [
        ChartData(mood: Mood.fear, value: 7),
        ChartData(mood: Mood.surprised, value: 3),
        ChartData(mood: Mood.anger, value: 3)
    ]
    
    static var previews: some View {
        WeekPieChart(entries: entries)
    }
}
