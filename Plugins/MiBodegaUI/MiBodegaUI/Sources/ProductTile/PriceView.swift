//
//  PriceView.swift
//  MiBodegaUI
//
//  Created by Milton Palaguachi on 6/7/23.
//

import Designify
import MBPlatform
import UIKit

public struct PriceModel {
    var price: String?
    var discount: String?

    var shouldHidePrice: Bool {
        price == nil
    }

    var shouldHideDiscount: Bool {
        discount == nil
    }
}

public class PriceView: DBaseView  {
    private let stackView = UIStackView(frame: .zero)
    private let priceLabel = UILabel()
    private let discountLabel = UILabel()

    var model: PriceModel {
        didSet { applyModel() }
    }

    public init(model: PriceModel) {
        self.model = model
        super.init(frame: .zero)
        applyModel()
    }

    public override func assembleView() {
        super.assembleView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
    }

    public override func assembleSubviewHierarchy() {
        super.assembleSubviewHierarchy()
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(discountLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
    }

    public override func assembleSubviewConstrains() {
        super.assembleSubviewConstrains()
        priceLabel.setContentHuggingPriority(.requiredComplient, for: .vertical)
        discountLabel.setContentHuggingPriority(.requiredComplient, for: .vertical)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension PriceView {
    private func applyModel() {
        priceLabel.text = model.price
        priceLabel.isHidden = model.shouldHidePrice
        discountLabel.text = model.discount
        discountLabel.isHidden = model.shouldHideDiscount
    }
}
