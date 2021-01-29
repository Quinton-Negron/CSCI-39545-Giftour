//%3CREQUIRED%3E3E
//
//  ViewController.swift
//  Giftour
//
//  Created by Quinton Negron on 1/10/21.
//  Copyright © 2021 Quinton Negron. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Entry : UITextField!
    @IBOutlet var nameAge : UITextField!
    @IBOutlet weak var test : UILabel!
    
    @IBOutlet weak var ageScreen : UITextView!
    
    var game = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func button()
    {
        let Sentence = String(Entry.text!)
        print(Sentence)
        print("test")
        if (Sentence == "")
        {
            return
        }
        else
        {
            if let url = URL(string: "http://www.bing.com/shop?q=\(Sentence)%2bgift&FORM=SHOPTB"){
            UIApplication.shared.open(url)
            }
        }
    }
    
    @IBAction func ageButton(){
        let name = nameAge.text!
        
        
        if (name == "")
        {
            return
        }
        else{
            let url = "https://api.agify.io/?name=\(name)"
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            var result: guess?
                do {
                    result = try JSONDecoder().decode(guess.self, from: data)
                }
                catch {
                    print("failed to convert \(error.localizedDescription)")
                }
                
                guard let json = result else {
                    return
                }
                self.game = "\(name), is your age \(json.age)?"
                //print("gggggggg")
            })
            //print(
            self.test.text = game
            task.resume()
            
        }
    }
    
    /*func showAlert() {
        let alert = UIAlertController(title: "Title", message: "Hello World", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }*/
}

struct request: Codable {
    var _type: String
    var queryContext: Query
}

struct web: Codable {
    var webPages: Results
}

struct Query: Codable {
    var _type: String
    var originalQuery: String
}

struct Results: Codable {
    var _type: String
    var webSearchUrl: String
    var totalEstimatedMatches: Int
    var value: Int
    var someResultsRemoved: Bool
}

struct guess: Codable {
    var name: String
    var age: Int
    var count: Int
}
