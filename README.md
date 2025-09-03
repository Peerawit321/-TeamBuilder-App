นาย.พีรวิชญ์ พันธ์ทอง : 65114540435



# 🏗️ Flutter Team Builder App (with GetX)

แอปตัวอย่าง Flutter ที่ใช้ **GetX** ในการจัดการ State และ Navigation  
อนุญาตให้ผู้ใช้เลือกสมาชิกทีมจากลิสต์ ≥ 20 คน โดยกำหนดเงื่อนไขว่า **เลือกได้สูงสุด 3 คน**  
และสามารถกด **Preview Team** เพื่อดูทีมที่เลือกก่อนยืนยัน

---

## 📌 คุณสมบัติ (Features)
- แสดงรายการสมาชิก (≥ 20 คน) พร้อมข้อมูล **ชื่อ, ตำแหน่ง, และรูป avatar**
- เลือกสมาชิกทีมได้สูงสุด **3 คน**  
  - กันการเลือกซ้ำ  
  - แจ้งเตือนด้วย `Get.snackbar` เมื่อเกินหรือซ้ำ
- ปุ่ม **Preview Team** → ไปหน้าสรุปทีม
- ปุ่ม **Remove / Clear** → ลบสมาชิกออกจากทีม
- ใช้ **GetX (`obs`, `Obx`, `Get.to`, `Get.snackbar`)** สำหรับ State Management และ Navigation

---

## ⚙️ ข้อกำหนดระบบ (Requirements)
- **Flutter SDK**: >= 3.8.x  
- **Dart SDK**: >= 3.8.x  
- **แพ็กเกจหลัก**  
  - [`get`](https://pub.dev/packages/get) ^4.7.2  
  - [`http`](https://pub.dev/packages/http) ^1.2.2  
  - [`get_storage`](https://pub.dev/packages/get_storage) ^2.1.1  
  - [`cached_network_image`](https://pub.dev/packages/cached_network_image) ^3.3.1  
  - [`cupertino_icons`](https://pub.dev/packages/cupertino_icons) ^1.0.8  

---

## ▶️ การติดตั้งและรัน (Installation & Run)

### 1. Clone โปรเจกต์
```bash
git clone <repo-url> my_app
cd my_app

flutter pub get #ติดตั้ง dependencies

flutter run #รันบน Emulator หรือ Device จริง


🖼️ ตัวอย่างการใช้งาน

หน้าเลือกสมาชิก


หน้า Preview ทีม
