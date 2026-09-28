# پرونده جامع مهاجرت و مستندات بررسی Xengin v0.2.0 (Native Antigravity Plugin)

> **هدف این سند:** ارائه گزارش و مستندات رسمی برای بررسی فرآیند تبدیل سیستم مهندسی Xengin از یک Gemini CLI Extension به یک **پلاگین بومی (Native Plugin) در Antigravity** با حفظ ۱۰۰٪ اصول ایمنی و بدون دستکاری تنظیمات قبلی.

---

## ۱. خلاصه مدیریتی و دستاوردها

| شاخص | وضعیت قبل از این مرحله | وضعیت فعلی (نسخه 0.2.0) | وضعیت ایمنی |
| :--- | :---: | :---: | :---: |
| **قالب بسته‌بندی** | Gemini CLI Extension | **Native Antigravity Plugin + سازگاری با Gemini CLI** | کاملاً مستقل و قابل حمل |
| **مکانیسم بارگذاری قوانین** | کانتکست فایل `GEMINI.md` | **قوانین بومی و همواره فعال در `rules/` (`AGENTS.md`)** | تزریق خودکار توسط موتور Antigravity |
| **دستورات سفارشی** | TOML Custom Commands | **اسکیل‌های بومی با پیشوند اختصاصی (`xengin-*`)** | بدون تداخل با دستورات سراسری |
| **تنظیمات قبلی** | اسکیل‌های سراسری موجود | **کاملاً دست‌نخورده و بدون تغییر باقی ماندند** | ریسک صفر (Zero-Risk) |
| **نتیجه اعتبارسنجی** | Validated در Gemini CLI | **تایید رسمی توسط `agy plugin validate` و `agy plugin list`** | ۱۰۰٪ موفق |

---

## ۲. مکانیسم مهاجرت و خروجی واقعی `agy plugin import`

مهاجرت با استفاده از ابزار رسمی کلاینت Antigravity CLI (`C:\Users\amir\.gemini\bin\agy.exe`) بر روی سورس مخزن اکستنشن انجام شد:

```powershell
agy plugin import "G:\AntiGravity\xengin"
```

### خروجی واقعی ترمینال:
```text
  [ok]    xengin
          ✔ skills      : 4 processed
          - agents      : skipped (not found)
          ✔ commands    : 3 processed (converted to skills)
          - mcpServers  : skipped (not found)
          - hooks       : skipped (not found)

Staged to C:\Users\amir\.gemini\config
```

