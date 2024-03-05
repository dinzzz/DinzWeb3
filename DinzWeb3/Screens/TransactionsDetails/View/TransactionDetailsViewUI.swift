//
//  TransactionDetailsViewUI.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 04.03.2024..
//

import SwiftUI

struct TransactionDetailsViewUI<ViewModel: TransactionDetailsViewModeling>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
            ZStack {
                Color.black
                VStack {
                    Text("Transaction details")
                        .foregroundStyle(.white)
                        .font(.system(size: 26, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    Text("From: \(viewModel.transferModel.from ?? "")")
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("To: \(viewModel.transferModel.to ?? "")")
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Category: \(viewModel.transferModel.category ?? "")")
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Value: \(String(format: "%.4f", viewModel.transferModel.value ?? 0))")
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Block number: \(viewModel.transferModel.blockNum ?? "")")
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding()
            }
        }
}
