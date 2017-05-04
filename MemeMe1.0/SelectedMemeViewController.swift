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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memedImage.image = meme.memedImage!
    }
}
