# 🔧 Flutter API Connection Troubleshooting Guide

## ✅ المشاكل التي تم حلها

### 1. **XMLHttpRequest Error - Android Network Issue** ❌ → ✅
**السبب:** Android 9+ يرفض HTTP cleartext traffic افتراضياً

**الحل المطبق:**
- ✅ إنشاء `network_security_config.xml` 
- ✅ إضافة `rentalplatform.runasp.net` للـ cleartext domains
- ✅ إصلاح `AndroidManifest.xml`

---

## 📋 Checklist عملي

### الخطوة 1: التحقق من الملفات ✅
```
✓ android/app/src/main/res/xml/network_security_config.xml (تم إنشاؤه)
✓ android/app/src/main/AndroidManifest.xml (تم إصلاحه)
✓ lib/core/databases/api/dio_consumer.dart (تم تحسينه)
```

### الخطوة 2: تنظيف وإعادة بناء
```bash
flutter clean
flutter pub get
flutter run --verbose
```

### الخطوة 3: فحص الـ Logs (في VS Code Console)
ابحث عن:
- ✅ `🌐 Network Request` - الطلب الأساسي
- ✅ `✅ Network Response` - النجاح
- ❌ `❌ Network Error` - الخطأ

---

## 🔍 Common Issues و الحلول

### Issue 1: "XMLHttpRequest onError"
**الأسباب المحتملة:**
1. ❌ No network security config → ✅ تم إضافتها
2. ❌ Wrong domain → ✅ تحقق من `rentalplatform.runasp.net`
3. ❌ Firewall/Corporate Network

**الحل:**
```xml
<!-- في network_security_config.xml -->
<domain includeSubdomains="true">rentalplatform.runasp.net</domain>
```

### Issue 2: Connection Timeout
**الحلول:**
```dart
// في DioConsumer
connectTimeout: const Duration(seconds: 30), // زيادة من 10 إلى 30
receiveTimeout: const Duration(seconds: 30),
```

### Issue 3: SSL Certificate Error (إذا كانت HTTPS)
```xml
<domain-config cleartextTrafficPermitted="false">
    <domain includeSubdomains="true">yourapi.com</domain>
    <trust-anchors>
        <certificates src="system" />
    </trust-anchors>
</domain-config>
```

### Issue 4: Android 12+ مشاكل
```xml
<!-- تأكد من وجود في AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

---

## 🧪 اختبار سريع من Dart

```dart
import 'package:dio/dio.dart';

void testConnection() async {
  try {
    final dio = Dio();
    final response = await dio.post(
      'http://rentalplatform.runasp.net/api/Account/login',
      data: {
        'email': 'test@example.com',
        'password': 'password123'
      },
    );
    print('✅ Success: ${response.data}');
  } catch (e) {
    print('❌ Error: $e');
  }
}
```

---

## 📱 اختبار على Device مختلفة

### الجهاز الوهمي (Emulator)
```bash
# استخدم 10.0.2.2 بدلاً من localhost
flutter run --verbose

# في network_security_config.xml
<domain includeSubdomains="true">10.0.2.2</domain>
```

### جهاز حقيقي
```bash
# تأكد من أن الجهاز والـ PC على نفس الـ Network
# اختبر البيانات الحقيقية مباشرة
```

---

## 🚀 خطوات التصحيح الإضافية

### 1. **قم بإعادة بناء اللغة الأم:**
```bash
cd android
./gradlew clean build
cd ..
```

### 2. **حذف cache Dio:**
```dart
// في login method
dio.httpClientAdapter = HttpClientAdapter();
```

### 3. **إضافة headers منظمة:**
```dart
dio.options.headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'User-Agent': 'RentalHub/1.0',
};
```

---

## 📊 Debugging Output

عند تشغيل التطبيق، يجب أن ترى:

```
🌐 Network Request:
URL: http://rentalplatform.runasp.net/api/Account/login
Method: POST
Headers: {Content-Type: application/json}
Data: {email: test@example.com, password: ***}

✅ Network Response:
URL: /api/Account/login
Status: 200
Data: {token: xxx, refreshToken: yyy}
```

---

## ✅ قائمة الفحص النهائية

- [ ] تم إنشاء `network_security_config.xml`
- [ ] تم إصلاح `AndroidManifest.xml` (و إزالة السطر الخاطئ)
- [ ] تم تشغيل `flutter clean`
- [ ] تم تشغيل `flutter pub get`
- [ ] تم إعادة بناء التطبيق
- [ ] تم فحص Console للـ logs
- [ ] اختبار على emulator أو device
- [ ] تم اختبار الـ Postman request نفسه

---

## 🎯 التالي

إذا استمرت المشاكل:

1. **اطلع على network logs** (في VS Code)
2. **أرسل error message كاملة** من logs
3. **اختبر النقطة الخاصة بك** على Postman
4. **تحقق من VPN/Proxy** على الجهاز

---

**تم التحديث:** 10 مايو 2026
**الحل:** Android Network Security + Cleartext Traffic + Enhanced Logging
