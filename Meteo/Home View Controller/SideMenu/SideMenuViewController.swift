//
//  SideMenuViewController.swift
//  Meteo
//
//  Created by Massimiliano on 22/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func sideMenuDidPressOption(_ option: SideMenuViewController.MenuOptions)
}

class SideMenuViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var viewContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var viewContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    // MARK: - Properties

    //private var viewModel = SideMenuViewModel()
    private weak var delegate: SideMenuViewControllerDelegate?
    private lazy var dataSource = configureDataSource()

    private var logoutGestureRecognizer: UIGestureRecognizer?
    private var privacyAndPolicyGestureRecognizer: UIGestureRecognizer?
    private var supportGestureRecognizer: UIGestureRecognizer?
    private var userGestureRecognizer: UIGestureRecognizer?
    private var closeSideMenuGestureRecognizer: UITapGestureRecognizer?

    private var darkView: UIView?

    private(set) var width: CGFloat = 0
    private(set) var height: CGFloat = 0
    private(set) var navigationBarHeight: CGFloat = 0

    /// The frame outside the screen where the SideMenu should disappear and appear from
    private(set) var hiddenFrame: CGRect!

    /// The frame inside the view where SideMenu visible
    private(set) var visibleFrame: CGRect!

    var isPresent: Bool { view.frame == visibleFrame }
    var isClosed: Bool { view.frame == hiddenFrame || hiddenFrame == nil }

    private var topPadding: CGFloat {
        var topPadding: CGFloat = 0

        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            topPadding = window.safeAreaInsets.top
            _ = window.safeAreaInsets.bottom
        }
        return topPadding
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupTableView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let release = Bundle.main.releaseVersionNumber ?? ""
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        versionLabel.text = "Version: \(appVersion ?? "")"
        configureMenuFrame()
        
        //setupAllGestureRecognizer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - Methods

    func close(parent: UIViewController, withDuration timeInterval: TimeInterval = 0.0) {
        darkView?.removeGestureRecognizer(closeSideMenuGestureRecognizer!)

        UIView.animate(withDuration: timeInterval, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else { return }
            self.view.frame = self.hiddenFrame
            self.darkView?.alpha = 0

        }, completion: { [weak self] _ in
            guard let self = self else { return }

            self.willMove(toParent: parent)
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.view.frame = self.hiddenFrame

            self.darkView?.removeFromSuperview()
            self.darkView = nil
        })
    }

    func open(parent: UIViewController & SideMenuViewControllerDelegate, width: CGFloat, height: CGFloat, navigationBarHeight: CGFloat) {
        closeSideMenuGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sideMenuWillCloseByTouch))
        closeSideMenuGestureRecognizer?.delegate = self

        parent.addChild(self)

        self.delegate = parent
        self.width = width
        self.height = height
        self.navigationBarHeight = navigationBarHeight
        self.view.frame = CGRect(x: 0, y: (navigationBarHeight + topPadding), width: 0, height: height)

        darkView = UIView()
        darkView?.frame = CGRect(x: 0, y: (navigationBarHeight + topPadding), width: parent.view.frame.width, height: height)
        darkView?.alpha = 0
        darkView?.backgroundColor = UIColor.black.withAlphaComponent(0.66)
        darkView?.isUserInteractionEnabled = true
        darkView?.addGestureRecognizer(closeSideMenuGestureRecognizer!)

        parent.view.addSubview(darkView!)
        parent.view.addSubview(view)
        didMove(toParent: parent)
    }

    private func setupTableView() {
        let nib = UINib(nibName: "MenuCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "MenuCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = dataSource
        snapshotDataSource()
    }

    @objc private func sideMenuWillCloseByTouch() {
        close(parent: self, withDuration: 0.2)
    }


    private func deleteAllUserData() {
//        RealmDatabase<Any>().deleteEverything()
//        BTicinoKeychain.userId = ""
//        BTicinoKeychain.idToken = ""
//        BTicinoKeychain.token = ""
//        Log.d("User logout, everything deleted successfully!")
    }

    private func configureMenuFrame() {
        viewContainerWidth.constant = (width / 2.8) * 2
        viewContainerHeight.constant = view.frame.height - topPadding - navigationBarHeight
        let coordY = navigationBarHeight + topPadding

        hiddenFrame = CGRect(x: -viewContainerWidth.constant, y: coordY, width: viewContainerWidth.constant, height: viewContainerHeight.constant)
        visibleFrame = CGRect(x: 0, y: coordY, width: viewContainerWidth.constant, height: viewContainerHeight.constant)

        view.subviews.forEach { $0.frame = hiddenFrame }

        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = self.visibleFrame
            self.view.subviews.forEach { $0.frame = self.visibleFrame }
            self.darkView?.alpha = 1
        })
    }

    // MARK: - Actions

    @IBAction func debuggerSwitchWasPressed(_ sender: UISwitch) {
//        super.createLogView(isPresented: !sender.isOn)
    }
}

// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = MenuOptions.allCases[indexPath.row]
        delegate?.sideMenuDidPressOption(option)
    }

    private func configureDataSource() -> UITableViewDiffableDataSource<Section, MenuOptions> {
        return UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, title) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "MenuCell",
                for: indexPath
            ) as? MenuCell
            
            cell?.configureWhitTitle(title.rawValue)
            return cell
        }
    }

    private func snapshotDataSource() {
        let optionsContainer = MenuOptions.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, MenuOptions>()
        snapshot.appendSections([.main])
        snapshot.appendItems(optionsContainer)
        dataSource.apply(snapshot)
    }
}

extension SideMenuViewController {
    enum MenuOptions: String, CaseIterable {
        case search = "Search"
        case saved = "Preferred"
    }
}

// MARK: - AlertViewControllerDelegate

//extension SideMenuViewController: AlertViewControllerDelegate {
//    func alertViewControllerDidSelectAction(_ alertViewController: AlertViewController, didSelect action: AlertViewController.Action) {
//        switch action {
//        case .right:
//            logout()
//
//        default: break
//        }
//    }
//}

extension SideMenuViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == closeSideMenuGestureRecognizer {
            return view.bounds.contains(touch.location(in: view)) == false
        }
        return true
    }
}

enum Section {
    case main
}
