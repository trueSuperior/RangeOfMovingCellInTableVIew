//
//  ViewController.swift
//  RangeOfCellMoving
//
//  Created by Yuma Ikeda on 2017/04/02.
//  Copyright © 2017年 UMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /// テーブルビュー
    @IBOutlet weak var myTableView: UITableView!

    /// データソース
    var dataSource = [(title: String, rows: [String])]()
    
    /// テーブルの初期値
    func initData() {
        let rows = ["Row1", "Row2", "Row3"]
        dataSource = [(title: "Section1", rows: rows),
                      (title: "Section2", rows: rows),
                      (title: "Section3", rows: rows)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        navigationItem.rightBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        myTableView.setEditing(editing, animated: animated)
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.section].rows[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].title
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removeRow = dataSource[sourceIndexPath.section].rows.remove(at: sourceIndexPath.row)
        dataSource[destinationIndexPath.section].rows.insert(removeRow, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        switch (sourceIndexPath.section, proposedDestinationIndexPath.section) {
        case (let from, let to) where from != to:
            return sourceIndexPath
        default:
            return proposedDestinationIndexPath
        }
    }
    
}