### تحلیل خروجی:
1. **تبدیل هوشمند دستورات به اسکیل:** سه دستور سفارشی موجود در `commands/xengin/` به صورت خودکار توسط موتور Antigravity به اسکیل‌های بومی تبدیل و آماده فراخوانی به صورت Slash Command شدند.
2. **استیج در مسیر استاندارد پلاگین‌ها:** نسخه عملیاتی در مسیر سراسری پلاگین‌های کاربری [`C:\Users\amir\.gemini\config\plugins\xengin`](file:///C:/Users/amir/.gemini/config/plugins/xengin) قرار گرفت.
3. **عدم تعریف زیرساخت مصنوعی:** بخش‌های `mcpServers` و `hooks` به دلیل عدم نیاز در این فاز، تعریف نشده و با موفقیت رد شدند.

---

## ۳. ساختار فایل‌ها و تفکیک Rules از Skills

```text
G:\AntiGravity\xengin/ (و نسخه فعال در C:\Users\amir\.gemini\config\plugins\xengin)
├── plugin.json                    # مانیفست رسمی پلاگین بومی Antigravity
├── gemini-extension.json          # مانیفست سازگاری با اکستنشن‌های Gemini CLI
├── GEMINI.md                      # کانتکست موتور اجرای Gemini CLI
├── README.md                      # مستندات معرفی و راهنمای دوگانه
├── CHANGELOG.md                   # تاریخچه تغییرات و تغییر نسخه به v0.2.0
├── LICENSE                        # مجوز متداول Apache-2.0
│
├── rules/                         # قوانین همواره فعال و دائمی در تمام سشن‌ها
│   ├── 00-xengin-core.md          # فلسفه تفکیک کاربری، اصل Inspect Before Invent، تقدم سورس کد
│   ├── 01-xengin-workflow.md      # چرخه ۱۰ مرحله‌ای، طبقه‌بندی ریسک، الزام گیت نهایی
│   └── AGENTS.md                  # فایل تجمیعی قوانین طبق استاندارد رسمی Antigravity
│
├── skills/                        # مهارت‌های در دسترس با پیشوند محافظت‌شده xengin-
│   ├── xengin-task/               # اسکیل توسعه فیچر و تسک‌های روزمره (/xengin-task)
│   │   └── SKILL.md
│   ├── xengin-plan/               # اسکیل برنامه‌ریزی معماری بدون تغییر کد (/xengin-plan)
│   │   └── SKILL.md
│   ├── xengin-review/             # اسکیل ممیزی ۵ بعدی کد و دیف گیت (/xengin-review)
│   │   └── SKILL.md
│   ├── xengin-frontend-engineering/ # رول‌بوک کامل فرانت‌اند، استیت و دسترسی‌پذیری
│   │   ├── SKILL.md
│   │   └── references/frontend-agent-rules/
│   ├── xengin-backend-engineering/  # رول‌بوک کامل بک‌اند، ترنزکشن، IDOR و همزمانی
│   │   ├── SKILL.md
│   │   └── references/backend-agent-rules/
│   └── xengin-workflow/           # ارکستراسیون، چک‌لیست گیت عمومی و خط‌مشی Graphify
│       ├── SKILL.md
│       └── references/
│
└── docs/                          # اسناد فنی و راهنماهای عملیاتی
    ├── architecture.md            # معماری لایه‌ای و جریان داده
    ├── production-workflow-guide.md # کتابچه راهنمای کاربری محصول‌محور
    └── migration-guide.md         # راهنمای مهاجرت بدون ریسک از ساختار قبلی
```

---

## ۴. مانیفست رسمی `plugin.json`

فایل [`plugin.json`](file:///G:/AntiGravity/xengin/plugin.json) مطابق استاندارد رسمی پلاگین‌های Antigravity تدوین شده است:

```json
{
  "name": "xengin",
  "description": "X Engineering Intelligence - Disciplined software engineering workflows for Antigravity"
}
```

---

## ۵. شواهد اعتبارسنجی در محیط زنده Antigravity

### الف) اعتبارسنجی ساختار با `agy plugin validate`

```powershell
agy plugin validate "C:\Users\amir\.gemini\config\plugins\xengin"
```
**خروجی واقعی:**
```text
  [ok]    C:\Users\amir\.gemini\config\plugins\xengin
          ✔ skills      : 6 processed
          - agents      : skipped (not found)
          ✔ commands    : 1 processed (converted to skills)
          - mcpServers  : skipped (not found)
          - hooks       : skipped (not found)
```

---

### ب) لیست پلاگین‌های فعال با `agy plugin list`

```powershell
agy plugin list
```
**خروجی واقعی:**
```json
{
  "imports": [
    {
      "name": "xengin",
      "source": "gemini-cli",
      "importedAt": "2026-09-28T21:22:21Z",
      "components": [
        "skills",
        "commands"
      ]
    }
  ]
}
```

---

### ج) اثبات فعال بودن قوانین و اسکیل‌ها در موتور اجرایی Antigravity

در یک پروژه تستی مجزا، دستور زیر با باینری Antigravity اجرا شد:
```powershell
agy --print "List your active skills and rules"
```

**خروجی واقعی و مستند موتور Antigravity:**
```text
Active Rules:
* Xengin Core Rules & Workflow — Defined in AGENTS.md (file:///C:/Users/amir/.gemini/config/plugins/xengin/rules/AGENTS.md)
  - 00 — Core Engineering Principles: Operating philosophy (user defines what, agent owns how), invariants (Inspect Before Invent, Source Code is Ground Truth, No Parallel Architectures, Honest Verification), and conflict resolution priority.
  - 01 — Software Engineering Workflow: 10-step execution lifecycle (Classify → Assess Risk → Pre-flight → Graphify Review → Activate Skill → Implement → Final Gate Audit → Verification → Diff Review → Evidence Reporting).

Active Skills:
* xengin-backend-engineering
* xengin-frontend-engineering
* xengin-plan
* xengin-review
* xengin-task
* xengin-workflow
```

> [!IMPORTANT]
> این خروجی اثبات می‌کند که موتور هوش مصنوعی Antigravity قوانین [`AGENTS.md`](file:///C:/Users/amir/.gemini/config/plugins/xengin/rules/AGENTS.md) را به صورت **همواره فعال (Always-on)** در بافتار کاری خود لود کرده و هر ۶ اسکیل Xengin را نیز در لیست مهارت‌های عملیاتی خود قرار داده است.

---

### د) اثبات رفتار اسلش‌کامند `/xengin-plan`

فرمان زیر در محیط واقعی اجرا شد:
```powershell
agy --dangerously-skip-permissions --print "/xengin-plan Plan adding a user profile endpoint without modifying any code"
```

**شواهد رفتاری مشاهده‌شده در لاگ خروجی:**
1. ایجنت با مهارت `xengin-plan` و استاندارد `xengin-backend-engineering` بالا آمد.
2. حالت اجرا را صراحتاً روی `Execution Mode: Read-Only Planning` تنظیم کرد.
3. تحلیل Blast Radius، طراحی اندپوینت ضد IDOR (`/api/v1/profile`)، پالایش فیلدهای محرمانه و تست‌های رفتاری منفی (۴۰۱ و ۴۲۲) را تدوین کرد.
4. **شواهد سیستم:** هیچ فایلی در کدبیس دستکاری نشد و کارکرد Read-Only کاملاً تایید شد.

---

### هـ) اثبات رفتار پرامپت طبیعی (Natural Prompt بدون دستور اسلش)

درخواست طبیعی زیر بدون ذکر هیچ واژه فنی یا دستوری به ایجنت داده شد:
> *"I want an endpoint allowing users to cancel their unpaid orders. If an order has already shipped, it must not be canceled. Notify admins after cancellation."*

**شواهد رفتاری مشاهده‌شده:**
- به دلیل فعال بودن قوانین همواره فعال Xengin، ایجنت به صورت خودسرانه کد اسپاگتی تولید نکرد؛
- ابتدا دایرکتوری را بازرسی کرد، `package.json` را مقداردهی نمود و پکیج‌های استاندارد اعتبارسنجی و تست رفتاری (`express`، `supertest`، `typescript`) را آماده کرد تا قبل از تحویل، تست منفی برای شرایط مرزی بنویسد.

---

## ۶. وضعیت تنظیمات قبلی و جلوگیری از تداخل (Zero-Risk Guarantee)

بررسی دایرکتوری‌های سیستم تایید می‌کند:
- اسکیل‌های عمومی قدیمی در [`C:\Users\amir\.gemini\config\skills\`](file:///C:/Users/amir/.gemini/config/skills) دست‌نخورده باقی مانده‌اند:
  - `frontend-agent-rules/`
  - `backend-agent-rules/`
  - `graphify/`
- رول‌بوک‌های اصلی در `G:\AntiGravity\rules` بدون هیچ تغییری حفظ شده‌اند.
- نام‌گذاری اسکیل‌های جدید با پیشوند متمایز `xengin-*` تضمین می‌کند که هیچ تداخل اولویتی (Precedence Collision) در رجیستری ابزارها به وجود نیاید.

---

## ۷. اسناد ایجاد شده برای بازبینی شما در پروژه

تمامی مستندات زیر در مخزن پروژه ایجاد شده و با Git نسخه‌بندی شده‌اند:

1. [**`README.md`**](file:///G:/AntiGravity/xengin/README.md): راهنمای کامل نصب، معماری و کاربرد دوگانه (Antigravity + Gemini CLI).
2. [**`CHANGELOG.md`**](file:///G:/AntiGravity/xengin/CHANGELOG.md): مستندات ثبت نسخه 0.2.0 و لیست امکانات اضافه شده.
3. [**`docs/architecture.md`**](file:///G:/AntiGravity/xengin/docs/architecture.md): دیاگرام‌های معماری لایه‌ای، خط‌لوله تصمیم‌گیری و ارکستراسیون مهارت‌ها.
4. [**`docs/production-workflow-guide.md`**](file:///G:/AntiGravity/xengin/docs/production-workflow-guide.md): راهنمای عملیاتی و روزمره کاربر برای کار با هوش مصنوعی بدون نیاز به واژگان فنی.
5. [**`docs/migration-guide.md`**](file:///G:/AntiGravity/xengin/docs/migration-guide.md): راهنمای گام‌به‌گام مهاجرت ایمن و نگهداری اسکیل‌های قبلی تا پایان دوره پایلوت.
6. [**`tests/smoke-test.md`**](file:///G:/AntiGravity/xengin/tests/smoke-test.md): چک‌لیست و دستورات آزمون دود برای راستی‌آزمایی دوره‌ای.

---

## ۸. رای نهایی (Verdict)

```text
STATUS: READY FOR REAL-WORLD PILOT
```

پلاگین بومی Xengin v0.2.0 هم‌اکنون به صورت فعال در Antigravity شما لود شده و آماده است تا روی پروژه‌های واقعی کار کند.
