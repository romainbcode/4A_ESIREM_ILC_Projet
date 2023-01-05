//
//  ViewController.swift
//  TP_Romain_BIZOT
//
//  Created by Romain Bizot on 07/11/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    var myData : [MyData] = []
    let nomTache : [String] = ["Ranger la chambre", "Aller en course", "finir le DM", "Dormir 8 heures"]
    let descTache : [String] = ["Déplacer le bureau, arroser les plantes", "Lait, farine, pain", "DM de maths et DM de physique", "Dormir car semaine épuisante"]
    let etatTache : [Bool] = [false, false, false, false]
    var dateTache : [Date] = []
    
    let string_date1 = "20/11/2023"
    let string_date2 = "09/02/2023"
    let string_date3 = "15/06/2023"
    let string_date4 = "20/09/2023"
    
    let formatter = DateFormatter()
    
    var myCategory = [MyCategory]()
    var myCategoryFiltre = [MyCategory]()

    var tacheFiltre : [MyData] = []
    
    //Retourne le nombre de section = nombre de catégorie différente
    func numberOfSections(in tableView: UITableView) -> Int {
        return myCategory.count
    }
    
    //Retourne le nombre de tache présente dans les catégorie quand on clique sur une catégorie
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myCategory[section].opened == true{
            return myCategory[section].tache.count + 1
        } else{
            return 1
        }
    }

    //Retourne le contenu de chaque cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Cellule prototype pour la tache
        let cell1 = TacheTableView.dequeueReusableCell(withIdentifier: "tacheCell", for: indexPath) as! TacheTableViewCell
        //Cellule prototype pour le nom de la catégorie
        let cellCategory = TacheTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! TacheTableViewCell
        
        //Affiche les cellules concernant les catégories
        if indexPath.row==0{
            cellCategory.NomTache?.text = myCategory[indexPath.section].titleCategory
            return cellCategory
        }
        //Affiche les cellules concernant les taches
        else{
            cell1.NomTache?.text = myCategory[indexPath.section].tache[indexPath.row - 1].nom_tache
            if myCategory[indexPath.section].tache[indexPath.row - 1].etat == true{
                cell1.etatTache.image = UIImage(systemName: "checkmark")
            }else{
                cell1.etatTache.image = UIImage(systemName: "xmark")
            }
            formatter.dateFormat = "dd/MM/yyyy"
            cell1.dateTache.text = formatter.string(from: myCategory[indexPath.section].tache[indexPath.row - 1].date)
        }
        return cell1
    }
    
    //Permet d'ouvrir les Catégories afin d'afficher les sous catégories à l'intérieur
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Change le boolean concernant l'ouverture du catégorie de false à true ou de true à false
        myCategory[indexPath.section].opened = !myCategory[indexPath.section].opened
        tableView.reloadSections([indexPath.section], with: .none)
    }
    
    //Permet d'effacer une tache ou une catégorie en swippant vers la gauche
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                //Pour supprimer une tache dans une catégorie
                if indexPath.row != 0{
                    let row = indexPath.row - 1
                    //On récupère la position de la section puis de la row dans la section
                    myCategory[indexPath.section].tache.remove(at: row)
                    TacheTableView.reloadData()
                }
                //Pour supprimer une catégorie
                else{
                    myCategory.remove(at: indexPath.section)
                    TacheTableView.reloadData()
                }
            }
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "dd/MM/yyyy"
        
        if let to_store1 = formatter.date(from: string_date1) {
            dateTache.append(to_store1)
        }
        if let to_store2 = formatter.date(from: string_date2){
            dateTache.append(to_store2)
        }
        if let to_store3 = formatter.date(from: string_date3){
            dateTache.append(to_store3)
        }
        if let to_store4 = formatter.date(from: string_date4){
            dateTache.append(to_store4)
        }
        
        //On ajoute dans le tableau myData des tâches
        for i in 0...3 {
            myData.append(MyData(desc: descTache[i], nom_tache: nomTache[i], etat: etatTache[i], date: dateTache[i]))
        }
        
        //On ajoute dans le tableau myCategory des catégories avec dans chacunes d'entre elles deux tâches
        myCategory = [
            MyCategory(opened: false, titleCategory: "Première catégorie", tache: [myData[0], myData[1]]),
            MyCategory(opened: false, titleCategory: "Deuxième catégorie", tache: [myData[2], myData[3]])
        ]
        
        TacheTableView.dataSource = self
        TacheTableView.delegate = self
        
        //Etape afin d'ajouter la searchBar dans le vue principal
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Chercher une tâche"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

    //on envoit des données à la vue concernant les informations détaillées d'une tâche
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VC = segue.destination as? DetailViewController{
            let row = TacheTableView.indexPathForSelectedRow!.row
            let section = TacheTableView.indexPathForSelectedRow!.section
            VC.myData = myCategory[section].tache[row-1]
        }
    }
    
    //Action pour fermer la page de l'ajout d'une nouvelle tache
    @IBAction func close(_ unwindSegue: UIStoryboardSegue) {
        let vc = unwindSegue.source as! EditViewController
        vc.dismiss(animated: true, completion: nil)
    }
    
    //Action sur le bouton save quand on ajoute une tache
    @IBAction func save(_ unwindSegue: UIStoryboardSegue) {
        let vc = unwindSegue.source as! EditViewController
        if let myTitle = vc.nomTache.text, let myDescription = vc.descriptionTache.text {
            let myDate = vc.datePickerTache.date
            //Une tâche se créée uniquement si elle contient un titre et une description
            if myTitle != "" && myDescription != ""{
                let new_data = MyData(desc: myDescription, nom_tache: myTitle, etat: false, date: myDate)
                //On peut seulement ajouter des taches dans les catégories
                for i in 0...myCategory.count-1{
                    if myCategory[i].opened{
                        myCategory[i].tache.append(new_data)
                    }
                }
                TacheTableView.reloadData()
            }
        }
        
    }
    
    //Fonction qui va permettre de fermer la page de création de catégorie
    @IBAction func closeCategoriePage(_ unwindSegue: UIStoryboardSegue) {
        let vc = unwindSegue.source as! CategorieViewController
        vc.dismiss(animated: true, completion: nil)
    }
    
    //Fonction qui va sauvegarder une nouvelle catégorie à condition que le nom de celle-ci soit différent de ""
    @IBAction func saveCategoriePage(_ unwindSegue: UIStoryboardSegue) {
        let vc = unwindSegue.source as! CategorieViewController
        if let myTitleCategorie = vc.nomCategorie.text{
            //On peut créer une tâche uniquement si elle a un nom
            if myTitleCategorie != ""{
                myCategory.append(MyCategory(opened: false, titleCategory: myTitleCategorie, tache: []))
                TacheTableView.reloadData()
                
            }
        }

    }
    
    
    //Fonction qui trie les dates dans l'ordre croissant quand on appuie sur le bouton triDateTache
    @IBAction func triDateTache(_ sender: Any){
        var myDatatmp: MyData
        //Boucle pour chaque catégorie
        for i in 0...myCategory.count-1{
            //Répète l'opération autant de fois qu'il y a de taches dans la catégorie
            for _ in 0...myData.count{
                for a in 0...myCategory[i].tache.count-2{
                    if myCategory[i].tache[a].date > myCategory[i].tache[a+1].date{
                        myDatatmp = myCategory[i].tache[a]
                        myCategory[i].tache[a] = myCategory[i].tache[a+1]
                        myCategory[i].tache[a+1] = myDatatmp
                    }
                }
            }
        }
        
        TacheTableView.reloadData()
    }
    
    @IBOutlet weak var TitreApp: UILabel!
    @IBOutlet weak var TacheTableView: UITableView!


let searchController = UISearchController()

  //Fonction permettant de sélectionner des tâches grâce à la searchBar de la vue principale
  func updateSearchResults(for searchController: UISearchController) {
      if let searchText = searchController.searchBar.text {
          if searchText.isEmpty {
              myCategoryFiltre = myCategory
          }
          else {
              for (index, category) in myCategoryFiltre.enumerated() {
                  let tacheFiltre = category.tache.filter({(data: MyData) -> Bool in return data.nom_tache.range(of: searchText, options: .caseInsensitive) != nil})
                  myCategoryFiltre[index].tache = tacheFiltre
                  
              }
          }
          TacheTableView.reloadData()
          }
  }

}
