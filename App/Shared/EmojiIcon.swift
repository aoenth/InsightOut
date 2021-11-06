//
//  EmojiIcon.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/5/21.
//

import SwiftUI
import InsightOut

struct Emoji: View {
    let mood: Mood

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width

            ZStack {
                Circle()
                    .fill(Color.white)

                EmojiEyes(mood: mood)
                    .offset(y: width * -0.1)
                    .frame(width: width, height: width)

                EmojiMouth(mood: mood)
                    .stroke(style: mood != .surprised ? StrokeStyle(lineWidth: width * 0.08, lineCap: .round) : StrokeStyle(lineWidth: width * 0.1, lineCap: .round))
                    .offset(y: width * 0.2)
                    .frame(width: width * 0.5, height: width * 0.5)
            }
        }
    }
}

struct EmojiEyes: View {
    let mood: Mood
    let eyeScale: CGFloat = 0.2

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width

            HStack(spacing: width * 0.2) {

                switch mood {

                case .happiness:
                    ForEach(0..<2) {_ in
                        Circle()
                            .frame(width: width * eyeScale, height: width * eyeScale)
                    }
                case .sadness:
                    ForEach(0..<2) {_ in
                        Circle()
                            .frame(width: width * eyeScale, height: width * eyeScale)
                    }

                case .love:
                    ForEach(0..<2) {_ in
                        Image(systemName: "heart.fill")
                            .font(Font.system(size: width * 0.2, weight: .semibold))
                            .frame(width: width * eyeScale, height: width * eyeScale)
                    }
                case .fear:
                    ForEach(0..<2) {_ in
                        Circle()
                            .frame(width: width * eyeScale, height: width * eyeScale)
                    }

                case .disgust:
                    HStack(spacing: width * 0.16) {
                        EmojiDisgust()
                            .stroke(style: StrokeStyle(lineWidth: width * 0.07, lineCap: .round))
                            .rotation(Angle(degrees: 90))
                            .frame(width: width * 0.1, height: width * 0.3)

                        EmojiDisgust()
                            .stroke(style: StrokeStyle(lineWidth: width * 0.07, lineCap: .round))
                            .rotation(Angle(degrees: 270))
                            .frame(width: width * 0.1, height: width * 0.3)
                    }
                case .surprised:
                    ForEach(0..<2) {_ in
                        Circle()
                            .frame(width: width * eyeScale, height: width * eyeScale)

                    }
                case .anger:
                    HStack(spacing: width * 0.1) {
                        ZStack {
                            Capsule()
                                .rotation(Angle(degrees: 20))

                                .frame(width: width * eyeScale * 1.5, height: width * eyeScale * 0.5)
                                .offset(y:width * -0.1)
                            Circle()
                                .frame(width: width * eyeScale, height: width * eyeScale)
                        }
                        ZStack {
                            Capsule()
                                .rotation(Angle(degrees: -20))

                                .frame(width: width * eyeScale * 1.5, height: width * eyeScale * 0.5)
                                .offset(y:width * -0.1)
                            Circle()
                                .frame(width: width * eyeScale, height: width * eyeScale)
                        }
                    }
                }
            }
            .frame(width: width, height: width)
        }
    }
}

struct EmojiDisgust: Shape {
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }
    }
}

struct EmojiMouth: Shape {
    let mood: Mood
    
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            switch mood {
            case .happiness:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.maxY))
            case .sadness:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY * 1.2))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY * 1.2), control: CGPoint(x: rect.midX, y: rect.midY * 0.6))
            case .love:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.maxY))
            case .fear:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY * 1.1), control: CGPoint(x: rect.midX / 1.5, y: rect.midY * 1.3))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY * 0.9), control: CGPoint(x: rect.midX * 1.5, y: rect.midY * 0.7))
                
            case .disgust:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.midY))
                
            case .surprised:
                let size = rect.width * 0.2
                path.move(to: CGPoint(x: rect.midX, y: rect.midY))
                path.addEllipse(in: CGRect(origin: CGPoint(x: rect.midX - size / 2 , y: rect.midY), size: CGSize(width: size , height: size * 0.4)))
                   
            case .anger:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY * 1.2))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY * 1.2), control: CGPoint(x: rect.midX, y: rect.midY * 0.6))
            }
        }
    }
}

struct EmojiIcon_Previews: PreviewProvider {
 
    static var previews: some View {
        VStack {
            ForEach(Mood.allCases, id: \.self) { mood in
                Emoji(mood: mood)
                    .frame(width: 75, height: 75)
                    .foregroundColor(.black)
                    .background(Color.black)
            }
        }
        .padding()
        .background(Color.white)
        .previewLayout(.sizeThatFits)
    }
}
