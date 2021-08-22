//
//  ViewController.swift
//  JSON_practice_04
//
//  Created by Randy Cole on 8/22/21.
//

import UIKit
import Foundation
 
class ViewController: UIViewController {
 
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var ageGuessed: UILabel!

    @IBOutlet weak var userInout: UITextField!
    
    
    @IBAction func goGet(_ sender: Any) {
        
        guard let theInout = self.userInout.text else{ return }
        
        goGetStuff(theName: self.userInout.text!)
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //...
         
        
    }
    
    
    func goGetStuff(theName: String) {
        
        var urlString = "https://api.agify.io/?name="
          
        guard let url = URL(string: urlString + theName) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            
            data, response, error in
            
            guard let theData = data, error == nil else { print ("error \(error)"); return }
            
            var result: theResponse?
            
            do {
                
                result = try JSONDecoder().decode(theResponse.self, from: theData)
                
                
            } catch {
                
                print("failed to decode \(error)")
                
            }
            
            DispatchQueue.main.async {
                
                guard let theResult = result else { return }
                
                self.userName.text = theResult.name
                self.ageGuessed.text = String(theResult.age) + " years old"
                
                self.userInout.text = ""
            }
             
            
        })
        
        task.resume()
        
    }



}


struct theResponse: Codable {
    
    var name: String
    var age: Int
    
}

