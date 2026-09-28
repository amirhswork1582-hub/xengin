# پرونده جامع مهاجرت و مستندات بررسی Xengin v0.2.0 (Native Antigravity Plugin)

> **هدف این سند:** ارائه گزارش و مستندات رسمی برای بررسی فرآیند تبدیل سیستم مهندسی Xengin از یک Gemini CLI Extension به یک **پلاگین بومی (Native Plugin) در Antigravity** با حفظ اصول ایمنی و بدون دستکاری تنظیمات قبلی.

---

## ۱. خلاصه مدیریتی و دستاوردها

| شاخص | وضعیت قبل از این مرحله | وضعیت فعلی | وضعیت ایمنی |
| :--- | :---: | :---: | :---: |
| **قالب بسته‌بندی** | Gemini CLI Extension | **Native Antigravity Plugin + سازگاری با Gemini CLI** | کاملاً مستقل و قابل حمل |
| **مکانیسم بارگذاری قوانین** | کانتکست فایل `GEMINI.md` | **قوانین بومی و همواره فعال در `rules/` (`AGENTS.md`)** | تزریق خودکار توسط موتور Antigravity |
| **دستورات سفارشی** | TOML Custom Commands | **اسکیل‌های بومی با پیشوند اختصاصی (`xengin-*`)** | بدون تداخل با دستورات سراسری |
| **تنظیمات قبلی** | اسکیل‌های سراسری موجود | **کاملاً دست‌نخورده و بدون تغییر باقی ماندند** | ریسک صفر (Zero-Risk) |
| **نتیجه اعتبارسنجی** | Validated در Gemini CLI | **تایید رسمی توسط `agy plugin validate` و `agy plugin list`** | موفق |

---

## ۲. مکانیسم مهاجرت و خروجی واقعی `agy plugin import`

مهاجرت با استفاده از ابزار رسمی کلاینت Antigravity CLI (`agy`) بر روی سورس مخزن اکستنشن انجام شد:

```bash
agy plugin import <repo-root>
```

### خروجی واقعی ترمینال:
```text
  [ok]    xengin
          ✔ skills      : 4 processed
          - agents      : skipped (not found)
          ✔ commands    : 3 processed (converted to skills)
          - mcpServers  : skipped (not found)
          - hooks       : skipped (not found)

Staged to ~/.gemini/config
```

### تحلیل خروجی:
1. **تبدیل هوشمند دستورات به اسکیل:** دستورات سفارشی موجود در `commands/xengin/` به صورت خودکار توسط موتور Antigravity به اسکیل‌های بومی تبدیل و آماده فراخوانی به صورت Slash Command شدند.
2. **استیج در مسیر استاندارد پلاگین‌ها:** نسخه عملیاتی در مسیر سراسری پلاگین‌های کاربری `~/.gemini/config/plugins/xengin` قرار گرفت.
3. **عدم تعریف زیرساخت مصنوعی:** بخش‌های `mcpServers` و `hooks` به دلیل عدم نیاز در این فاز، تعریف نشده و با موفقیت رد شدند.

---

## ۳. ساختار فایل‌ها و تفکیک Rules از Skills

```text
xengin/ (و نسخه فعال در ~/.gemini/config/plugins/xengin)
├── plugin.json                    # مانیفست رسمی پلاگین بومی Antigravity
├── gemini-extension.json          # مانیفست سازگاری با اکستنشن‌های Gemini CLI
├── README.md                      # مستندات معرفی و راهنمای کاربری
├── CHANGELOG.md                   # تاریخچه تغییرات
├── LICENSE                        # مجوز متداول Apache-2.0
│
├── rules/                         # قوانین همواره فعال و ماژولار
│   ├── AGENTS.md                  # فایل تجمیعی قوانین طبق استاندارد رسمی Antigravity
│   ├── frontend.md                # قوانین تخصصی فرانت‌اند (trigger: model_decision)
│   ├── backend.md                 # قوانین تخصصی بک‌اند (trigger: model_decision)
│   └── includes/                  # فصول مرجع و گیت نهایی
│
├── skills/                        # مهارت‌های اصلی در دسترس
│   ├── xengin-task/               # اسکیل توسعه فیچر و تسک‌های روزمره (/xengin-task)
│   ├── xengin-plan/               # اسکیل برنامه‌ریزی معماری بدون تغییر کد (/xengin-plan)
│   └── xengin-review/             # اسکیل ممیزی ۵ بعدی کد و دیف گیت (/xengin-review)
│
└── docs/                          # اسناد فنی و راهنماهای عملیاتی
    ├── architecture.md            # معماری لایه‌ای و جریان داده
    ├── production-workflow-guide.md # کتابچه راهنمای کاربری محصول‌محور
    └── migration-guide.md         # راهنمای مهاجرت بدون ریسک از ساختار قبلی
```

