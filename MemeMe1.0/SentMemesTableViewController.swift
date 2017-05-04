//
//  SentMemesTableViewController.swift
//  MemeMe1.0
//
//  Created by Celia Gómez de Villavedón on 19/4/17.
//  Copyright © 2017 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        self.tableView?.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memes.count
    }
    
    public func configureLabelText (_ label: UILabel) {
        
        let centeringText = NSMutableParagraphStyle()
        centeringText.alignment = .center
        
        let textLabelAttributes: [String:Any] = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Impact", size: 13)!,
            NSStrokeWidthAttributeName : -5.0,
            NSParagraphStyleAttributeName : centeringText
            ]
            
        label.attributedText = NSMutableAttributedString(string: label.text!, attributes: textLabelAttributes)

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memesTableCellID") as! SentMemesTableViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.topTextLabel?.text = meme.topText!
        configureLabelText(cell.topTextLabel)
        cell.topTextLabel.sizeToFit()
        cell.bottomTextLabel?.text = meme.bottomText!
        cell.bottomTextLabel.sizeToFit()
        configureLabelText(cell.bottomTextLabel)
        cell.imageTableView?.image = meme.originalImage!
        cell.memeTextLabel?.text = "\(meme.topText!) ... \(meme.bottomText!)"
        cell.memeTextLabel.sizeToFit()

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SelectedMemeViewController") as! SelectedMemeViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
