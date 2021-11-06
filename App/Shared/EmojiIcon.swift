//
//  EmojiIcon.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/5/21.
//

import SwiftUI
import InsightOut

struct EmojiInfo {
    let backgroundColor: Color
    let selectedEmotion: Mood
}

struct EmojiIcon: View {
    let emojiInfo: EmojiInfo

    var body: some View {
        Emoji(emojiInfo: emojiInfo)
            .ignoresSafeArea()
            .background(Color.black)
    }
}

struct Emoji: View {
    let emojiInfo: EmojiInfo

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width

            ZStack {
                Circle()
                    .fill(Color.white)

                EmojiEyes(emojiInfo: emojiInfo)
                    .offset(y: width * -0.1)
                    .frame(width: width, height: width)

                EmojiMouth(emojiInfo: emojiInfo)
                    .stroke(style: emojiInfo.selectedEmotion != Mood.surprised ? StrokeStyle(lineWidth: width * 0.08, lineCap: .round) : StrokeStyle(lineWidth: width * 0.1, lineCap: .round))
                    .fill(emojiInfo.backgroundColor)
                    .offset(y: width * 0.2)
                    .frame(width: width * 0.5, height: width * 0.5)
            }
        }
    }
}

struct EmojiEyes: View {
    let emojiInfo: EmojiInfo
    let eyeScale: CGFloat = 0.2

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width

            HStack(spacing: width * 0.2) {

                switch emojiInfo.selectedEmotion {

                case Mood.happiness:
                    ForEach(0..<2) {_ in
                        Circle()
                            .fill(emojiInfo.backgroundColor)
                            .frame(width: width * eyeScale, height: width * eyeScale)
                    }
                case Mood.sadness:
                    ForEach(0..<2) {_ in
                        Circle()
                            .fill(emojiInfo.backgroundColor)
                            .frame(width: width * eyeScale, height: width * eyeScale)
                    }

                case Mood.love:
                    ForEach(0..<2) {_ in
                        Image(systemName: "heart.fill")
                            .foregroundColor(emojiInfo.backgroundColor)
                            .font(Font.system(size: width * 0.2, weight: .semibold))
                            .frame(width: width * eyeScale, height: width * eyeScale)
                    }
                case Mood.fear:
                    ForEach(0..<2) {_ in
                        Circle()
                            .fill(emojiInfo.backgroundColor)
                            .frame(width: width * eyeScale, height: width * eyeScale)
                    }

                case Mood.disgust:
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
                case Mood.surprised:
                    ForEach(0..<2) {_ in
                        Circle()
                            .fill(emojiInfo.backgroundColor)
                            .frame(width: width * eyeScale, height: width * eyeScale)

                    }
                case Mood.anger:
                    HStack(spacing: width * 0.1) {
                        ZStack {
                            Capsule()
                                .rotation(Angle(degrees: 20))
                                .fill(emojiInfo.backgroundColor)

                                .frame(width: width * eyeScale * 1.5, height: width * eyeScale * 0.5)
                                .offset(y:width * -0.1)
                            Circle()
                                .fill(emojiInfo.backgroundColor)
                                .frame(width: width * eyeScale, height: width * eyeScale)
                        }
                        ZStack {
                            Capsule()
                                .rotation(Angle(degrees: -20))
                                .fill(emojiInfo.backgroundColor)

                                .frame(width: width * eyeScale * 1.5, height: width * eyeScale * 0.5)
                                .offset(y:width * -0.1)
                            Circle()
                                .fill(emojiInfo.backgroundColor)
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
    let emojiInfo: EmojiInfo
    
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            switch emojiInfo.selectedEmotion {
            case Mood.happiness:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.maxY))
            case Mood.sadness:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY * 1.2))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY * 1.2), control: CGPoint(x: rect.midX, y: rect.midY * 0.6))
            case Mood.love:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.maxY))
            case Mood.fear:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY * 1.1), control: CGPoint(x: rect.midX / 1.5, y: rect.midY * 1.3))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY * 0.9), control: CGPoint(x: rect.midX * 1.5, y: rect.midY * 0.7))
                
            case Mood.disgust:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.midY))
                path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.midY))
                
            case Mood.surprised:
                let size = rect.width * 0.2
                path.move(to: CGPoint(x: rect.midX, y: rect.midY))
                path.addEllipse(in: CGRect(origin: CGPoint(x: rect.midX - size / 2 , y: rect.midY), size: CGSize(width: size , height: size * 0.4)))
                   
            case Mood.anger:
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
                EmojiIcon(emojiInfo: EmojiInfo(backgroundColor: Color.black, selectedEmotion: mood))
                    .frame(width: 75, height: 75)
            }
        }
        .padding()
        .background(Color.white)
        .previewLayout(.sizeThatFits)
    }
}
