//
//  ViewController.swift
//  FirstScreen
//
//  Created by Amrit Anand on 10/04/23.
//

import UIKit
import AVFoundation
import AVKit



class TranslateViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: - Translation Video showing
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var textbox: UITextField!
    
    @IBAction func translateButton(_ sender: Any) {
        
        
        // saving input from textbox in var
        // textbox =  textfied name
        
        
        let entertedText =  textbox.text
        // calling translate function FOR Action
        translate(typedtext : entertedText!.lowercased())
        
        
        
        //Creating object of entity
        let entry = History(context: self.context)
        entry.typedText = entertedText
        
        
        // saving words
        
        do{
            try self.context.save()
        }
        catch{
            
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    // Creating function for translation which will show video for particular word given to function
    func translate(typedtext : String){
        guard let videoPath = Bundle.main.path(forResource: typedtext, ofType: "mp4") else {
            print("Error: Could not find video file in main bundle.")
            return
        }
        // Video frame creation
        let videoURL = URL(fileURLWithPath: videoPath)
        let player = AVPlayer(url: videoURL)
        let layer = AVPlayerLayer(player: player)
        layer.frame = videoView.bounds
        videoView.layer.addSublayer(layer)
        player.play()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

extension TranslateViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
