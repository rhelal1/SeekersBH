//
//  SidebarViewController.swift
//  SeekersBH
//
//  Created by Ruqaya Helal on 09/12/2024.
//

import UIKit

class SidebarViewController: UIViewController {
    
    private enum SidebarItemType: Int {
            case header, expandableRow, row
        }
    
    private enum SidebarSection: Int {
        case library, collections
    }
    
    private struct SidebarItem: Hashable, Identifiable {
        let id: UUID
        let type: SidebarItemType
        let title: String
        let subtitle: String?
        let image: UIImage?
        
        static func header(title: String, id: UUID = UUID()) -> Self {
               return SidebarItem(id: id, type: .header, title: title, subtitle: nil, image: nil)
           }
        
        static func expandableRow(title: String, subtitle: String?, image: UIImage?, id: UUID = UUID()) -> Self {
            return SidebarItem(id: id, type: .expandableRow, title: title, subtitle: subtitle, image: image)
        }


        static func row(title: String, subtitle: String?, image: UIImage?, id: UUID = UUID()) -> Self {
            return SidebarItem(id: id, type: .row, title: title, subtitle: subtitle, image: image)
        }
        
    }
    
    private struct RowIdentifier {
        static let allRecipes = UUID()
        static let favorites = UUID()
        static let recents = UUID()
    }

    private var collectionView: UICollectionView!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        // Do any additional setup after loading the view.
    }


}


extension SidebarViewController {
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }


    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            var configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
            configuration.showsSeparators = false
            configuration.headerMode = .firstItemInSection
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            return section
        }
        return layout
    }


}


@available(iOS 14, *)
extension SidebarViewController: UICollectionViewDelegate {
    
}


//Reference :
//https://developer.apple.com/tutorials/mac-catalyst/creating-a-sidebar
