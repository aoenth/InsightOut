//
//  WeekPieChartSlice.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
// WITH GREAT HELP FROM: https://github.com/BLCKBIRDS/Pie-Chart-in-SwiftUI
import Foundation
import SwiftUI
import InsightOut

struct WeekPieChartSlice: View {
    let label: String
    let mood: Mood
    var center: CGPoint
    var radius: CGFloat
    var startDegree: Double
    var endDegree: Double
    var isTouched:  Bool
    var accentColor:  Color
    var separatorColor: Color
    let size: CGFloat
    
    var path: Path {
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: endDegree), clockwise: false)
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }
    
    var body: some View {
        path
            .fill(accentColor)
            .overlay(path.stroke(separatorColor, lineWidth: 2))
            .scaleEffect(isTouched ? 1.1 : 1)
            .animation(Animation.spring())
    }
}

struct PieChartSlice_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPieChartSlice(label: "Happiness", mood: Mood.happiness, center: CGPoint(x: 350, y: 200), radius: 300, startDegree: 90, endDegree: 90 + 90, isTouched: true, accentColor: .orange, separatorColor: .black, size: 600)
        
    }
}
