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
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memesTableCellID") as! SentMemesTableViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.topTextLabel?.text = meme.topText!
        TextAttributes().configureLabelText(cell.topTextLabel)
        cell.bottomTextLabel?.text = meme.bottomText!
        TextAttributes().configureLabelText(cell.bottomTextLabel)
        cell.imageTableView?.image = meme.originalImage!
        cell.memeTextLabel?.text = "\(meme.topText!) \(meme.bottomText!)"
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
