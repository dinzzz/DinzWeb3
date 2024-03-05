//
//  TransactionsListViewUI.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 03.03.2024..
//

import SwiftUI

struct TransactionsListViewUI<ViewModel: TransactionsListViewModeling>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Transactions List")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white)
                .font(.system(size: 26, weight: .bold))
                .padding()
            itemListView
        }.background(Color.black)
    }
    
    @ViewBuilder
    var itemListView: some View {
        List {
            ForEach(viewModel.transfers.indices, id: \.self) { index in
                itemView(for: viewModel.transfers[index])
                    .listRowBackground(Color.black)
                    .listRowSeparator(.hidden)
                    .buttonStyle(.plain)
                    .onTapGesture {
                        viewModel.routeToDetails(model: viewModel.transfers[index])
                    }
                    .onAppear {
                        viewModel.willDisplay(at: index)
                    }
            }
        }
        .listStyle(.plain)
        .background(
            Color.black
        )
    }
    
    @ViewBuilder
    func itemView(for item: Model.AssetTransferModel) -> some View {
        VStack {
            Text("From: \(item.from ?? "")")
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("To: \(item.to ?? "")")
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white.opacity(0.2))
                .shadow(color: .black, radius: 0.7)
        )
    }
}
