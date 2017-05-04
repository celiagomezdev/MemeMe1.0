//
//  SelectedMemeViewController.swift
//  MemeMe1.0
//
//  Created by Celia Gómez de Villavedón on 20/4/17.
//  Copyright © 2017 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import UIKit

class SelectedMemeViewController: UIViewController {
    
    var meme: Meme!
    @IBOutlet weak var memedImage: UIImageView!

    override func viewDidLoad() {
         // Do any additional setup after loading the view.
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memedImage.image = meme.memedImage!
        tabBarItem.isEnabled = false
    }
    
    //Offer the option to share again
    @IBAction func shareAgain(_ sender: Any) {
        let image = meme.memedImage!
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //Disable save option as it is already saved
        controller.excludedActivityTypes = [UIActivityType.saveToCameraRoll]
        self.present(controller, animated: true, completion: nil)

    }

    
}
