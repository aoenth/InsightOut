//
//  PieChart.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21
// WITH GREAT HELP FROM : https://github.com/BLCKBIRDS/Pie-Chart-in-SwiftUI
import SwiftUI
import InsightOut

struct PieChart: View {
    var title: String
    var data: [ChartData]
    var separatorColor: Color
    var accentColors: [Color]
    
//    @State private var currentValue = ""
//    @State private var currentLabel = ""
    @State private var touchLocation: CGPoint = .init(x: -1, y: -1)
    

    @Binding var moodStatus: Mood
    @Binding var backgroundColor: Color
    
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
                            PieChartSlice(label: pieSlices[i].label, mood: pieSlices[i].mood, center: CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in:  .local).midY), radius: geometry.frame(in: .local).width/2, startDegree: pieSlices[i].startDegree, endDegree: pieSlices[i].endDegree, isTouched: sliceIsTouched(index: i, inPie: geometry.frame(in:  .local)), accentColor: accentColors[i], separatorColor: separatorColor, size: geometry.frame(in: .local).width)
                        }
                    }
                }
                .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { position in
                                let pieSize = geometry.frame(in: .local)
                                touchLocation   =   position.location
                                updateCurrentValue(inPie: pieSize)
                    }
                )
            }
            .aspectRatio(contentMode: .fit)
        }
        
    }
    func updateCurrentValue(inPie pieSize: CGRect)  {
        guard let angle = angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation) else { return}
        let currentIndex = pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) ?? -1
        
//        currentLabel = data[currentIndex].label
//        currentValue = "\(data[currentIndex].value)"
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

struct PieChart_Previews: PreviewProvider {
    @State static var moodStatus = Mood.happiness
    @State static var backgroundColor = Color("happiness")
    static var previews: some View {
        PieChart(title: "MyPieChart", data: chartDataSet, separatorColor: Color(UIColor.systemBackground), accentColors: pieColors, moodStatus: $moodStatus, backgroundColor: $backgroundColor)
    }
}