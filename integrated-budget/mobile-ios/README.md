# mobile-ios

iOS app of the Integrated Budget system, built at the Apple Developer Academy. It has two user roles that share one sign-in screen.

- Mechanics (`Controller/Mechanic`) create budgets for a vehicle (name, brand, model, year), add parts with quantities, review the total and send the parts list by email through the `email-service`.
- Vendors (`Controller/Vendor`) maintain their parts catalog with brand and price, which is what mechanics pick from.

`Model/Classes` holds `User`, `Mechanic`, `Vendor`, `Part`, `Budget` and `Inventory`. `AuthFacade` wraps Firebase Auth, and data lives in Firebase Realtime Database with Cloud Functions for server-side steps. Alamofire handles HTTP calls. The sign-in screen has two debug rows that prefill demo vendor and demo mechanic accounts.

## Run

```bash
pod install
```

Open `integratedBudget.xcworkspace` in Xcode and run. Swift 5, iOS 13.6 or later. `GoogleService-Info.plist` is not included. Download one from your own Firebase project and add it to the `integratedBudget` target before building.
