//
//  PrintTermView.swift
//  oraculo
//
//  Created by otavio on 11/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI
import PDFKit

struct PrintTermView: View {
    @Binding public var student: Student
    @Binding public var showingModal: Bool
    
    var fileNameDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "__yyyy:MM:dd-hh.mm.ss"
        return formatter
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm"
        return formatter
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Occurrences")) {
                    ForEach(student.occurrences) { occurrence in
                        HStack {
                            Text(occurrence.reference.text).bold()
                            Spacer()
                            Text("\(occurrence.data, formatter: self.dateFormatter)")
                        }
                    }
                }
                    
            }
        
            
            
            .navigationBarTitle(Text("Print Term"), displayMode: .inline)
            .navigationBarItems(leading:
                
                Button(action: {
                    self.showingModal = false
                }) {
                    Text("Cancel")
                }
                .frame(height: 40)
                
            , trailing:
                
                Button(action: {
                    self.onShare()
                }) {
                    Text("Share")
                }
                .frame(height: 40)
                
            )
        }
    }
    
    func onShare() {
        self.sharePDF(filePath: self.generatePDF(occurrences: self.student.occurrences), excludedActivityTypes: [.airDrop, .message])
        self.showingModal = false
    }
    
    func generatePDF(occurrences: [Occurrence]) -> String{
        let fileName = "\(student.name)_\(student.grade)\(student.className)_\(fileNameDateFormatter.string(from: Date())).pdf"
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (documentDirectory as NSString).appendingPathComponent(fileName) as String
        let pdfTitle = "Commitment Term"
        let pdfMetadata = [
            kCGPDFContextCreator: "Oraculo",
            kCGPDFContextAuthor: Model.instance.currentUser.name,
            kCGPDFContextTitle: pdfTitle,
            kCGPDFContextOwnerPassword: "123"
        ]
        UIGraphicsBeginPDFContextToFile(filePath, CGRect.zero, pdfMetadata)
        UIGraphicsBeginPDFPage()
        
        let pageSize = UIGraphicsGetPDFContextBounds().size
        let font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        
        //Title
        var attributedPDFTitle = NSAttributedString(string: pdfTitle, attributes: [NSAttributedString.Key.font: font])
        var stringSize = attributedPDFTitle.size()
        var stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: 20, width: stringSize.width, height: stringSize.height)
        attributedPDFTitle.draw(in: stringRect)
        
        //nome do aluno
        attributedPDFTitle = NSAttributedString(string: "Student: \(self.student.name) - \(self.student.grade)\(self.student.className)", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)])
        stringSize = attributedPDFTitle.size()
        stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: 75, width: stringSize.width, height: stringSize.height)
        attributedPDFTitle.draw(in: stringRect)
        
        //occurences title
        attributedPDFTitle = NSAttributedString(string: "Occurrences:", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)])
        stringSize = attributedPDFTitle.size()
        stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: 125, width: stringSize.width, height: stringSize.height)
        attributedPDFTitle.draw(in: stringRect)
        
        
        //occurences
        var i = 200
        for occurence in occurrences {
            if i >= Int(pageSize.height * 0.75) {
                UIGraphicsBeginPDFPage()
                i = 60
            }
            
            attributedPDFTitle = NSAttributedString(string: "\(occurence.reference.text) - \(dateFormatter.string(from: occurence.data))", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)])
            stringSize = attributedPDFTitle.size()
            stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: CGFloat(i), width: stringSize.width, height: stringSize.height)
            attributedPDFTitle.draw(in: stringRect)
            i += 30
        }
        
        attributedPDFTitle = NSAttributedString(string: "--------------------------------------", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)])
        stringSize = attributedPDFTitle.size()
        stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: pageSize.height * 0.85, width: stringSize.width, height: stringSize.height)
        attributedPDFTitle.draw(in: stringRect)
        
        attributedPDFTitle = NSAttributedString(string: "Signature of the Responsible", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)])
        stringSize = attributedPDFTitle.size()
        stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: pageSize.height * 0.85 + 25, width: stringSize.width, height: stringSize.height)
        attributedPDFTitle.draw(in: stringRect)
        
        UIGraphicsEndPDFContext()
        return filePath
    }
    
    func sharePDF(filePath: String, excludedActivityTypes: [UIActivity.ActivityType]? = nil) {
        guard let source = UIApplication.shared.windows.last?.rootViewController else { return }
        
        if FileManager.default.fileExists(atPath: filePath) {
            let url = URL(fileURLWithPath: filePath)
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            vc.excludedActivityTypes = excludedActivityTypes
            vc.popoverPresentationController?.sourceView = source.view
            source.present(vc, animated: true)
        }
    }
}

struct PrintTermView_Previews: PreviewProvider {
    static var previews: some View {
        //PrintTermView()
        Text("")
    }
}
