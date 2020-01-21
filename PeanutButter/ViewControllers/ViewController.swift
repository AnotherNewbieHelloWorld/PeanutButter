//
//  ViewController.swift
//  PeanutButter
//
//  Created by Apple User on 18.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    private var peanuts: Results<PeanutButter>! = nil
    var test: PeanutButter!
    let dislikeImage = UIImage(systemName: "heart")
    let likeImage = UIImage(systemName: "heart.fill")
    var like = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let image = #imageLiteral(resourceName: "bird")
        //test = PeanutButter(name: "Birds", taste: "ask a bird", productInfo: "Special buy peanut butter for garden birds?", imageData: image.pngData(), rating: 1.0, like: false)
        //StoreManager.saveObject(test)
        peanuts = realm.objects(PeanutButter.self)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peanuts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeanutButter", for: indexPath) as! PeanutButterCell
        let peanut = peanuts[indexPath.row]
        
        cell.nameLabel.text = peanut.name
        cell.tasteLabel.text = peanut.taste
        cell.jarImage.image = UIImage(data: peanut.imageData!)
        // rating
        if peanut.like {
            cell.likeButton.setImage(likeImage, for: .normal)
        }
        else {
            cell.likeButton.setImage(dislikeImage, for: .normal)
        }
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let peanut = peanuts[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StoreManager.deleteObject(peanut)
            tableView.deleteRows(at: [indexPath], with: .automatic)
          }
          return [deleteAction]
      }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let peanut = peanuts[indexPath.row]
            let newPlaceVC = segue.destination as! NewTableViewController
            newPlaceVC.peanutButter = peanut
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewTableViewController else { return }
        newPlaceVC.savePeanutButter()
        tableView.reloadData()
    }
}

