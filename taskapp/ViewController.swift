//
//  ViewController.swift
//  taskapp
//
//  Created by Akina Yamanishi on 2020/09/02.
//  Copyright © 2020 Akina.Yamanishi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
//データの数をcellへ
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
//各cellの内容を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
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
        
    }
}

