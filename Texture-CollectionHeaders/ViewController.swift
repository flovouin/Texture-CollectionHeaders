//
//  ViewController.swift
//  Texture-CollectionHeaders
//
//  Created by Flo Vouin on 04/10/2017.
//  Copyright © 2017 flovouin. All rights reserved.
//

import AsyncDisplayKit

class ViewController: ASViewController<ASCollectionNode>, ASCollectionDelegate, ASCollectionDataSource,
                      ASCollectionDelegateFlowLayout {
    // MARK: - Lifecycle
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        let collectionNode = ASCollectionNode(collectionViewLayout: layout)

        super.init(node: collectionNode)

        self.node.dataSource = self
        self.node.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.height = 100.0

            self.insertItem()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.height = 0.0

                self.insertItem()
            }
        }
    }

    private func insertItem() {
        let indexPath = IndexPath(item: self.numOfElements, section: 0)
        self.numOfElements += 1
        self.node.insertItems(at: [indexPath])
    }

    // MARK: - ASCollectionDelegateFlowLayout
    private var height = CGFloat(0.0)

    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        return ASSizeRangeMake(CGSize(width: 10.0, height: self.height))
    }

    // MARK: - ASCollectionDataSource
    private var numOfElements = 5

    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return self.numOfElements
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let node = ASTextCellNode()
        node.text = String(indexPath.item)
        node.backgroundColor = .lightGray
        node.style.preferredSize = CGSize(width: 50.0, height: 50.0)
        return node
    }

    func collectionNode(_ collectionNode: ASCollectionNode,
                        supplementaryElementKindsInSection section: Int) -> [String] {
//        return self.height > 0.0 ? [UICollectionElementKindSectionHeader] : []
        return [UICollectionElementKindSectionHeader]
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> ASCellNode {
        let node = ASTextCellNode()
        node.text = "Header"
        node.backgroundColor = .red
        return node
    }
}
