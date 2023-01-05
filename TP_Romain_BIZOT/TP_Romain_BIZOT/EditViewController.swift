//
//  EditViewController.swift
//  TP_Romain_BIZOT
//
//  Created by Romain Bizot on 09/11/2022.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var nomTache: UITextField!
    
    @IBOutlet weak var descriptionTache: UITextField!
    
    @IBOutlet weak var datePickerTache: UIDatePicker!
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
