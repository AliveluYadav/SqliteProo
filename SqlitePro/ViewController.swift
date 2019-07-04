//
//  ViewController.swift
//  SqlitePro
//
//  Created by Nikitha on 4/25/18.
//  Copyright © 2018 Nikitha. All rights reserved.
//

import UIKit
import SQLite
class ViewController: UIViewController {
    var db:Connection?
    
  
   
    

    
   var countryArry=["Afghanistan", "Armenia","Azerbaijan","Bahrain","Bangladesh","Bhutan","Brunei","Cambodia","China","Cyprus","Georgia","India","Nepal"]
    
  var capitalArry=["Kabul","Yerevan","Baku","Manama","Dhaka","Thimphu","Bandar Seri Begawan","Phnom Penh","Beijing","Nicosia","Tbilisi","New Delhi","Kathmandu"]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        print(path)
        do{
       self.db = try Connection("\(path)/db.sqlite3")
            try self.db?.run("CREATE TABLE IF NOT EXISTS INFO(ID INTEGER PRIMARY KEY AUTOINCREMENT,COUNTRY TEXT,CAPITAL TEXT)")
        }
        catch
        {
            print("something")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAcn(_ sender: Any) {
        
        do{
            for  i in 0..<countryArry.count
            {
            try self.db?.run("INSERT INTO INFO(COUNTRY,CAPITAL) VALUES (?,?)",self.countryArry[i],self.capitalArry[i])
            }
//            print()
        }
        catch
        {
            print("Something went wrong While Saving")
        }
    }
        @IBAction func retrieveAction(_ sender: Any) {
            do
            {
                let stmt = try self.db?.run("select COUNTRY,CAPITAL from INFO")
                for row in stmt! {
                    for (index, name) in (stmt?.columnNames.enumerated())! {
                        print ("\(name)=\(row[index]!)")
                        // id: Optional(1), email: Optional("alice@mac.com")
                    }
                    
                }
            }
            catch{
                print("Something went wrong While Retrieving")

            }
        }
    
    @IBAction func updateAction(_ sender: Any) {
        
        do{
            try self.db?.run("UPDATE Info SET COUNTRY='Bharat' WHERE COUNTRY='India'")
        }catch{
            
        }
    }
    
    
    }
    
    
    
    
    
    


