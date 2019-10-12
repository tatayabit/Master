//
//  StackedScrollView.swift
//  ScrollableStackView
//
//  Created by Kareem Kareem on 6/10/19.
//  Copyright © 2019 Agnes Vasarhelyi. All rights reserved.
//

import UIKit

class StackedScrollView: UIScrollView {

    let stackView = UIStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        // 2. Content is a stack view
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0.0
       stackView.distribution = .fill
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Attaching the content's edges to the scroll view's edges
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Satisfying size constraints
            stackView.widthAnchor.constraint(equalTo: heightAnchor ),
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
            ])
    }

}
