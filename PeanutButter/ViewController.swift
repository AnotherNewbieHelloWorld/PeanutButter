//
//  ViewController.swift
//  PeanutButter
//
//  Created by Apple User on 18.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var peanuts: [PeanutButter] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let _ = PeanutManager.main.create(newName: "Sporty Peanut", newTaste: "unsweeted, natural", newImageName: "sportyPeanut", newDescription: "The Best Peanut Butter in India")
        //PeanutManager.main.delete()
        reload()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peanuts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeanutButter", for: indexPath) as! PeanutButterCell
        cell.nameLabel.text = peanuts[indexPath.row].name
        cell.tasteLabel.text = peanuts[indexPath.row].taste
        return cell
    }
    
    func reload() {
        peanuts = PeanutManager.main.getAllNotes()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails"{
            // we want to cast that DestinationViewController to an instance of our NoteViewController
            if let destination = segue.destination as? PeanutViewController {
                destination.peanutButter = peanuts[tableView.indexPathForSelectedRow!.row]
            }
        }
    }

}

