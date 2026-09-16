# 💚 Kharcha

> **Smart Money. Smarter Decisions.**

Kharcha is a modern **Flutter-based personal finance and loan management application** designed to help users manage expenses, track loans, monitor EMIs, and understand their financial activity through a clean and intuitive interface.

---

## 🚀 Features

### 🏠 Dashboard

* 💰 Total outstanding balance
* 💳 Active loans overview
* 📅 Upcoming EMI
* 📈 Repayment progress
* 🧾 Recent payments
* ⚡ Quick actions
* 📊 Financial overview

### 💳 Loan Management

* Add new loans
* Manage existing loans
* Track outstanding amount
* EMI tracking
* Next payment date
* Repayment progress
* Loan-wise details

### 💸 Expense Management

* Add income and expenses
* Expense categories
* Category-wise spending
* Transaction history
* Expense tracking
* Spending analysis

### 📊 Financial Insights

* Financial health score
* Saving rate
* Expense control
* Budget usage
* Category-wise analytics
* Interactive charts

### 🔐 Authentication & Security

* Phone number authentication
* Secure login
* JWT authentication
* Password management
* Change password
* Profile management

---

## 🎨 UI & UX

Kharcha is designed with a modern fintech-focused UI.

* 🌱 Premium green theme
* 🧊 Clean card-based interface
* 📱 Responsive layouts
* ✨ Smooth animations
* 📊 Interactive charts
* 🌓 Light & dark themes
* 🎯 Simple navigation
* 🧩 Reusable widgets

---

## 🛠️ Tech Stack

| Technology | Purpose                    |
| ---------- | -------------------------- |
| Flutter    | Cross-platform application |
| Dart       | Programming language       |
| Riverpod   | State management           |
| Dio        | API networking             |
| REST API   | Backend communication      |
| JWT        | Authentication             |
| PostgreSQL | Database                   |
| fl_chart   | Financial charts           |

---

## 📂 Project Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── features/
│   ├── auth/
│   ├── dashboard/
│   ├── loans/
│   ├── transactions/
│   ├── expenses/
│   ├── insights/
│   ├── profile/
│   └── settings/
│
├── models/
├── providers/
├── repositories/
├── services/
│
└── main.dart
```

---

## ⚡ Getting Started

### Prerequisites

Make sure you have Flutter installed.

Check your environment:

```bash
flutter doctor -v
```

### 1. Clone the repository

```bash
git clone https://github.com/your-username/kharcha.git
```

### 2. Open the project

```bash
cd kharcha
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the application

```bash
flutter run
```

---

## 🔧 Development Commands

### Check code

```bash
flutter analyze
```

### Format code

```bash
dart format .
```

### Run tests

```bash
flutter test
```

### Build Android

```bash
flutter build apk --release
```

### Build iOS

```bash
flutter build ios --release
```

---

## 📱 Platform Support

| Platform | Status      |
| -------- | ----------- |
| Android  | ✅ Supported |
| iOS      | ✅ Supported |
| Web      | 🔄 Planned  |
| macOS    | 🔄 Planned  |

---

## 🔄 Application Flow

```text
Splash
   ↓
Authentication
   ↓
Dashboard
   ├── Loans
   │    ├── Add Loan
   │    ├── Loan Details
   │    └── Repayment
   │
   ├── Transactions
   │    ├── Income
   │    └── Expenses
   │
   ├── Insights
   │    ├── Spending
   │    ├── Savings
   │    └── Financial Health
   │
   └── Profile
        ├── Personal Information
        ├── Security
        └── Settings
```

---

## 🔐 Security

Kharcha follows a security-focused architecture for handling authenticated financial data.

* JWT-based authentication
* Protected API requests
* Secure password handling
* Authenticated user sessions
* Environment-based configuration
* No sensitive credentials committed to Git

> **Important:** Never commit API keys, JWT secrets, database passwords, or production credentials to the repository.

---

## 🗺️ Roadmap

* [ ] 🤖 AI-powered financial insights
* [ ] 🔔 Smart EMI reminders
* [ ] 📊 Advanced financial analytics
* [ ] 💳 Payment integration
* [ ] 📄 Loan statement generation
* [ ] 📈 Financial forecasting
* [ ] 🔐 Biometric authentication
* [ ] 🌐 Multi-language support
* [ ] ☁️ Cloud synchronization

---

## 🤝 Contributing

Contributions are welcome.

### Fork the repository

```bash
git clone https://github.com/your-username/kharcha.git
```

### Create a feature branch

```bash
git checkout -b feature/new-feature
```

### Commit your changes

```bash
git commit -m "Add new feature"
```

### Push your branch

```bash
git push origin feature/new-feature
```

Then create a Pull Request.

---

## ⭐ Support

If you like the project, consider giving the repository a ⭐.

It helps support the continued development of Kharcha.

---

## 👨‍💻 Developer

**Sunil Shedge**

Flutter Developer

Focused on:

* Flutter
* Dart
* Fintech Applications
* Mobile App Development
* REST APIs
* State Management

---

## 📄 License

This project is currently under development.

---

# 💚 Kharcha

> **Track. Manage. Grow.**

Built with Flutter & Dart.
