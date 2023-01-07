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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    func downloadJson(_ url: String, completion: @escaping (String?) -> Void) {
        DispatchQueue.global().async {
            let url = URL(string: url)! // json-server 주소
            guard let data = try? Data(contentsOf: url)
            else {
                DispatchQueue.main.async {
                    completion("downloadJson: can't load the data")
                }
                return
            }
            let json = String (data: data, encoding: .utf8)
            
            DispatchQueue.main.async {
                completion(json)
            }
        }
    }
    
    
    @IBAction func onLoad() {
        textView.text = ""
        downloadJson("http://localhost:3000/users") { json in
            self.textView.text = json
        }
    }
    
}
