//
//  DBaseView.swift
//  Designify
//
//  Created by Milton Palaguachi on 6/6/23.
//

import UIKit

open class DBaseView: UIView, ViewAssembler {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        assemble()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func willAssembleView() {}
    open func assembleView() {}
    open func assembleSubviewHierarchy() { }
    open func assembleSubviewConstrains() { }
    open func didAssembleView() {}

}

public protocol ViewAssembler {
    func willAssembleView()
    func assembleView()
    func assembleSubviewHierarchy()
    func assembleSubviewConstrains()
    func didAssembleView()
}

extension ViewAssembler {
    func assemble() {
        willAssembleView()
        assembleView()
        assembleSubviewHierarchy()
        assembleSubviewConstrains()
        didAssembleView()
    }
}
