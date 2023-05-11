//
//  Configuration.swift
//  Navigation
//
//  Created by new owner on 11.05.2023.
//

import UIKit

enum Configuration {

    static var viewForDebugOrRelease: UIView {
        let view = UIView()
#if DEBUG
        view.backgroundColor = .systemBlue
#else
        view.backgroundColor = .systemGreen
#endif
        return view
    }
}

