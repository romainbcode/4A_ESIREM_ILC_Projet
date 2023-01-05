//
//  Category.swift
//  TP_Romain_BIZOT
//
//  Created by Romain Bizot on 29/11/2022.
//

import Foundation

class MyCategory{
    //Etat de l'ouverture ou non de la catégorie
    var opened: Bool
    //Titre de la catégorie
    var titleCategory: String
    //Tableau de tache
    var tache = [MyData]()
    
    init(opened: Bool, titleCategory: String, tache: [MyData]){
        self.opened = opened
        self.titleCategory = titleCategory
        self.tache = tache
    }    
}
