//
//  entryViewController.swift
//  prova-3b1-marceloalemeida
//
//  Created by COTEMIG on 16/08/21.
//

import UIKit

class entryViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    
    var  update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "salvar", style:.done, target: self, action: #selector(savetask))
           
    }
    func textfieldshouldreturn( textfield: UITextField) -> Bool{
        savetask()
        return true
    }
    @objc func savetask(){
        
        guard let text = field.text, !text.isEmpty else{
            return
        }
        
        guard let count = UserDefaults().value(forKey:"count") as? Int else{
            return
        }
        
        let newcount =  count + 1
        
        UserDefaults().set(newcount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newcount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }
}


