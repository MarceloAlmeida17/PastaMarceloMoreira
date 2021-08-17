//
//  ViewController.swift
//  prova-3b1-marceloalemeida
//
//  Created by COTEMIG on 16/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    /*/ marcelo moreira mamede de almeida
    11901136
    34
    */
    
    @IBOutlet var tableview:UITableView!
    
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "loja"
        
        tableview.delegate = self
        tableview.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set( 0,forKey: "count")
        
        }
        updatetasks()
    }
    
    func updatetasks(){
        
        tasks.removeAll()
        
        guard let count =  UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        for x in 0..<count{
            
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{
            tasks.append(task)
            }
            
        }
        tableview.reloadData()
    }
    
    @IBAction func didtapadd(){
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! entryViewController
        vc.title = "novo produto"
        vc.update = {
            DispatchQueue.main.async{
                self.updatetasks()
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}
