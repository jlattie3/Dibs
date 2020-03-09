//
//  ScannerViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 2/10/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import CoreNFC

class ScannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        guard NFCReaderSession.readingAvailable else {
            print("NFC Reading Not Available")
            return
        }
        print("NFC Available")
    
    }
    
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        
        print("Scan button tapped")
        // 1
        let session = NFCNDEFReaderSession(
            delegate: self,
            queue: nil,
            invalidateAfterFirstRead: false
        )
        // 2
        session.alertMessage = "Hold your iPhone near a seat tag to scan it."
        // 3
        session.begin()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ScannerViewController: NFCNDEFReaderSessionDelegate {

    // 1
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("Started scanning for tags")
    }

    // 2
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        print("Detected tags with \(messages.count) messages")
        
        for messageIndex in 0 ..< messages.count {
            
            let message = messages[messageIndex]
            print("\tMessage \(messageIndex) with length \(message.length)")
            
            for recordIndex in 0 ..< message.records.count {
                
                let record = message.records[recordIndex]
                print("\t\tRecord \(recordIndex)")
                print("\t\t\tidentifier: \(String(describing: String(data: record.identifier, encoding: .utf8)))")
                print("\t\t\ttype: \(String(describing: String(data: record.type, encoding: .utf8)))")
                print("\t\t\tpayload: \(String(describing: String(data: record.payload, encoding: .utf8)))")
            }
        }
    }
    
    // 3
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session did invalidate with error: \(error)")
    }
}
