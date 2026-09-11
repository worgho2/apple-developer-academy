# integrated-budget

Integrated Budget is a two-part system built at the Apple Developer Academy that connects car mechanics with parts vendors. Mechanics assemble repair budgets from parts that vendors list, and the finished budget is emailed as an HTML parts list.

- `mobile-ios`: Swift iOS app with separate flows for mechanics and vendors, backed by Firebase Auth, Realtime Database and Cloud Functions.
- `email-service`: small Node.js and Express service that the app calls to send the budget email through SendGrid.

Run the email service first, then point the app at it. See each folder's README.
