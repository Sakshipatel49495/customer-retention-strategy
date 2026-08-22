# Decoding Customer Value: A SQL-Driven Retention Strategy

**Can a D2C fashion brand tell its genuinely loyal customers apart from its discount-driven ones — using only transactional data, with no loyalty score, no churn label, and no timestamps?**

This project builds that answer from scratch: a full customer intelligence pipeline (Python → SQL → Power BI) for a direct-to-consumer fashion brand with ~3,900 customers, ending in a two-page playbook a founding team could act on immediately.

---

## TL;DR — Key Findings

- **Value tier is the only real driver of promotional dependency.** High Value customers are 21% of the base but generate **44% of revenue**, and **53% are promo-dependent** vs. 33% for Low Value customers — an 18-point spread.
- **The most promo-dependent segment is also the *least* risky.** Retention risk moves inversely with value tier (1.54% High Risk in Low Value → 0.46% in High Value) — a counterintuitive result that directly shapes the retention recommendation.
- **Age, product category, satisfaction, and payment method were all tested and ruled out** as segmentation variables — each showed under 3% relative variation across customer tiers. This is reported explicitly rather than hidden, since knowing what *doesn't* matter is as valuable as knowing what does.
- **A data-quality finding changed the feature design mid-project:** `promo_code_used` and `discount_applied` turned out to be perfectly correlated (zero disagreement across 3,900 customers), which meant a planned 3-level "promo sensitivity" feature had a structurally empty middle category. Caught via a crosstab, documented, and corrected to a 2-level feature instead of silently shipping a broken chart.
- **Feature weights were stress-tested, not just asserted.** The Loyalty Score formula (70% purchase history / 30% promo dependency) was re-run at 60/40 and 80/20; resulting customer segments stayed stable across all three, supporting the weighting choice with evidence rather than intuition.

---

## Business Problem

The brand has three years of transactional and behavioral data but no structured way to act on it. Specifically, it cannot answer:
- Who are the customers likely to still be buying two years from now?
- Is the promo/discount program building loyalty, or just attracting one-time bargain hunters?
- What does the brand's best customer actually look like — and how can it acquire more of them?

**Problem Statement:** Using only transactional and behavioral data, identify what the brand's most valuable customers look like, measure how much current revenue depends on promotions, and build a data-backed retention strategy that reduces discount dependency without hurting sales.

**The core constraint:** the dataset has no loyalty score, no churn label, and no timestamps. Every concept used here — loyalty, dependency, retention risk — had to be *constructed and validated from available variables*, not assumed.

---

## Objectives

- Engineer customer-level metrics for value, loyalty, promo dependency, and retention risk — each with a stated rationale, not just a computed number
- Build at least two competing definitions of "loyalty," test both, and justify the one selected
- Answer the brand's core segmentation questions using SQL
- Design a founder-facing Power BI dashboard that surfaces the finding, not just the data
- Translate findings into two actionable outputs: a promotional sunset plan and an ideal customer profile

---

## Tools Used

| Tool | Purpose |
|------|---------|
| Python (pandas, scikit-learn) | Data cleaning, feature engineering, weight sensitivity testing |
| SQL | Customer segmentation & business-question queries |
| Power BI | Founder-facing interactive dashboard |
| GitHub | Project hosting & documentation |

---

## Repository Structure

```plaintext
data/           -> raw & cleaned datasets
notebooks/      -> Python notebooks (cleaning + feature engineering)
sql/            -> SQL segmentation & business-question queries
powerbi/        -> Power BI dashboard (.pbix)
report/         -> executive summary, technical report, retention playbook
```

---

## Project Workflow

```text
Raw Dataset
      │
      ▼
Data Cleaning
      │
      ▼
Feature Engineering  ──►  Weight sensitivity testing, data-quality checks
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

## Project Components

### Python — Feature Engineering
Cleaned the raw dataset and engineered eight customer-level features (Value Score, Dependency Score, Loyalty Segment, Retention Risk, Promo Sensitivity, and others), each documented with its business rationale in the notebook. Two features were built with competing definitions and tested against each other before one was selected — see `notebooks/` for the full weighting rationale and sensitivity analysis.

### SQL — Segmentation & Business Analysis
Answered the brand's core segmentation questions directly in SQL: what separates high-value from low-value customers, which geographies show organic demand vs. discount-driven volume, and which categories are associated with tenure vs. one-time purchases. Queries are commented with the business insight each one produces, not just the logic.

### Power BI — Founder-Facing Dashboard
Built an interactive dashboard designed to be readable by a non-technical founding team in under a minute:
- **Revenue Contribution by Value Tier** — where revenue actually comes from
- **Promo Dependency by Value Tier** — the single strongest segmentation finding
- **Retention Risk by Value Tier** — the counterintuitive result that de-risks the recommendation
- **Regional Spending Patterns** — encoded by spend and promo dependency, not just location
- **Purchase History by Category** — an honest "not a differentiator" finding, shown rather than hidden
- Ideal Customer Profile and Promotional Sunset Plan callouts, stated directly on the dashboard

<!-- Add updated dashboard screenshot here -->

### Business Playbook
A concise, two-page deliverable containing:
- **Promotional Sunset Plan** — named segment, trigger condition, phased 90-day rollout, and the exact metric that would trigger a rollback
- **Ideal Customer Profile** — a data-backed description specific enough to act on for targeting decisions today

<!-- Add updated playbook screenshots here -->

---

## Skills Demonstrated

- Translating an ambiguous, open-ended business problem into testable, quantified metrics
- Validating engineered features via sensitivity analysis rather than asserting arbitrary weights
- Catching and correcting a data-quality issue mid-pipeline (redundant correlated columns) instead of shipping a broken downstream metric
- Distinguishing genuine findings from chart/axis artifacts before drawing conclusions
- Designing visuals around the audience (founder-facing dashboard vs. technical report) rather than one-size-fits-all charts
- Reporting null results (category, satisfaction, age, payment method) as explicitly as positive ones

---

## Future Improvements

- Build a Customer Lifetime Value (CLV) model to extend beyond the current cross-sectional snapshot
- Add churn prediction using machine learning once true timestamped/repeat-transaction data is available
- Automate dashboard refresh with a live data source
- Track retention outcomes over time to validate the sunset plan's actual impact post-rollout

---

## Contact

**Sakshi Patel**
- LinkedIn: [linkedin.com/in/sakshi-patel-252605358](https://www.linkedin.com/in/sakshi-patel-252605358)
- Email: sakshipatel49495@gmail.com
