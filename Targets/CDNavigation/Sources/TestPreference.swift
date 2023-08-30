//
//  TestPreference.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/25.
//

import SwiftUI


public struct TestPreferenceKey: PreferenceKey {
    public static var defaultValue: Bool = false
    public static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct SecoundScreenView: View {
    var body: some View{
        ZStack{
            NavigationView {
                SecoundScreenView1()
                    
            }
        }
        .onPreferenceChange(TestPreferenceKey.self){ value in
            print("change v \(value)")
        }
        
    }
}


struct SecoundScreenView1: View {
    @State var isChanged: Bool = false
    
    var body: some View{
        NavigationLink("new"){
//            SecoundScreenView2(isChanged: $isChanged)
//                .preference(key: TestPreferenceKey.self, value: isChanged)
//                .onAppear {
//                    self.isChanged = true
//                }
            
        }
        
    }
}

struct SecoundScreenView2<Content: View>: View {

//    @Binding var isChanged: Bool
    
    var chagngeOffser: (CGFloat) -> ()
    var content: () -> Content
    
    var body: some View {
        ScrollView{
            content()
        }
    }
}


struct TestV_Previews: PreviewProvider {
    static var previews: some View {
        SecoundScreenView2 { offset in
            ///
        } content: {
            EmptyView()
        }

        
    }
}
