Dinz Web3 Wallet

Architecture: 
- MVVM with Combine
- Combination of SwiftUI & UIKit
- Currently uses static Vitalik Buterin's public address to fetch the app data.

Data provider: 
- Alchemy - reliable & scalable API infrastructure, reliable & extensive access to blockchain data.
- Ethereum network

Modules: 
- Containing of: ViewController, ViewModel, Router, Context (passing the data), Factory (creation of the module), separate ContentView
- Additionaly uses services (or repositories) for directly handling networking layer (Web3Service).

- HomeScreen 
  - UIKit + Combine
  - Contains wallet address, wallet details and small list of 5 owned NFTs. 
  - Routes to list of user's incoming transactions, list of user's NFT's 

- NFTList
  - UIKit + Combine
  - List of user's owned NFTs
  - On cell tap opens NFT details
  - Pagination

- NFTDetails 
  -  UIKit + Combine
  -  NFT details (address, image, name, symbol, descriptoin...)

- TransactionsList
  - SwiftUI + Combine
  - On cell tap opens transaction details
  - List of incoming transactions to the user's wallet

- TransactionDetails
  - SwiftUI + Combine
  - Details of the transaction (sender address, receiver address, category...)

Networking: 
  - APIClient with Alamofire & Combine
  - APIRequest protocol for every request
  - Model structure

Cache:
  - Core Data 
  - Wallet details, incoming transactions and owned NFT's data models and corresponding services
  - Cache service to encapsulate database handle

Tests:
  - DinzWeb3Tests target
  - Protocolization of the whole architecture enables extensive testing
  - Introduction of mock elements of each module to enable thorough testing
  - Including async elements testing (Combine)
  - Testing all modules and services, with the exception of UI elements of modules containing SwiftUI code

