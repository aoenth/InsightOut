//
//  WeekPieChart.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
// WITH GREAT HELP FROM : https://github.com/BLCKBIRDS/Pie-Chart-in-SwiftUI

import SwiftUI
import InsightOut

extension Array where Element == ChartData {
    var pieSlices: [PieSlice] {
        var slices = [PieSlice]()

        enumerated().forEach {(index, data) in
            let value = normalizedValue(index: index, data: self)
            let mood = self[index].mood
            if let last = slices.last {
                slices.append(.init(startDegree: last.endDegree, endDegree: (value * 360 + last.endDegree), mood: mood))
            } else {
                slices.append((.init(startDegree: 0, endDegree: value * 360, mood: mood)))
            }
        }
        return slices
    }
}

extension PieSlice: Identifiable {
    var id: String {
        "\(startDegree)" + "\(endDegree)" + "\(mood.rawValue)"
    }
}

struct WeekPieChart: View {
    let separatorColor = Color.white
    let accentColors = pieColors
    let entries: [ChartData]
    @State private var touchLocation: CGPoint = .init(x: -1, y: -1)

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ForEach(entries.pieSlices) { slice in
                    WeekPieChartSlice(
                        mood: slice.mood,
                        center: CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY),
                        radius: geometry.frame(in: .local).width/2,
                        startDegree: slice.startDegree,
                        endDegree: slice.endDegree,
                        isTouched: sliceIsTouched(slice: slice, inPie: geometry.frame(in:  .local)),
                        accentColor: Color(String(describing: slice.mood)),
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
    
    func sliceIsTouched(slice: PieSlice, inPie pieSize: CGRect) -> Bool {
        guard let angle = angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation) else { return false }
        let findClosure: (PieSlice) -> Bool = {
            $0.startDegree < angle && $0.endDegree > angle
        }
        if let foundSlice = entries.pieSlices.first(where: findClosure) {
            return foundSlice.id == slice.id
        }
        return false
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