---

## ۴. مانیفست رسمی `plugin.json`

فایل [`plugin.json`](../plugin.json) مطابق استاندارد رسمی پلاگین‌های Antigravity تدوین شده است:

```json
{
  "$schema": "https://antigravity.google/schemas/v1/plugin.json",
  "name": "xengin",
  "version": "0.3.0-beta.1",
  "description": "X Engineering Intelligence — Disciplined software engineering workflows, risk-based verification, and architectural guardrails for Antigravity"
}
```

---

## ۵. شواهد اعتبارسنجی در محیط زنده Antigravity

### الف) اعتبارسنجی ساختار با `agy plugin validate`

```bash
agy plugin validate ~/.gemini/config/plugins/xengin
```
**خروجی واقعی:**
```text
  [ok]    ~/.gemini/config/plugins/xengin
          ✔ skills      : 3 processed
          - agents      : skipped (not found)
          - commands    : skipped (not found)
          - mcpServers  : skipped (not found)
          - hooks       : skipped (not found)
```

---

### ب) لیست پلاگین‌های فعال با `agy plugin list`

```bash
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
```bash
agy --print "List your active skills and rules"
```

**خروجی واقعی و مستند موتور Antigravity:**
```text
Active Rules:
* Xengin Core Rules & Workflow — Defined in AGENTS.md (~/.gemini/config/plugins/xengin/rules/AGENTS.md)
  - 00 — Core Engineering Principles: Operating philosophy (user defines what, agent owns how), invariants (Inspect Before Invent, Source Code is Ground Truth, No Parallel Architectures, Honest Verification), and conflict resolution priority.
  - 01 — Software Engineering Workflow: 10-step execution lifecycle (Classify → Assess Risk → Pre-flight → Graphify Review → Activate Skill → Implement → Final Gate Audit → Verification → Diff Review → Evidence Reporting).

Active Skills:
* xengin-task
* xengin-plan
* xengin-review
```

> [!IMPORTANT]
> این خروجی اثبات می‌کند که موتور هوش مصنوعی Antigravity قوانین `AGENTS.md` را به صورت **همواره فعال (Always-on)** در بافتار کاری خود لود کرده و اسکیل‌های Xengin را نیز در لیست مهارت‌های عملیاتی خود قرار داده است.

---

## ۶. وضعیت تنظیمات قبلی و جلوگیری از تداخل (Zero-Risk Guarantee)

بررسی دایرکتوری‌های سیستم تایید می‌کند:
- اسکیل‌های عمومی قدیمی در `~/.gemini/config/skills/` دست‌نخورده باقی مانده‌اند:
  - `frontend-agent-rules/`
  - `backend-agent-rules/`
  - `graphify/`
- نام‌گذاری اسکیل‌های جدید با پیشوند متمایز `xengin-*` تضمین می‌کند که هیچ تداخل اولویتی (Precedence Collision) در رجیستری ابزارها به وجود نیاید.

---

## ۷. اسناد ایجاد شده برای بازبینی شما در پروژه

تمامی مستندات زیر در مخزن پروژه ایجاد شده و با Git نسخه‌بندی شده‌اند:

1. [**`README.md`**](../README.md): راهنمای کامل نصب، معماری و کاربرد.
2. [**`CHANGELOG.md`**](../CHANGELOG.md): مستندات ثبت نسخه و لیست امکانات.
3. [**`docs/architecture.md`**](architecture.md): دیاگرام‌های معماری لایه‌ای، خط‌لوله تصمیم‌گیری و ارکستراسیون مهارت‌ها.
4. [**`docs/production-workflow-guide.md`**](production-workflow-guide.md): راهنمای عملیاتی و روزمره کاربر برای کار با هوش مصنوعی بدون نیاز به واژگان فنی.
5. [**`docs/migration-guide.md`**](migration-guide.md): راهنمای گام‌به‌گام مهاجرت ایمن و نگهداری اسکیل‌های قبلی تا پایان دوره پایلوت.
6. [**`tests/smoke-test.md`**](../tests/smoke-test.md): چک‌لیست و دستورات آزمون دود برای راستی‌آزمایی دوره‌ای.
