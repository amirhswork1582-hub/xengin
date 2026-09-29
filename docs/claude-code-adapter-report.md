# پرونده جامع پیاده‌سازی و اعتبارسنجی Adapter بومی Claude Code برای Xengin

> **هدف این سند:** ارائه مستندات فنی و گزارش تحلیلی فرآیند طراحی، پیاده‌سازی، همگام‌سازی قوانین و اعتبارسنجی دوگانه (Dual CLI Validation) جهت افزودن **Adapter بومی Claude Code** به پروژه عمومی **Xengin** بدون ایجاد تغییر یا ریسک برای محیط مرجع (Antigravity).

---

## ۱. خلاصه مدیریتی و دستاوردها

پروژه **Xengin** که پیش‌تر به‌عنوان موتور مهندسی و مجموعه‌قوانین هوشمند برای Antigravity اعتبارسنجی و در گیت‌هاب منتشر شده بود، اکنون به اولین Adapter رسمی چندپلتفرمی خود برای **Anthropic Claude Code** مجهز شد.

| شاخص | وضعیت قبل | وضعیت پس از این مرحله | مزیت فنی |
| :--- | :---: | :---: | :---: |
| **محیط اجرایی (Runtime)** | انحصار به Native Antigravity | **پشتیبانی دوگانه: Antigravity + Claude Code** | چندسکویی واقعی بدون شکستن قراردادها |
| **روش توزیع در Claude Code** | تعریف‌نشده | **Marketplace Manifest رسمی (`.claude-plugin/marketplace.json`)** | امکان نصب تک‌خطی از طریق مخزن گیت‌هاب |
| **منوی کاربری (UX)** | ۳ مهارت کاربرمحور در Antigravity | **دقیقاً ۳ مهارت متناظر در Claude Code (`task`, `plan`, `review`)** | حفظ ساختار UX و جلوگیری از شلوغی منو |
| **معماری دسترسی به قوانین** | تزریق خودکار قوانین در Antigravity | **Progressive Disclosure از طریق پوشه `references/`** | مدل فقط بخش‌های موردنیاز را لود می‌کند |
| **همگام‌سازی قوانین (Zero-Drift)** | نیازی نبود | **اسکریپت همگام‌ساز خودکار (`scripts/sync-claude-adapter.ps1`)** | منبع حقیقت واحد (Single Source of Truth) |
| **سازگاری با Plan Mode** | اختصاصی تسک‌های داخلی | **هماهنگ با Native Plan Mode رسمی Claude Code (`/plan`)** | همکاری مستقیم با فرآیند تعاملی تأیید پلان |
| **اعتبارسنجی CLI** | فقط با `agy.exe` | **اعتبارسنجی سخت‌گیرانه با هر دو ابزار `claude.exe` و `agy.exe`** | تضمین عدم وجود خطای اسکیما و سینتکس |

---

## ۲. بررسی محیط و کشف قابلیت‌های رسمی Claude Code

پیش از هرگونه کدنویسی، محیط واقعی Claude Code نصب‌شده روی سیستم با رویکرد *Inspect Before Invent* بررسی شد:

### مشخصات کلاینت شناسایی‌شده:
- **مسیر باینری رسمی:**
  `C:\Users\amir\.vscode\extensions\anthropic.claude-code-2.1.283-win32-x64\resources\native-binary\claude.exe`
- **نسخه فعال:** `2.1.283 (Claude Code)`

### استخراج سینتکس و ساختار مجاز:
1. **فرمان‌های Plugin CLI:**
   - `claude plugin marketplace add <source>`: افزودن منبع توزیع افزونه
   - `claude plugin install <plugin>`: نصب افزونه از مارکت‌پلیس
   - `claude plugin validate <path> --strict`: بررسی صحت فایل‌های مانیفست و اسکیل‌ها بر اساس آخرین اسکیمای رسمی Anthropic
2. **الگوی مارکت‌پلیس گیت‌هاب:**
   - برای این‌که یک مخزن گیت‌هاب بتواند نقش Marketplace مستقیم را ایفا کند، فایل `.claude-plugin/marketplace.json` باید در ریشه مخزن وجود داشته باشد.
3. **الگوی اسکیل‌های مستقل:**
   - هر اسکیل در مسیر `skills/<skill-name>/SKILL.md` تعریف شده و می‌تواند پوشه `references/` برای ارجاعات عمیق معماری داشته باشد.

