//
//  CharacterListTableView.swift
//  SwiftConcurrency
//
//  Created by Koombea on 10/25/21.
//

import UIKit
import Kingfisher

extension CharacterListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath)
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? CharacterTableViewCell else { return }
        let character = characters?[indexPath.row]
        cell.nameLabel?.text = character?.name?.capitalized
        cell.avatarImageView?.kf.setImage(with: URL(string: character?.imageURL ?? ""))
    }
}
