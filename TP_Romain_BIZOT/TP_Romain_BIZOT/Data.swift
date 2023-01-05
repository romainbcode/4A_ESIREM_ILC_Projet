//
//  Data.swift
//  TP_Romain_BIZOT
//
//  Created by Romain Bizot on 07/11/2022.
//

import Foundation

class MyData{
    //Description
    var desc:String
    //Nom de la tâche
    var nom_tache:String
    //Etat de la tache (fait ou à faire)
    var etat:Bool
    //Date de la tâche
    var date:Date
    
    init(desc: String, nom_tache: String, etat: Bool, date:Date) {
        self.desc = desc
        self.nom_tache = nom_tache
        self.etat = etat
        self.date = date
    }
}
