//
//  ContentView.swift
//  Shared
//
//  Created by Kevin Peng on 2021-11-05.
//

import SwiftUI
import InsightOut
struct ContentView: View {
    
    var body: some View {
      EmojiWheel()
            .frame(width: 300, height: 300)
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
