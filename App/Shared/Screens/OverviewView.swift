
//
//  OverviewView.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI
import InsightOut

extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}

struct OverviewView: View {
    
    @State var selectedTime = 0
    
    @State var selectedEmotion = 7
    let emotionLookup = [
        "happiness":0,
        "sadness":1,
        "love":2,
        "fear":3,
        "disgust":4,
        "surprised":5,
        "anger":6,
        "all":7
    ]

    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color(emotionLookup.key(from: selectedEmotion) ?? "white"), .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                
                Picker("Tap Me", selection: $selectedTime) {
                    Text("Week").tag(0)
                    Text("Month").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                GeometryReader { proxy in
                    let width = proxy.size.width
                    HStack(spacing: 5) {
                        
                        ForEach(Mood.allCases, id: \.self) { mood in
                            
                            Button{
                                
                                selectedEmotion = emotionLookup[String(describing: mood)]!
                                
                            } label:{
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
                        
                        Button{
                            selectedEmotion = emotionLookup["all"]!
                            print(selectedEmotion)
                        }label:{
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                                Text("All")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .frame(width: width, height: width * 0.12)
                }
            }.padding()
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}

