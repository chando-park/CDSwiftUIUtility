//
//  CDPDFViewerView.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/09/13.
//

import SwiftUI
import PDFKit

//struct CDPDFViewerView: View {
//    
//    @State private var isDownloading = false
//    @State var activityItmes: [Any] = []
//    var body: some View {
//        
//        Button("Share Link") {
////            self.isActivityViewPresented = true
//            
//            self.downloadFile(urlStr: "https://cdn.littlefox.co.kr/phonicsworks/pdf/PW01.pdf") { destination, erorrMessage in
//                if let destination = destination{
//                activityItmes = [destination]
//                }
//            }
//        }
//        .background(
//            ActivityView(
//                activityItmes: $activityItmes
//            )
//        )
//    }
//    
//    
//    func downloadFile(urlStr: String) ->  {
//        // Replace with the URL of the file you want to download.
//        guard let fileURL = URL(string: urlStr) else {
//            completed(nil, "invalid url address")
//            return
//        }
//        
//        self.isDownloading = true
//        
//        let task = URLSession.shared.downloadTask(with: fileURL) { localURL, response, error in
//            defer {
//                isDownloading = false
//            }
//            
//            let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("downloadedFile.pdf")
//            
//            
//            
//            
//            downloadCancellable = URLSession.shared
//                .downloadTaskPublisher(for: fileURL)
//                .receive(on: DispatchQueue.main)
////                .sink(receiveCompletion: { completion in
////                    switch completion {
////                    case .finished:
////                        break
////                    case .failure(let error):
////                        print("Download error: \(error)")
////                    }
////                    self.isDownloading = false
////                }, receiveValue: { value in
////                    self.downloadProgress = Double(value.progress.completedUnitCount) / Double(value.progress.totalUnitCount)
////                    do {
////                        try FileManager.default.moveItem(at: value.fileURL, to: destinationURL)
////                        print("File downloaded to: \(destinationURL)")
////                    } catch {
////                        print("Error saving downloaded file: \(error)")
////                    }
////                })
//        }
//        
//    }
//    
//    struct CDPDFViewerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CDPDFViewerView()
//    }
//}
