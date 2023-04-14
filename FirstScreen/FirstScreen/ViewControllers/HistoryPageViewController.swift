//
//  HistoryPageViewController.swift
//  FirstScreen
//
//  Created by Amrit Anand on 12/04/23.
//

import UIKit

class HistoryPageViewController: UIViewController {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var historyTable: UITableView!
    
    var item = [History]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchHistory()
    }
    
    func fetchHistory(){
        do{
            self.item = try context.fetch(History.fetchRequest())
            
            DispatchQueue.main.async {
                self.historyTable.reloadData()
            }
        }
        catch{
             
        }
       
    }

    
    
}
extension HistoryPageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let word = self.item[indexPath.row]
        cell.textLabel?.text = word.typedText
        fetchHistory()
        return cell
    }
    
    
    
}
    
    

