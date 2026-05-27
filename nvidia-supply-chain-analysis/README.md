[README.md](https://github.com/user-attachments/files/28301340/README.md)
# AI Compute Supply Chain Analysis
## 輝達去中國化的數據軌跡（FY2016–FY2026）

## Research Question / 研究問題

這份分析從一個直覺問題開始：
**中國禁止購入輝達晶片，會對輝達的業務發展造成嚴重衝擊嗎？**

直覺上以為答案是「會」，但數據說的是另一個故事。

---

## Key Findings / 主要發現

**Finding 1 — NVIDIA de-China-ized earlier than the market realized**  
China revenue share peaked at 26.4% in FY2022, then declined to 9.1% by FY2026.  
Export controls did not cause the shift — they accelerated one already underway.

**Finding 2 — Absolute growth vs share collapse: the same number tells two stories**  
China revenue grew 2.8x in absolute terms (FY2022→FY2026).  
Yet the US grew 34x over the same period.  
Reading only one metric leads to the wrong conclusion.

**Finding 3 — The gap was filled by demand structure change, not a single market**  
North American CSPs (Microsoft, Meta, Google, Amazon) drove Blackwell demand.  
FY27 Q1 revenue hit a record $81.6B; Q2 guidance of $91.0B explicitly excludes China DC revenue.

**Finding 4 — HBM4 is the only real bottleneck; TSMC packaging is ready**  
TSMC CoWoS yield exceeded 98% — packaging constraint resolved.  
SK Hynix & Micron HBM4 certification delays cut Rubin volume from 2M to 1.5M units (-25%).  
One chip's story links four countries and five companies.

---

## Scope / 分析範圍

| Layer | Player | Core Question |
|-------|--------|---------------|
| Demand | NVIDIA | Who filled the China gap? |
| Foundry | TSMC | Is 2nm + CoWoS ready? |
| Memory | SK Hynix / CXMT | When does HBM4 unblock? Who does China DRAM threaten? |
| Equipment | Lam Research | What does Taiwan localization signal? |
| Competition | Google / AWS | Training vs inference: how fast is ASIC catching up? |

---

## Tools & Workflow / 工具與工作流程

| Step | Tool | Output |
|------|------|--------|
| Data collection | NVIDIA 10-K (investor.nvidia.com) | `nvidia_revenue_fy2016_2026.csv` |
| Data validation | MySQL | Cross-checked against original 10-K figures |
| SQL analysis | MySQL | Aggregation, pivot, subquery, CASE WHEN |
| Visualization | Python / Google Colab (matplotlib) | 3 charts |
| Report draft | Claude (analysis framework) | Content structure |
| Report design | Gemini + manual layout | Final PDF |

> **Note on workflow:** Each tool was chosen for what it does best.  
> Data integrity verified directly from primary source (NVIDIA official filings).  
> FY2017 data corrected after cross-referencing original 10-K — initial estimate was wrong.

---

## Data Note / 數據說明

| Period | Method | Note |
|--------|--------|------|
| FY2016–FY2025 | Billing Location | Revenue attributed to customer billing address |
| FY2026 onwards | HQ Location | Revenue attributed to customer headquarters |

⚠️ FY2026 Taiwan figure ($42.3B) reflects TSMC/Foxconn procurement on behalf of US clients.  
~76% ultimately flows to US/European end customers (per NVIDIA 10-K disclosure).  
**Not directly comparable across the methodology change.**

---

## Project Structure / 專案結構

```
nvidia-supply-chain-analysis/
├── README.md
├── data/
│   └── nvidia_revenue_fy2016_2026.csv     # NVIDIA 10-K, FY2016–FY2026
├── sql/
│   └── ch1_sql_practice_mysql.sql         # MySQL queries (Ch.1)
├── python/
│   ├── ch1_nvidia_analysis_en.ipynb       # Google Colab notebook
│   └── charts/
│       ├── ch1_chart1_region_pct.png      # Revenue share stacked bar
│       ├── ch1_chart2_region_abs.png      # Absolute revenue line chart
│       └── ch1_chart3_china_pct.png       # China share trend bar
└── report/
    └── AI_算力供應鏈分析報告_優化版.pdf   # Full analysis report (ZH/EN)
```

---

## Data Sources / 資料來源

- **NVIDIA 10-K Annual Reports FY2016–FY2026**  
  [investor.nvidia.com](https://investor.nvidia.com) / [SEC EDGAR](https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=NVDA&type=10-K)
- NVIDIA FY2027 Q1 Earnings Call (2026.05.21)
- KeyBanc Capital Markets — John Vinh, Rubin volume estimate
- Morgan Stanley AI chip performance analysis (2026.05.19)
- TechNews Taiwan / Business Next (2026.05.17–05.26)

---

## About This Project / 關於這份分析

這份報告從每日科技新聞閱讀出發，練習用數據驗證直覺、用圖表說清楚複雜的供應鏈故事。  
目標是建立「看到新聞數字，自動問下一個問題」的分析師思維。

**Research period:** 2026.05.17 — ongoing  
**Next:** HBM competitive landscape (SK Hynix / Samsung / Micron), ASIC inference cost model

---

## What I Learned / 這份分析教會我的事

- 同一個數字可以說兩種故事——中國業務「絕對值成長但占比萎縮」是最好的例子
- 數據來源比工具更重要——FY2017 數字錯了，直到對照原始 10-K 才發現
- 財報架構的改變本身就是訊號——輝達把遊戲部門併入邊緣運算不只是格式問題
- 供應鏈是系統，不是個別公司——HBM4 延遲牽動輝達、台積電、科林研發同時受影響
