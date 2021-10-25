//
//  ViewController.swift
//  SwiftConcurrency
//
//  Created by Koombea on 10/25/21.
//

import UIKit

@MainActor
class CharacterListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    var characters: [Character]?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { await fetchData() }
    }
    
    // MARK: - Fetch
    
    func fetchData() async {
        do {
            characters = try await CharactersStore.fetchCharacters()
            await sortCharactersByName()
            reloadData()
        } catch let error {
            print(error)
        }
    }
    
    func sortCharactersByName() async {
        characters?.sort { ($0.name ?? "") < ($1 .name ?? "") }
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    
}

