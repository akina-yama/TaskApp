//
//  ViewController.swift
//  taskapp
//
//  Created by Akina Yamanishi on 2020/09/02.
//  Copyright © 2020 Akina.Yamanishi. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    
    let category = try! Realm().objects(Task.self).sorted(byKeyPath: "category")
    
    var searchResult = [String]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let inputViewController:InputViewController = segue.destination as! InputViewController
        
        if segue.identifier == "cellSegue"{
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.task = taskArray[indexPath!.row]
        } else {
            let task = Task()
            
            let allTasks = realm.objects(Task.self)
            if allTasks.count != 0 {
                task.id = allTasks.max(ofProperty: "id")! + 1
            }
            inputViewController.task = task
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchResult = category
    }
    
    
        override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
//データの数をcellへ
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
        return searchResult.count
    }
//各cellの内容を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM -dd HH:mm"
        
        let dateString:String = formatter.string(from: task.date)
        cell.detailTextLabel?.text = dateString
    
        return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    call.textLabel?.text = searchResult[indexPath.row]
    return cell
    }
    
    
    
    
//各cellを選択したときに実行される
    func tableView(_ tableView: UITableView, didSelectRowAt indexpath: IndexPath){
        performSegue(withIdentifier: "cellSegue", sender: nil)
        
    }
    
//cellが削除可
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexpath: IndexPath)-> UITableViewCell.EditingStyle{
        return .delete
    }
    
//    delet
    func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            let task = self.taskArray[indexPath.row]
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
            try! realm.write {
                self.realm.delete(task)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                for request in requests {
                    print("/--------------")
                    print(request)
                    print("--------------/")
            }
        }
    }
    
        func searchBarSearchButtonClicked(searchBar: UISearchBar){
            searchBar.endEditing(true)
            searchResult.removeAll()
            if(searchBar.text == ""){
                searchResult = category
            } else {
                for data in category {
                    if data.containsString(searchBar.text!){
                        searchResult.append(data)
                    }
                }
            }
            tableView.reloadData()
        }
}
}
