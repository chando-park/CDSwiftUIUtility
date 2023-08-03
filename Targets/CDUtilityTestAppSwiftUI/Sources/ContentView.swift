//
//  ContentView.swift
//  CDUtiltyTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import SwiftUI
import CDWeb


enum ViewType{
    case web
    var view: some View{
        WebTestView()
    }
}

struct ContentView: View{
    var body: some View {
        ViewType.web.view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
