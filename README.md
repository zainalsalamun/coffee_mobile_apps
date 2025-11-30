# ☕ Coffee Management App (Flutter)

Aplikasi manajemen coffee shop berbasis Flutter yang dibuat mengikuti desain Figma dengan tampilan elegan menggunakan warna maroon, font Georgia, dan layout bergaya iOS.

Aplikasi ini mencakup halaman:
- Login
- Register
- Dashboard Home
- Menu Kopi
- Peralatan & Mesin
- Persediaan
- Edit Profile

---

## 🚀 Features

### ✅ UI/UX
- Desain mengikuti Figma 100%
- Card item bergaya minimalis
- Search bar elegan & reusable
- Grid item 2 kolom dengan radius 22
- Back button custom
- Color theme maroon premium

### 📦 Module
- Menu kopi
- Peralatan & mesin
- Persediaan
- Edit profile
- Add & Select item section

---

## 📁 Project Structure



lib/
┣ widgets/
┃ ┣ app_search_bar.dart
┃ ┗ app_item_card.dart (opsional)
┣ pages/
┃ ┣ login_page.dart
┃ ┣ register_page.dart
┃ ┣ home_page.dart
┃ ┣ menu_page.dart
┃ ┣ equipment_page.dart
┃ ┣ persediaan_page.dart
┃ ┗ edit_profile_page.dart
┣ theme/
┃ ┗ app_theme.dart
┗ main.dart


---

## 📦 Dependencies (Core)



flutter:
sdk: flutter

cupertino_icons: ^1.0.6


Tambahan paket opsional:
- `google_fonts` (kalau nanti dipakai)
- `get` (jika pakai GetX)
- `shared_preferences`
- `dio` (untuk API)

---

# 🛠 Cara Menjalankan Aplikasi (Local)

Pastikan sudah install:
- Flutter SDK (versi terbaru)
- Android Studio atau VSCode
- Device/Emulator

---

## 1️⃣ Clone Project

```sh
git clone https://github.com/your-username/coffee-app.git
cd coffee-app

2️⃣ Install Dependencies
flutter pub get

3️⃣ Jalankan App
Jalankan di emulator / device
flutter run


atau kalau mau pilih device:

flutter devices
flutter run -d <device_id>

📱 Build APK (Release)

Pakai langkah ini untuk membuat APK yang bisa diinstall manual.

1️⃣ Build APK
flutter build apk --release


Output APK:

build/app/outputs/flutter-apk/app-release.apk


Siap dikirim atau diinstall ke Android.

🏬 Build AAB (Bundle) — Upload ke PlayStore

Untuk PlayStore pakai .aab:

flutter build appbundle --release


Output bundle:

build/app/outputs/bundle/release/app-release.aab

🔐 Signing / Keystore (Opsional)

Kalau belum punya keystore:

keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key


Lalu setting di:

android/app/build.gradle
android/key.properties

📝 Catatan

Pastikan semua assets sudah terdaftar di pubspec.yaml

Gunakan resolusi gambar tinggi agar UI terlihat premium

Semua page bisa dipadukan dengan backend / API nanti