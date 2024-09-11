//
//  SecondScreenVC.swift
//  ProtocolExtenstion
//
//  Created by Abouzar Moradian on 9/10/24.
//

import UIKit

enum TimerAction{
    case stop
    case restart
}



protocol ContorlTimerDelegate : AnyObject  {
    
        func didTimerControlled(action: TimerAction)
        func didSelectCountry(country: String)
}

class SecondScreenVC: UIViewController, ObserveTimerProtocol, UITableViewDelegate {
 
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func didCountriesLoaded(countries: [String]) {
        self.countries = countries
        tableView.reloadData()
        print(countries)


    }
    
    
// MARK: we can commont the method out because we defined a default implmentation for the protocol through extension
    
//    func didCounterUpdated(counter: Int) {
//        
//        print("update counter called")
//        counterLabel.text = String(counter)
//    }
    

    weak var delegate: ContorlTimerDelegate?
    @IBOutlet weak var counterLabel: UILabel!
    
    var countries: [String] = []

    var mainScreen: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreen?.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        registerCountryCell()
        
        
    }
    
    @IBAction func stopTimerButton(_ sender: UIButton) {
        
        delegate?.didTimerControlled(action: .stop)
    }
    

    @IBAction func restartTimerButton(_ sender: UIButton) {
        
        delegate?.didTimerControlled(action: .restart)

    }
    
    func setupMainScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mainScreen = storyboard.instantiateViewController(withIdentifier: "mainScreen") as? ViewController
        mainScreen?.delegate = self
    }
    
    
    func registerCountryCell(){
        
        let nib = UINib(nibName: CountryCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CountryCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CountryCell, let name = cell.nameLabel.text else { return }
        delegate?.didSelectCountry(country: name)
        navigationController?.popViewController(animated: true)
    }
}


extension SecondScreenVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell
        
        guard let cell = customCell else { return UITableViewCell()}
        
        cell.nameLabel.text = countries[indexPath.row]
        
        return cell
    }
}


