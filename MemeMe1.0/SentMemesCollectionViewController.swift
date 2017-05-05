//
//  SentMemesCollectionViewController.swift
//  MemeMe1.0
//
//  Created by Celia Gómez de Villavedón on 19/4/17.
//  Copyright © 2017 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        self.collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Configure the cell
        cell.topTextLabel.text = meme.topText
        TextAttributes().configureLabelText(cell.topTextLabel!)
        cell.bottomTextLabel.text = meme.bottomText
        TextAttributes().configureLabelText(cell.bottomTextLabel!)
        cell.memeImageView.image = meme.originalImage
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SelectedMemeViewController") as! SelectedMemeViewController
        
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
