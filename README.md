# LedakIn (Flutter)

A Flutter-based mobile application designed for field engineers and demolition professionals. This app provides essential tools to calculate explosive materials, manage safety checklists, and determine depth tables with the ability to export to PDF.

---

## 🚀 Features

### 1. 💣 Explosive Material Calculator
- Calculate required explosive charges based on material and environment.
- Inputs for type, density, shape, and safety factors.
- Real-time updates and result display.

### 2. ✅ Checklist / Task Manager
- Add, edit, and complete pre-defined or custom safety checklists.
- Designed for field task verification before and after operations.
- Progress indicator and date-stamped completion.

### 3. 📊 Depth Determination Table
- Input target material and conditions to get recommended borehole depths.
- Organized in an easy-to-read dynamic table.
- Export data to **PDF** for reports or sharing.

---

## 🧱 Tech Stack

- **Flutter** (>=3.0)
- **GetX** for state management and routing
- **PDF** export with `syncfusion_flutter_pdf` or `pdf` package
- **Hive** or **SharedPreferences** for lightweight local data storage

---

## 📦 Installation

```bash
git clone https://github.com/your-username/kppmining_calculator.git
cd kppmining_calculator
flutter pub get
flutter run