---

## ۳. معماری فنی و حفظ اصل عدم اشتقاق (Zero-Drift)

یکی از چالش‌های بنیادین در پشتیبانی از چند ابزار، خطر **واگرایی قوانین (Rulebook Drift)** است. اگر قوانین فرانت‌اند، بک‌اند و گیت نهایی هم در ساختار Antigravity و هم در ساختار Claude Code نگهداری شوند، هر تغییر در آینده نیازمند ویرایش دستی چندگانه خواهد بود که ذاتاً خطازاست.

### راهکار پیاده‌سازی‌شده:

```text
xengin/
├── rules/                                  # منبع حقیقت واحد (Single Source of Truth)
│   ├── AGENTS.md                          # تزریق خودکار به Antigravity
│   ├── frontend.md
│   ├── backend.md
│   └── includes/                          # فصول استاندارد قوانین
│       ├── core.md
│       ├── workflow.md
│       ├── final-enforcement-gate.md
│       ├── risk-model.md
│       └── graphify-policy.md
│
├── scripts/
│   └── sync-claude-adapter.ps1            # اسکریپت همگام‌ساز قطعی قوانین
│
└── platforms/
    └── claude-code/                        # Adapter اختصاصی پلتفرم Claude Code
        ├── .claude-plugin/
        │   └── plugin.json                # مانیفست افزونه Claude Code
        ├── README.md                      # راهنمای فنی اختصاصی پلتفرم
        ├── integration/
        │   └── CLAUDE.md.example          # الگوی تلفیق با پروژه کاربر
        └── skills/
            ├── xengin-task/
            │   ├── SKILL.md
            │   └── references/            # همگام‌شده خودکار از rules/includes/
            ├── xengin-plan/
            │   ├── SKILL.md
            │   └── references/            # همگام‌شده خودکار از rules/includes/
            └── xengin-review/
                ├── SKILL.md
                └── references/            # همگام‌شده خودکار از rules/includes/
```

### نحوه عملکرد اسکریپت همگام‌سازی:
اسکریپت `scripts/sync-claude-adapter.ps1` به طور خودکار:
- فصول مرجع (`core.md`, `workflow.md`, `final-enforcement-gate.md`, `risk-model.md`, `graphify-policy.md`) را از `rules/includes/` می‌خواند.
- قوانین تخصصی `rules/frontend.md` و `rules/backend.md` را به قالب استاندارد مرجع تبدیل و در پوشه `references/` هر ۳ اسکیل Claude Code بازنویسی می‌کند.
- هرگونه لینک داخلی متناسب با معماری ارجاعات محلی Claude Code تنظیم می‌شود.

---

## ۴. مهارت‌های سه‌گانه در محیط Claude Code

### ۱. مهارت `xengin-task`
- **ماموریت:** اجرای چرخه‌ی ۱۰ مرحله‌ای مهندسی نرم‌افزار برای افزودن فیچر، حل باگ و ریفکتور.
- **فعال‌سازی هوشمند (Natural Prompt):** به صورت خودکار با پرامپت‌های مربوط به پیاده‌سازی یا تغییر کد تریگر می‌شود.
- **منابع مرجع (References):** تمام اصول هسته، مدل ارزیابی ریسک، قوانین فرانت‌اند، قوانین بک‌اند، گیت نهایی و پالیسی Graphify را به صورت Progressive Disclosure مطالعه می‌کند.

### ۲. مهارت `xengin-plan`
- **ماموریت:** تحلیل جامع سیستم، ترسیم مرزهای ریسک و طراحی پلان چندمرحله‌ای (Expand-Migrate-Contract) بدون دستکاری فایل‌های کد.
- **سازگاری با Plan Mode:** با حالت رسمی `/plan` در Claude Code هماهنگ است و برای کاربر مستندات تصمیم‌گیری شفاف تولید می‌کند تا کاربر پیش از اجرا مهر تایید بزند.

### ۳. مهارت `xengin-review`
- **ماموریت:** ممیزی و بازبینی گیت/diff در ۵ بعد مهندسی (امنیت و احراز هویت، یکپارچگی داده و تراکنش، معماری فرانت‌اند و وضعیت، بهداشت کد و تست‌های اثبات‌پذیر).

---

