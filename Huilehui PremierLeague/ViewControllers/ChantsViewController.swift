//
//  ChantsViewController.swift
//  Huilehui PremierLeague
//
//  Created by Navathon Limamapar on 16/3/2567 BE.
//

import UIKit

class ChantsViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView={
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false //Auto layout this need to set to false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension // Size of each box not same for example some content is longer than other so the box not have same size.
        tv.estimatedRowHeight = 44 // Minimum height
        tv.separatorStyle = .none // Seperate each box so it not cover each other
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.cellId)
        return tv
    }()
    
    private lazy var teamsViewModel = TeamsViewModel()
    
    // MARK: Lifecycle
    
    override func loadView() {
        super.loadView()
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }
    

}

private extension ChantsViewController {
    func setup(){
        self.navigationController?.navigationBar.topItem?.title = "Football Chants"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor), // left
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor), // right
        ])
    }
    
}

// MARK: - UITableViewDataSource
extension ChantsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //for protocol
        return teamsViewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = teamsViewModel.teams[indexPath.row]
        
        //for protocol
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellId, for: indexPath) as! TeamTableViewCell
        cell.backgroundColor = .white
        cell.configure(with: team, delegate: self)
        return cell
    }
}

extension ChantsViewController: TeamTableViewCellDelegate{
    func didTapPlayback(for team: Team) {
        
        teamsViewModel.togglePlayback(for: team)
        tableView.reloadData()
    }
}
