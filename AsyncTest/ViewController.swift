//
//  ViewController.swift
//  asyncPractice
//
//  Created by 박인서 on 2023/01/05.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    
    let dummyMaker = DummyMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    @IBAction func onLoad() {
        textView.text = ""
        DispatchQueue.global(qos: .background).async {
            self.dummyMaker.make()
        }
        
        DispatchQueue.global().async {
            let url = URL(string: "http://localhost:3000/users")! // json-server 주소
            var data = try? Data(contentsOf: url)
            
            if data == nil {
                for _ in 0..<3 {
                    data = try? Data(contentsOf: url)
                    if data != nil {
                        break
                    }
                }
            }
            
            guard data != nil, let json = String (data: data!, encoding: .utf8)
            else {
                self.textView.text = "disconnected"
                return
            }
            
            DispatchQueue.main.async {
                self.textView.text = json
            }
        }
    }
    
}
