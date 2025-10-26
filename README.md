# 🌾 Kisan Connect – Smart Farmer Marketplace Application

## 📖 Overview
**Kisan Connect** is a digital platform that connects farmers directly with consumers and local markets, eliminating the need for middlemen.  
The main goal is to ensure **fair prices for farmers**, improve **transparency**, and simplify the **buying & selling** of agricultural products through a **mobile-friendly application**.

This project uses modern technologies for smooth interaction between **farmers, buyers**, and an **admin panel** to monitor transactions.

---

## 🎯 Problem Statement
Many farmers sell their crops and products through middlemen who take a large share of profits.  
Additionally, most farmers:

- Lack awareness of fair pricing and digital tools.  
- Struggle to market their products effectively.  
- Face delays and unfair negotiations.  

**Kisan Connect** solves this by empowering farmers to sell their goods directly using a simple and localized app — increasing income and market access.

---

## ⚙️ Tech Stack

| Component | Technology Used |
|------------|-----------------|
| **Frontend** | Flutter |
| **Backend** | Django REST Framework |
| **Database** | PostgreSql |
| **Hosting** | AWS |
| **APIs** | REST APIs |
| **Authentication** | JWT-based user login/signup |

---

## 💡 Key Features

### 👨‍🌾 Farmer Features
- Secure registration and login.  
- Upload product details (name, quantity, price, and images).  
- View real-time demand and orders.  
- Edit or delete listed products anytime.  
- Receive notifications for new buyer inquiries.  

### 🛒 Buyer Features
- Search for crops or products by name or category.  
- View available farmers and direct contact options.  
- Place purchase requests directly to farmers.  
- Get notified when a farmer accepts or updates the order status.  

### 🧑‍💼 Admin Panel
- Manage users (farmers and buyers).  
- Approve or remove listings.  
- View sales analytics and farmer performance.  
- Handle user queries and monitor activity.  

---

## 🧙‍⚙️ System Architecture
```
Flutter App (Frontend)
        │
        ▼
Django REST API (Backend)
        │
        ▼
MySQL Database (Data Storage)
        │
        ▼
AWS Cloud Server (Hosting)
```

---

## 🧠 Working Procedure

### 1. Farmer Registration
- Farmer creates an account using mobile/email.  
- Profile setup includes farm details and location.  

### 2. Product Upload
- Farmer uploads crop details (type, price, and image).  
- Data is sent to the backend and stored in MySQL.  

### 3. Buyer Interaction
- Buyers browse products and select items of interest.  
- Buyers send a purchase request directly to the farmer.  

### 4. Order Management
- Farmers receive the buyer request.  
- They can accept, reject, or modify the order.  
- Upon acceptance, a confirmation is sent to the buyer.  

### 5. Admin Supervision
- Admin monitors all listings, transactions, and user activities.  
- Admin ensures no fraudulent or duplicate listings exist.  

### 6. Reports & Analytics
- Weekly and monthly reports generated for sales and transactions.  
- Analytics available for both admin and farmers to track growth.  

---

## 📲 Application Flow
```
Farmer → Add Product → View Requests → Accept Order
Buyer → Search Crop → Send Request → Receive Confirmation
Admin → Monitor Users → Approve Listings → Generate Reports
```

---

## 💻 Setup Instructions

### 🧱️ Backend (Django)

**Clone the repository:**
```bash
git clone https://github.com/<Your Hosted backedn project>/KisanKonnect/.git
cd KisanKonnect/backend
```

**Create a virtual environment:**
```bash
python -m venv env
source env/bin/activate   # On Windows: env\Scripts\activate
```

**Install dependencies:**
```bash
pip install -r requirements.txt
```

**Run migrations:**
```bash
python manage.py migrate
```

**Start the server:**
```bash
python manage.py runserver
```

---

### 📱 Frontend (Flutter)

**Go to the Flutter directory:**
```bash
cd kisan-connect/flutter_app
```

**Install dependencies:**
```bash
flutter pub get
```

**Update your API base URL:**
```dart
const String baseUrl = "http://your-aws-server-ip/api/";
```

**Run the app:**
```bash
flutter run
```

---

## ☁️ Deployment Details
- **Backend:** AWS EC2 (Ubuntu Server)  
- **Database:** AWS RDS (PostgreSql)  
- **Media Files:** AWS S3 Bucket for product images  
- **Frontend:** Deployed using AWS Amplify or via APK release  

---

## 🧾 Example Data Format

| Product | Category | Quantity | Price | Farmer | Status |
|----------|-----------|-----------|--------|----------|----------|
| Tomatoes | Vegetables | 100 kg | ₹30/kg | Ram Kumar | Available |
| Rice | Grains | 500 kg | ₹40/kg | Ravi Teja | Sold |

---

## 🚀 Future Enhancements
- AI-based price prediction based on market trends.  
- Integration with government market price APIs.  
- Multilingual interface for regional language support.  
- Offline mode for areas with poor internet connectivity.  
- Payment gateway for online transactions.  

---

## 📸 Screenshots **
HomePageView
<img width="1391" height="755" alt="image" src="https://github.com/user-attachments/assets/739091d0-093f-4473-8f28-635054a36c4e" />
Farmer Home Page
<img width="1140" height="712" alt="image" src="https://github.com/user-attachments/assets/f0bcfb54-04ca-487b-836c-834cb977406b" />
Key Feauters                                      
![WhatsApp Image 2025-10-25 at 11 24 23_29820082](https://github.com/user-attachments/assets/5804c213-c796-4c6d-a671-7772a42e1b45)
Buyers Home Page
<img width="1248" height="700" alt="image" src="https://github.com/user-attachments/assets/de09e62f-cbab-4015-9407-45c2ecd4b535" />
Buying products page
<img width="1200" height="686" alt="image" src="https://github.com/user-attachments/assets/75579499-7508-40f0-b9b7-5a19e426451d" />








---

## 👨‍💻 Contributors

| Name | Role | Description |
|------|------|-------------|
| **S. Chandu** | Developer & Project Lead | Designed and developed the Flutter + Django app, integrated APIs, and handled AWS deployment. |

---

## 📄 License
This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.

---

## Contact

If you have any questions or suggestions regarding the Coffee app, feel free to contact us at kingchandus143@gmail.com 

---


