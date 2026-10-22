# Poker King-style Social Poker — Starter v1

A zero-upfront-cost-oriented starter project for an original social poker app using Flutter, Firebase, and GitHub.

## Current prototype
- Attractive purple/gold home screen
- Virtual balance starts at 1,000,000 coins (prototype display only)
- Free Coins tile and reward UI (not connected to real ads yet)
- Texas Hold'em entry
- Daily, weekly, monthly leaderboard screens (sample/demo data)
- Private table screen (prototype UI)
- Table lobby with the user-provided reference ranges and colors
- Maximum 8 seats shown per table
- Simple poker-table screen prototype
- Node.js + Socket.IO room server scaffold

## Important limitations
This is an initial UI and server scaffold, not a finished secure multiplayer poker game. The demo coin balance, leaderboard entries, and button actions are local/sample data. No real ad network, Firebase, authentication, secure poker engine, or production persistence is connected yet.

## Zero-cost-first approach
Use GitHub Free and Firebase Spark (free) initially, and test locally. Free-tier quotas and terms can change. Online multiplayer at scale may need paid hosting. iOS builds require a Mac with Xcode; publishing to app stores may have fees.

## Run the Flutter app
Install Flutter and Android Studio, then from this directory:
```bash
flutter create . --platforms=android,ios
flutter pub get
flutter run
```
If `flutter create` asks to overwrite files, keep this project's `lib/main.dart` and `pubspec.yaml`.

## Run demo server
```bash
cd server
npm install
npm start
```
Health endpoint: `http://localhost:3000/health`

## Next steps
1. Create a Firebase project and register Android/iOS apps.
2. Add Firebase Auth and Firestore using FlutterFire CLI.
3. Move coin grants and balances to trusted server-side logic / Firestore transactions.
4. Build and test a server-authoritative Texas Hold'em engine (deck, turn order, blinds, side pots, hand ranking, reconnects).
5. Add an approved rewarded-ad SDK; only grant 10,000 coins after server-verified ad completion.
6. Implement actual daily/weekly/monthly rankings and abuse prevention.
7. Restrict server CORS, authenticate sockets, add rate limits, and deploy a secure backend.
