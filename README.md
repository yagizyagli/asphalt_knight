# 🏍️ Asphalt Knight (`asphalt_knight`)

**Ride Hard, Stay Protected. Your Open-Source Digital Shield on the Road.**

`asphalt_knight` is a 100% open-source, zero-cost, and community-driven mobile application designed to save lives on the asphalt. By transforming any ordinary smartphone into an advanced incident detection system, it serves as a digital shield for both motorcyclists and car drivers worldwide.

---
### 🇹🇷 Türkçe Özet
`asphalt_knight`, dünya çapındaki motosiklet ve araba sürücülerinin hayatını kurtarmak amacıyla geliştirilmiş, tamamen ücretsiz, reklamsız ve açık kaynaklı bir mobil uygulamadır. Akıllı telefonların dahili sensörlerini kullanarak kazaları milisaniyeler içinde algılar ve önceden belirlenen acil durum kişilerine Google Maps konum linkiyle birlikte otomatik SOS mesajı gönderir.
---

## ⚡ Core Features & Technical Philosophy

- **Zero-Cost Barrier:** No subscription, no ads, no premium models. Built purely as a global social responsibility initiative to protect delivery riders, commuters, and everyday drivers.
- **Dual Sensing Algorithms (Bi-Vehicle Support):**
  - **🏍️ Knight Mode (Motorcycle):** Fine-tuned to detect sudden vector changes, high-impact crashes, and high-G ground tilts.
  - **🚗 Chariot Mode (Car):** Optimized to detect massive rapid deceleration forces (head-on and rear-end collisions) while filtering out common road bumps and potholes.
- **100% Privacy Focused:** Your location, contacts, and telematics data never leave your device. The app operates entirely locally without a central cloud server.
- **15-Second Life Corridor:** Gives the rider/driver a 15-second window to dismiss false alarms before firing the automated distress signals.
- **Eldorado Design (Glove-Friendly UI):** Minimalistic high-contrast dark theme with giant action buttons tailored specifically for riders wearing heavy gear.

## 🛠️ Tech Stack & Key Libraries

- **Framework:** Flutter (Dart) for true cross-platform compiled native performance.
- **Hardware Integration:**
  - `sensors_plus` - Instantaneous linear G-force vector magnitude calculation via high-frequency accelerometer streams.
  - `geolocator` - High-accuracy GPS transceiver payload generation.
  - `telephony` - Native background transceiver execution for direct SMS dispatching.
  - `shared_preferences` - Secure persistent local storage for critical ICE (In Case of Emergency) contacts.

## 🚀 Getting Started

### Prerequisites
Before compilation, ensure you have the Flutter SDK initialized on your local environment:
```bash
flutter doctor
```

### Installation & Launch
1. Clone the repository:
   ```bash
   git clone https://github.com/yagizyagli/asphalt_knight
   cd asphalt_knight
   ```
2. Install the necessary dependencies defined in `pubspec.yaml`:
   ```bash
   flutter pub get
   ```
3. Run the digital shield on your connected test device:
   ```bash
   flutter run
   ```

## 🗺️ Project Structure

```text
lib/
├── core/                # System boundaries, theme guidelines, and G-Force thresholds
├── data/
│   ├── datasources/     # Local persistent storage engines
│   └── services/        # Hardware layer integrations (Sensors, GPS, SMS Transceiver)
└── presentation/
    ├── screens/         # High-contrast user-friendly screens
    └── widgets/         # Custom glove-compatible responsive inputs
```

## 📐 Software Architecture

The system is engineered utilizing **Clean Architecture** patterns separated into three isolated strict layers:
- **Presentation Layer (UI):** Built with Flutter declarative widgets, highly responsive and optimized for glove-based navigation.
- **Data Layer (Services/Sources):** Directly interfaces with smartphone hardware peripherals (IMU sensors, GPS transceivers, SMS engines) and persistent native local storage (`SharedPreferences`).
- **Core Layer:** Holds mathematical constants, multi-vehicle deceleration G-force thresholds, and centralized theme design patterns.

```text
  [Presentation: UI Screens] 
            │
            ▼ (Triggers)
  [Core: Thresholds / Themes] 
            ▲
            │ (Feeds Hardware Data)
  [Data: Sensors / GPS / SMS Services]
```

## 🤝 Contributing & Community

We believe safety is a human right. We highly encourage developers, engineers, and UX designers from any corner of the world to audit our crash-detection loops, add extra language modules, or optimize battery drain footprints.

1. Fork the project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

## ✍️ Author & Visionary

- ** [Yağız Yağlı /@yagizyagli](https://github.com/yagizyagli)
- **The Vision:** This project was born out of a pure social responsibility mindset to secure human lives on the road. It is built to stand as a shield for delivery riders, motorcyclists, and commuters worldwide—completely non-commercial, non-profit, and powered by the global developer community.

> *"We don't build software for profit; we build shields to bring fathers, mothers, and friends back home safely."*

## 📄 License
MIT License