## ۵. شواهد اعتبارسنجی عملی (Evidence-Based Verification)

تمام مراحل با استفاده از دستورات خط فرمان و خروجی‌های واقعی اعتبارسنجی شدند:

### ۱. اعتبارسنجی سخت‌گیرانه مارکت‌پلیس Claude Code:
```powershell
& "C:\Users\amir\.vscode\extensions\anthropic.claude-code-2.1.283-win32-x64\resources\native-binary\claude.exe" plugin validate .claude-plugin/marketplace.json --strict
```
**خروجی واقعی:**
```text
Validating marketplace manifest: G:\AntiGravity\xengin\.claude-plugin\marketplace.json
√ Validation passed
```

### ۲. اعتبارسنجی سخت‌گیرانه پلاگین Claude Code:
```powershell
& "C:\Users\amir\.vscode\extensions\anthropic.claude-code-2.1.283-win32-x64\resources\native-binary\claude.exe" plugin validate platforms/claude-code --strict
```
**خروجی واقعی:**
```text
Validating plugin manifest: G:\AntiGravity\xengin\platforms\claude-code\.claude-plugin\plugin.json
√ Validation passed
```

### ۳. اعتبارسنجی بومی Antigravity Plugin:
```powershell
C:\Users\amir\.gemini\bin\agy.exe plugin validate G:\AntiGravity\xengin
```
**خروجی واقعی:**
```text
  [ok]    G:\AntiGravity\xengin
          ✔ skills      : 3 processed
          - agents      : skipped (not found)
          - commands    : skipped (not found)
          - mcpServers  : skipped (not found)
          - hooks       : skipped (not found)
```

### ۴. پاکسازی مسیرها و ممیزی بهداشت کد (Sanitization Audit):
- اسکن کلیه فایل‌های ریپازیتوری برای ردپای مسیرهای ویندوزی شخصی (`C:\Users\`, `G:\AntiGravity`) انجام شد و تایید گردید که تمامی ارجاعات در داکیومنت‌ها، مانیفست‌ها و اسکیل‌ها کاملاً نسبی و پرتابل هستند.

### ۵. انتشار در مخزن گیت‌هاب (Git Push):
```powershell
git push origin main
```
**خروجی واقعی:**
```text
To https://github.com/amirhswork1582-hub/xengin.git
   5a537d9..df2ee97  main -> main
```
- شناسه کامیت ثبت‌شده: [`df2ee97`](https://github.com/amirhswork1582-hub/xengin/commit/df2ee970306a7abc6635e82513a5d3fe633052c6)
- پیام کامیت: `feat(claude-code): add native Claude Code adapter and marketplace manifest`

---

## ۶. راهنمای کاربری و استقرار

### الف) استفاده در Claude Code

۱. **افزودن مارکت‌پلیس رسمی از مخزن گیت‌هاب:**
```bash
claude plugin marketplace add amirhswork1582-hub/xengin
```

۲. **نصب افزونه Xengin:**
```bash
claude plugin install xengin@xengin
```

۳. **نحوه استفاده:**
- پرامپت‌های عادی:
  > *"Refactor user session storage to secure HTTP-only cookies with tenant scoping"*
- اسلش کامندها:
  ```text
  /xengin-task Add pagination to audit logs API with deterministic sorting
  /xengin-plan Design zero-downtime migration for payment webhook retry queue
  /xengin-review Audit the current branch diff before merge
  ```

---

### ب) استفاده در Antigravity (Reference Runtime)

هیچ تغییری در نحوه کار با Antigravity ایجاد نشده است:
```text
/xengin-task
/xengin-plan
/xengin-review
```
یا با بیان آزاد درخواست در چت، سیستم مهندسی به طور خودکار فعال است.

---

### ج) فرآیند به‌روزرسانی و همگام‌سازی آتی

هر زمان که قواعد اصلی در `rules/` ویرایش یا به‌روزرسانی شوند، کافیست اسکریپت همگام‌ساز اجرا شود:

```powershell
pwsh ./scripts/sync-claude-adapter.ps1
git commit -am "chore(rules): sync updated engineering rules to claude adapter"
git push origin main
```
این فرآیند تضمین می‌کند که افزونه Claude Code همواره با آخرین نسخه قوانین Xengin کاملاً یکپارچه و منطبق باقی بماند.
