//
//  PieChart.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21
// WITH GREAT HELP FROM : https://github.com/BLCKBIRDS/Pie-Chart-in-SwiftUI

import SwiftUI
import InsightOut

struct EmojiPieChart: View {
    let data: [ChartData]
    let separatorColor = Color.white
    let accentColors = pieColors

    @State private var touchLocation: CGPoint = .init(x: -1, y: -1)
    @Binding var moodStatus: Mood
    @Binding var backgroundColor: Color
    
    var pieSlices: [PieSlice] {
        var slices = [PieSlice]()
        data.enumerated().forEach {(index, data) in
            let value = normalizedValue(index: index, data: self.data)
            let mood = self.data[index].mood
            if let last = slices.last {
                slices.append(.init(startDegree: last.endDegree, endDegree: (value * 360 + last.endDegree), mood: mood))
            } else {
                slices.append((.init(startDegree: 0, endDegree: value * 360, mood: mood)))
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
                            EmojiPieChartSlice(mood: pieSlices[i].mood, center: CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in:  .local).midY), radius: geometry.frame(in: .local).width/2, startDegree: pieSlices[i].startDegree, endDegree: pieSlices[i].endDegree, isTouched: sliceIsTouched(index: i, inPie: geometry.frame(in:  .local)), accentColor: accentColors[i], separatorColor: separatorColor, size: geometry.frame(in: .local).width)
                        }
                    }
                }
                .gesture(DragGesture(minimumDistance: 0).onChanged { position in
                    touchLocation = position.location
                })
            }
            .aspectRatio(contentMode: .fit)
        }
        
    }
    
    func sliceIsTouched(index: Int, inPie pieSize: CGRect) -> Bool {
        guard let angle = angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation) else { return false }
        guard let selectedSliceIndex = pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) else { return false }
        DispatchQueue.main.async {
            moodStatus = pieSlices[selectedSliceIndex].mood
            backgroundColor = accentColors[selectedSliceIndex]
            
        }
        return pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) == index
    }
}

struct EmojiPieChart_Previews: PreviewProvider {
    @State static var moodStatus = Mood.happiness
    @State static var backgroundColor = Color("happiness")
    
    static let emojiChartDataSet = [
      ChartData(mood: Mood.happiness, value: 360/7),
      ChartData(mood: Mood.sadness, value: 360/7),
      ChartData(mood: Mood.love, value: 360/7),
      ChartData(mood: Mood.disgust, value: 360/7),
      ChartData(mood: Mood.fear, value: 360/7),
      ChartData(mood: Mood.surprised, value: 360/7),
      ChartData(mood: Mood.anger, value: 360/7),
       
   ]
    
    static var previews: some View {
        EmojiPieChart(data: emojiChartDataSet, moodStatus: $moodStatus, backgroundColor: $backgroundColor)
    }
}
