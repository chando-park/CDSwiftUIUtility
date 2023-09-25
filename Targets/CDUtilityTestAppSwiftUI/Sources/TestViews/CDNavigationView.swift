//
//  NView.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/23.
//

import SwiftUI
import CDNavigation
import CDSheetRouter
import CDOrientation

struct NavigtionTestView: View{
    let topIsect = UIScreen.main.bounds.height*(183/2436)
    @State var action: CDNavigationController.Action? = nil
    var body: some View{
        CDNavigationView(statusBarColor: .green,
                         navigationBarBackgroundType: .paint(color: .orange),
                         navigationBarTitleType: .text(title: "회원 탈퇴",subTitle: "Phonics Works 3", color: .white, font: CDNavigationController.FontInfo(size: (74.0/183.0)*self.topIsect), subTitleFont: CDNavigationController.FontInfo(size: (54.0/183.0)*self.topIsect)),
                         navigationBarHeight: topIsect,
                         closeImage: UIImage(named: "home-menu.png"),
                         backImage: UIImage(named: "home-menu.png"),
                         isNavigationBarHidden: false,
                         isBackBtnHidden: false,
                         isCloseBtnHidden: false,
                         backEvent: {
            CDOrientationLock.shared.recover()
            action = .dismiss
        },
                         action: $action){
            ZStack{
                Color.yellow
                ForumView()
                NavigationLink("new") {
                    
                    SecoundScreenView()
                        .nViewTitle("회원가입", subTitle: "Phonics Works 2")
                        .nViewCloseButtonImage(UIImage(named: "pre-menu.png"))
                        .nViewIsBackButtonHidden(false)
                        .nViewIsCloseButtonHidden(false)
                        .nViewStatusBarColor(.purple)
                        .nViewIsNaviBarHidden(false)
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

struct NView_Previews: PreviewProvider {
    static var previews: some View {
        NavigtionTestView()
    }
}



struct SecoundScreenView: View {

    var body: some View {
        VStack(spacing: 0){
            Color.black
            Color.gray
        }
        .onAppear(perform: {
//            print("Mirror(reflecting: self).subjectType \(Mirror(reflecting: self).subjectType)")
        })
        .ignoresSafeArea([.container])
    }
}

struct ForumElementPresentData: Identifiable, Hashable{
    let id: Int
    let title: String
    let date: String
    let isAnnouncement: Bool
    let isNew: Bool
}

struct ForumCell: View {
    
    let isAnnouncement: Bool
    let isNew: Bool
    let title: String
    let date: String?
    
    let id: Int
    let size: CGSize
    
    var event: (Int) -> ()
    var body: some View {
        Button(action: {
            event(self.id)
        }) {
            VStack {
                Text(self.title)
                if let date = date {
                    Text(date)
                }
            }
            .frame(width: self.size.width, height: self.size.height)
            .background(Color.white)
            .cornerRadius(self.size.height * 0.15)
        }
    }
}


struct ForumView: View {
    
    let data: [ForumElementPresentData] = [
        ForumElementPresentData(id: 1, title: "title1", date: "2023.06.23", isAnnouncement: true, isNew: true),
        ForumElementPresentData(id: 2, title: "title2", date: "2023.06.24", isAnnouncement: false, isNew: true),
        ForumElementPresentData(id: 3, title: "title3", date: "2023.06.25", isAnnouncement: false, isNew: false),
        ForumElementPresentData(id: 4, title: "title4", date: "2023.06.26", isAnnouncement: false, isNew: false),
        ForumElementPresentData(id: 5, title: "title5", date: "2023.06.27", isAnnouncement: false, isNew: false),
        ForumElementPresentData(id: 6, title: "title6", date: "2023.06.28", isAnnouncement: false, isNew: false),
        ForumElementPresentData(id: 7, title: "title1", date: "2023.06.23", isAnnouncement: true, isNew: true),
        ForumElementPresentData(id: 8, title: "title2", date: "2023.06.24", isAnnouncement: false, isNew: true),
        ForumElementPresentData(id: 9, title: "title3", date: "2023.06.25", isAnnouncement: false, isNew: false),
        ForumElementPresentData(id: 10, title: "title4", date: "2023.06.26", isAnnouncement: false, isNew: false),
        ForumElementPresentData(id: 11, title: "title5", date: "2023.06.27", isAnnouncement: false, isNew: false),
        ForumElementPresentData(id: 12, title: "title6", date: "2023.06.28", isAnnouncement: false, isNew: false),
    ]
    
    var body: some View {
        //CGSize(width: geo.measure(.width(1041), height: geo.measure(.height(303))
        GeometryReader { geo in
//            ZStack{
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        ForEach(data, id: \.id) { item in
                            ForumCell(isAnnouncement: item.isAnnouncement,
                                      isNew: item.isNew,
                                      title: item.title,
                                      date: item.date,
                                      id: item.id,
                                      size: CGSize(width: geo.measure(.width(1041)), height: geo.measure(.height(303)))) { tag in
                                print("tag \(tag)")
                            }
//                            Spacer().frame(width: geo.measure(.height(10)))
                        }
                    }.frame(width: geo.size.width)
                    
                }
            
                
//            }
        }
        .background(Color.red)
    }
}


extension GeometryProxy{
    public var guideResolution: CGSize {
        return CGSize(width: 1125, height: 2436)
    }
    
    public enum Measurement {
        case width(_ amount: CGFloat)
        case height(_ amount: CGFloat)
        case boxHeight(_ amount: CGFloat, guideWidth: CGFloat, guideHeight: CGFloat)
        case boxWidth(_ amount: CGFloat, guideWidth: CGFloat, guideHeight: CGFloat)
        case x(_ amount: CGFloat)
        case y(_ amount: CGFloat)
    }
    
    public func measure(_ kind: Measurement) -> CGFloat{
        switch kind {
        case .width(let amount):
            return self.size.width * (amount/guideResolution.width)
        case .height(let amount):
            return self.size.height * (amount/guideResolution.height)
        case .boxHeight(let amount, guideWidth: let guideWidth, guideHeight: let guideHeight):
            return amount * (guideHeight/guideWidth)
        case .boxWidth( let amount, guideWidth: let guideWidth, guideHeight: let guideHeight):
            return amount * (guideWidth/guideHeight)
        case .x(let amount):
            return self.size.width * (amount/guideResolution.width)
        case .y(let amount):
            return self.size.height * (amount/guideResolution.height)
        }
    }
}
