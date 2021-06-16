//
//  RealtimeQuotRepo.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/6/15.
//

import Combine

protocol RealtimeQuotRepo {
    func observeRealtimeQuote() -> PassthroughSubject<QuotItem?,Never>
    func updateQuot() -> Future<QuotItem?, Never>
    func toggleRealtimeQuote(enable: Bool)
}
