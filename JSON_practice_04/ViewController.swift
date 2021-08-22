//
//  ViewController.swift
//  JSON_practice_04
//
//  Created by Randy Cole on 8/22/21.
//

import UIKit
import Foundation
 
class ViewController: UIViewController {
    
    
    let frisbeeImage = "frisbee-1.png"
    let officeImage = "office-1.png"
    let floridaImage = "florida-1.png"
 
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var ageGuessed: UILabel!

    @IBOutlet weak var userInput: UITextField!
    
    @IBAction func goGet(_ sender: UIButton) {
         
        guard let theInput = self.userInput.text else { return }
         
        goGetStuff(theName: theInput)
         
    }
    
    @IBOutlet weak var AgeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //...
          
    }
    
    
    func goGetStuff(theName: String) {
         
        var urlString = "https://api.agify.io/?name="
          
        guard let url = URL(string: urlString + theName) else { return }
         
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            
            data, response, error in
            
            guard let theData = data, error == nil else { print ("error! \(error)"); return }
            
            var result: theResponse?
            
            do {
                
                result = try JSONDecoder().decode(theResponse.self, from: theData)
               
            } catch {
                
                print("failed to decode! \(error)")
                
            }
            
            DispatchQueue.main.async { [self] in
                 
                guard let theResult = result else { return }
                
                self.userName.text = theResult.name
                self.ageGuessed.text = String(theResult.age) + " years"
                
                self.userInput.text = ""
                
                
                
                if theResult.age < 30 {
                     
                    self.AgeImage.image = UIImage(named: frisbeeImage)
                    
                }
                
                if theResult.age >= 30 && theResult.age < 61 {
                    
                    self.AgeImage.image = UIImage(named: officeImage)
                    
                }
                
                if theResult.age >= 60 {
                    
                    self.AgeImage.image = UIImage(named: floridaImage)
                }
            }
             
            
        })
        
        task.resume()
        
    }
 
}


struct theResponse: Codable {
    
    var name: String
    var age: Int
    
}

