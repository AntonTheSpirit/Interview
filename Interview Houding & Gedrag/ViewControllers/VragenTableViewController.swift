//
//  VragenTableViewController.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 0911--2020.
//

import UIKit

class VragenTableViewController: UITableViewController, MyDataSendingDelegateProtocol {

    //MARK: - Datamodel
    
    private var vragen: [Vragen] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        ophalenVragenLijst()
    }

    //MARK: - UITableViewDataSource
    
    // MARK delegate implementation
    func sendDataToFirstViewController(vragenLijst: [Vragen]) {
        self.vragen = vragenLijst
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if vragen.count == 0 {
            return 0
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vragen.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VragenCell", for: indexPath)
        let vraagItem = vragen[indexPath.row]
        
        cell.textLabel?.text = vraagItem.vraag
        cell.textLabel?.numberOfLines = 0

        cell.detailTextLabel?.text = vraagItem.antwoorden.first?.antwoord
        cell.detailTextLabel?.numberOfLines = 0
        
        
        return cell
    }
}
