//
//  DetailViewController.swift
//  TP_Romain_BIZOT
//
//  Created by Romain Bizot on 07/11/2022.
//

import UIKit

class DetailViewController: UIViewController {
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tache = myData{
            nomTache.text = tache.nom_tache
            descTache.text = tache.desc
            formatter.dateFormat = "dd/MM/yyyy"
            dateTache.text = formatter.string(from: tache.date)
        }else{
            nomTache.text = "ERROR"
            descTache.text = "ERROR"
        }
        
        // Do any additional setup after loading the view.
    }
    //Modifie l'état de la tache en appuyant sur le bouton "Actualiser état"
    @IBAction func changeState(_ sender: Any) {
        if myData?.etat == true{
            myData?.etat = false
        }else{
            myData?.etat=true
        }
    }
    @IBOutlet weak var nomTache: UILabel!
    
    @IBOutlet weak var descTache: UILabel!
    
    @IBOutlet weak var dateTache: UILabel!
    var myData: MyData?
    var myCategorie : MyCategory?
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
