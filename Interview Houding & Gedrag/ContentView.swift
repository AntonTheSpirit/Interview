//
//  ContentView.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 0709--2020.
//  Copyright © 2020 Anton Verver. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack() {
            MailLoginView()
            
            FaceBookLoginView().frame(width: 180, height: 50,alignment: .center).padding(10)
            
            GoogleLoginView().frame(width: 140, height: 70,alignment: .center).padding(10)
        }.animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
