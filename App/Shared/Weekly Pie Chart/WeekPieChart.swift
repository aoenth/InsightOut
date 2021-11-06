//
//  WeekPieChart.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
// WITH GREAT HELP FROM : https://github.com/BLCKBIRDS/Pie-Chart-in-SwiftUI
import SwiftUI
import InsightOut

struct WeekPieChart: View {
    let data: [ChartData]
    let separatorColor = Color.white
    let accentColors = pieColors

//    @State private var currentValue = ""
//    @State private var currentLabel = ""
    @State private var touchLocation: CGPoint = .init(x: -1, y: -1)
    
    var pieSlices: [PieSlice] {
        var slices = [PieSlice]()
        data.enumerated().forEach {(index, data) in
            let value = normalizedValue(index: index, data: self.data)
            let mood = self.data[index].mood
            let label = self.data[index].label
            if slices.isEmpty {
                slices.append((.init(startDegree: 0, endDegree: value * 360, mood: mood, label: label)))
            } else {
                slices.append(.init(startDegree: slices.last!.endDegree, endDegree: (value * 360 + slices.last!.endDegree), mood: mood, label: label))
            }
        }
        return slices
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack  {
                    ForEach(0..<self.data.count){ i in
                        ZStack {
                            WeekPieChartSlice(label: pieSlices[i].label, mood: pieSlices[i].mood, center: CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in:  .local).midY), radius: geometry.frame(in: .local).width/2, startDegree: pieSlices[i].startDegree, endDegree: pieSlices[i].endDegree, isTouched: sliceIsTouched(index: i, inPie: geometry.frame(in:  .local)), accentColor: accentColors[i], separatorColor: separatorColor, size: geometry.frame(in: .local).width)
                        }
                    }
                }
                .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { position in
                                //let pieSize = geometry.frame(in: .local)
                                touchLocation   =   position.location
                                //updateCurrentValue(inPie: pieSize)
                    }
                )
            }
            .aspectRatio(contentMode: .fit)
        }
    }
    
    //    func updateCurrentValue(inPie pieSize: CGRect)  {
    //        guard let angle = angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation) else { return}
    //        let currentIndex = pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) ?? -1
    //        currentLabel = data[currentIndex].label
    //        currentValue = "\(data[currentIndex].value)"
    //    }
    
    func sliceIsTouched(index: Int, inPie pieSize: CGRect) -> Bool {
        guard let angle = angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation) else { return false }

        return pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) == index
    }
    
}

struct WeekPieChart_Previews: PreviewProvider {
    static var previews: some View {
        WeekPieChart(data: emojiChartDataSet)
    }
}
