//
//  ViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 1/6/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreNFC

class ViewController: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.testButton.layer.cornerRadius = CGFloat(22.0)
//                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
                
            } else {
                
            }
        }
        
        guard NFCReaderSession.readingAvailable else {
            print("NFC Reading Not Available")
            return
        }
        print("NFC Available")
        
        // 1
        let session = NFCNDEFReaderSession(
            delegate: self,
            queue: nil,
            invalidateAfterFirstRead: true
        )

        // 2
        session.alertMessage = "Hold your device near a tag to scan it."

        // 3
        session.begin()
        
        // Do any additional setup after loading the view.
    }


}

extension ViewController: NFCNDEFReaderSessionDelegate {
    
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
                print("\t\t\tidentifier: \(String(data: record.identifier, encoding: .utf8))")
                print("\t\t\ttype: \(String(data: record.type, encoding: .utf8))")
                print("\t\t\tpayload: \(String(data: record.payload, encoding: .utf8))")
            }
        }
    }
    
    // 3
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session did invalidate with error: \(error)")
    }
    
    // 4
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
       
        // 1
        guard tags.count == 1 else {
            session.invalidate(errorMessage: "Can not write to more than one tag.")
            return
        }
        let currentTag = tags.first!
        
        // 2
        session.connect(to: currentTag) { error in
            
            guard error == nil else {
                session.invalidate(errorMessage: "Could not connect to tag.")
                return
            }
            
            // 3
            currentTag.queryNDEFStatus { status, capacity, error in
                
                guard error == nil else {
                    session.invalidate(errorMessage: "Could not query status of tag.")
                    return
                }
                
                switch status {
                case .notSupported: session.invalidate(errorMessage: "Tag is not supported.")
                case .readOnly:     session.invalidate(errorMessage: "Tag is only readable.")
                case .readWrite:

                    // 3
                    let customTextPayload = NFCNDEFPayload.init(
                        format: .nfcWellKnown,
                        type: "T".data(using: .utf8)!,
                        identifier: Data(),
                        payload: "Hello Dibs".data(using: .utf8)!
                    )
                    // 4
                    let message = NFCNDEFMessage.init(
                        records: [
                            customTextPayload
                        ]
                    )
                    // 4
                    currentTag.writeNDEF(message) { error in
                        
                        if error != nil {
                            session.invalidate(errorMessage: "Failed to write message.")
                        } else {
                            session.alertMessage = "Successfully wrote data to tag!"
                            session.invalidate()
                        }
                    }
                    
                @unknown default:   session.invalidate(errorMessage: "Unknown status of tag.")
                }
            }
        }
    }
}
