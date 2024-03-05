//
//  NFTDetailsRouter.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 02.03.2024..
//

import Foundation
import UIKit

protocol NFTDetailsRouting {
    var viewController: NFTDetailsViewController? { get set }
}

class NFTDetailsRouter: NFTDetailsRouting {
    weak var viewController: NFTDetailsViewController?
}
