//
//  ContactDetailsTableViewController.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import UIKit
import Contacts
import Reusable

class ContactDetailsTableViewController: UITableViewController, ContactDetailsViewCapable {
    
    // MARK: - Types
    
    struct ViewModel {
        /* Order defines order in table view */
        var sections: [SectionType]
        /* Order in array of CellType defines order in table view */
        var sectionCells: [SectionType: [CellType]]
    }
    
    /* Possible sections, not mandatory */
    enum SectionType: Int, CaseIterable {
        case header
        case info
        case map
    }
    
    /* Possible cell type, not madatory */
    enum CellType {
        case header(viewModel: ContactDetailsHeaderViewModel)
        case info(viewModel: ContactDetailsInfoViewModel)
        case map(viewModel: ContactDetailsMapViewModel)
    }
    
    // MARK: - Properties
    
    var router: ContactsScenesRouterCapable?
    var interactor: ContactDetailsInteractorCapable?
    
    private var viewModel: ViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Lifecycle
    
    init() {
        super.init(style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(cellType: ContactDetailsHeaderTableViewCell.self)
        tableView.register(cellType: ContactDetailsInfoTableViewCell.self)
        tableView.register(cellType: ContactDetailsMapTableViewCell.self)
        
        navigationItem.largeTitleDisplayMode = .never
        view.accessibilityIdentifier = "contact_details_view_controller"
        /* For unknow reason the view controller to add contact is ot displayed so feature is not yet accessible. See router for details. */
//        let addButton = UIBarButtonItem(image:  UIImage(systemName: "person.crop.circle.badge.plus"), style: .plain, target: self, action: #selector(addToContacts))
//        navigationItem.rightBarButtonItem = addButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getContactDetailsViewModel()
    }
    
    // MARK: - Actions
    
    @objc private func addToContacts() {
        interactor?.addToContacts()
    }
    
    // MARK: - ContactDetailsViewCapable
    
    func display(viewModel: ViewModel) {
        assert(viewModel.sections.count == viewModel.sectionCells.count, "ERROR: Count of sections and count of sectionCells aren't equal, you failed in presenter!")
        self.viewModel = viewModel
    }
    
    func displayAddContact(contact: CNContact) {
        router?.showAddContact(contact: contact)
    }
    
    // MARK: - TableView Management
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = viewModel?.sections[section], let cells = viewModel?.sectionCells[sectionType] else { return 0 }
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = cellType(from: indexPath) else { return UITableViewCell() }
                
        switch cellType {
        case .header(let viewModel):
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactDetailsHeaderTableViewCell
            cell.viewModel = viewModel
            return cell
            
        case .info(let viewModel):
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactDetailsInfoTableViewCell
            cell.viewModel = viewModel
            return cell
            
        case .map(let viewModel):
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContactDetailsMapTableViewCell
            cell.viewModel = viewModel
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let router = router, let cellType = cellType(from: indexPath) else { return }
        guard case let .info(viewModel) = cellType else { return }
        viewModel.selectionHandler(router)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func cellType(from indexPath: IndexPath) -> CellType? {
        guard let vm = viewModel, indexPath.section < vm.sections.count else { return nil }
        let sectionType = vm.sections[indexPath.section]
        guard let sectionCells = vm.sectionCells[sectionType], indexPath.row < sectionCells.count else { return nil }
        return sectionCells[indexPath.row]
    }
    
}
