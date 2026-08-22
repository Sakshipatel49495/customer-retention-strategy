<div align="center">

# 🛍️ Decoding Customer Value
### A SQL-Driven Retention Strategy for a D2C Fashion Brand

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Data](https://img.shields.io/badge/Customers-3%2C900-lightgrey)

</div>

> **Can you tell a genuinely loyal customer apart from a discount-driven one — with no loyalty score, no churn label, and no timestamps in your data?**
> This project builds that answer from raw transactions alone: a full pipeline from Python feature engineering → SQL segmentation → a founder-facing Power BI dashboard → a two-page retention playbook a real team could act on tomorrow.

---

## 📋 Contents
- [Key Findings](#-key-findings-tldr)
- [What Makes This Different](#-what-makes-this-different)
- [Business Problem](#-business-problem)
- [At a Glance](#-at-a-glance)
- [Tools](#-tools-used)
- [Workflow](#-project-workflow)
- [Project Components](#-project-components)
- [Skills Demonstrated](#-skills-demonstrated)
- [Future Improvements](#-future-improvements)
- [Contact](#-contact)

---

## 🔑 Key Findings (TL;DR)

| Finding | Evidence |
|---|---|
| **Value tier drives promo dependency — nothing else does** | High Value = 21% of customers → **44% of revenue**, and **53% are promo-dependent** vs. 33% for Low Value |
| **The most promo-dependent segment is the *least* risky** | Retention risk falls as value tier rises — 1.54% → 0.46% High Risk, the opposite of what most teams would assume |
| **Four "obvious" variables turned out not to matter** | Age, category, satisfaction, and payment method each showed **under 3% variation** across tiers — tested and explicitly ruled out, not ignored |
| **A silent data bug was caught before it shaped a recommendation** | `promo_code_used` and `discount_applied` were found to be perfectly correlated (0 disagreements / 3,900 customers) via a crosstab — corrected before it broke a downstream feature |
| **Feature weights were stress-tested, not asserted** | Loyalty Score (70/30 weighting) re-run at 60/40 and 80/20 — segment assignments stayed stable, confirming the choice with evidence |

---

## 🎯 What Makes This Different

Most portfolio projects stop at "here's a dashboard." This one is built the way a real analytics engagement is graded:

- **Every metric has a stated rationale** — not just a formula, but *why that weighting, why that threshold*, documented alongside the code.
- **Null results are reported, not hidden.** Category and satisfaction showing no effect is treated as a real finding, because knowing what *doesn't* move the needle is as useful to a business as knowing what does.
- **A data-quality issue was caught mid-analysis and fixed transparently** rather than silently patched — the kind of judgment call that separates a checklist project from real analytical thinking.
- **The dashboard is designed for its actual audience** — a non-technical founding team — not for maximum chart variety.

---

## 💼 Business Problem

The brand has years of transactional data but no structured retention strategy. It can't answer:
- Who's likely to still be buying two years from now?
- Is the promo/discount program building loyalty, or just attracting bargain hunters?
- What does the best customer actually look like — and how do you get more of them?

**Constraint:** no loyalty score, no churn label, no timestamps. Every concept — loyalty, dependency, retention risk — had to be **constructed and validated from raw variables**, not assumed.

---

## 📊 At a Glance

| | |
|---|---|
| **Customers analyzed** | 3,900 |
| **Features engineered** | 8, each with documented rationale |
| **Competing definitions tested** | 2 (Loyalty Score, Value Score) |
| **Segmentation variables ruled out** | 4 (age, category, satisfaction, payment method) |
| **Final deliverables** | Interactive dashboard + 2-page retention playbook |

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| **Python** (pandas, scikit-learn) | Data cleaning, feature engineering, weight sensitivity testing |
| **SQL** | Customer segmentation & business-question queries |
| **Power BI** | Founder-facing interactive dashboard |
| **GitHub** | Project hosting & documentation |

<details>
<summary><b>📁 Repository structure</b></summary>

```plaintext
data/           -> raw & cleaned datasets
notebooks/      -> Python notebooks (cleaning + feature engineering)
sql/            -> SQL segmentation & business-question queries
powerbi/        -> Power BI dashboard (.pbix)
report/         -> executive summary, technical report, retention playbook
```
</details>

---

## 🔄 Project Workflow

```text
Raw Dataset
      │
      ▼
Data Cleaning
      │
      ▼
Feature Engineering  ──►  Weight sensitivity testing + data-quality checks
      │
      ▼
SQL Business Analysis
      │
      ▼
Power BI Dashboard  ──►  Founder-facing, evidence-first design
      │
      ▼
Retention Playbook  ──►  Promotional Sunset Plan + Ideal Customer Profile
```

---

## 🧩 Project Components

### Python — Feature Engineering
Engineered eight customer-level features (Value Score, Dependency Score, Loyalty Segment, Retention Risk, Promo Sensitivity, and others), each documented with its business rationale. Two features were built with **competing definitions**, tested, and one selected with justification — full weighting rationale and sensitivity analysis in `notebooks/`.

### SQL — Segmentation & Business Analysis
Answered the brand's core segmentation questions directly: what separates high-value from low-value customers, which geographies show organic demand vs. discount-driven volume, and which categories are entry-point vs. retention categories. Every query is commented with the business insight it produces.

### Power BI — Founder-Facing Dashboard
Built to be read by a non-technical founding team in under a minute:
- **Revenue Contribution by Value Tier** — where revenue actually comes from
- **Promo Dependency by Value Tier** — the single strongest segmentation finding
- **Retention Risk by Value Tier** — the counterintuitive result that de-risks the recommendation
- **Regional Spending Patterns** — encoded by spend and promo dependency, not just location
- **Purchase History by Category** — an honest "not a differentiator" finding, shown rather than hidden
- Ideal Customer Profile and Promotional Sunset Plan, stated directly on the page

<!-- Add updated dashboard screenshot here -->

### Business Playbook
A concise, two-page deliverable:
- **Promotional Sunset Plan** — named segment, trigger condition, phased 90-day rollout, and the exact metric that triggers a rollback
- **Ideal Customer Profile** — specific enough to act on for targeting decisions today

<!-- Add updated playbook screenshots here -->

---

## 🧠 Skills Demonstrated

- Translating an ambiguous business problem into testable, quantified metrics
- Validating engineered features via sensitivity analysis instead of asserting arbitrary weights
- Catching and correcting a data-quality issue mid-pipeline before it shaped a wrong conclusion
- Distinguishing real findings from chart/axis artifacts before drawing conclusions
- Designing visuals around the actual audience, not for maximum chart variety
- Reporting null results as explicitly as positive ones

---

## 🚀 Future Improvements

- Build a Customer Lifetime Value (CLV) model beyond the current cross-sectional snapshot
- Add churn prediction once true timestamped/repeat-transaction data is available
- Automate dashboard refresh with a live data source
- Track retention outcomes over time to validate the sunset plan's real-world impact

---

## 📬 Contact

<div align="center">

**Sakshi Patel**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sakshi-patel-252605358)
[![Email](https://img.shields.io/badge/Email-D14836?style=flat&logo=gmail&logoColor=white)](mailto:sakshipatel49495@gmail.com)

</div>
