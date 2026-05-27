-- ================================================================
-- 第一章 SQL 練習：輝達地區營收分析
-- 資料來源：NVIDIA 10-K 年報（FY2022–FY2026）
-- 交叉驗證：stockdividendscreener.com / bullfincher.io
-- ================================================================
-- T-SQL 與標準 SQL 的主要差異（本檔案涉及的）：
-- 1. 不支援 CREATE TABLE IF NOT EXISTS → 用 IF OBJECT_ID 判斷
-- 2. FLOAT 轉型用 CAST(x AS FLOAT) 或直接乘以 1.0
-- 3. ROUND 第二個參數是小數位數（與標準 SQL 相同）
-- 4. LIMIT → 改用 TOP 或 FETCH NEXT ... ROWS ONLY
-- 5. 字串用單引號（與標準 SQL 相同）
-- ================================================================


-- ── 建立資料表（若已存在則先刪除）─────────────────────────────

DROP TABLE IF EXISTS nvidia_revenue;

CREATE TABLE nvidia_revenue (
    id INT auto_increment,
    fiscal_year    VARCHAR(50),
    year_end_date  DATE,
    region         VARCHAR(50) not null,
    revenue_m      DECIMAL(10,0),   -- 實際營收（百萬美元）
    total_rev_m    DECIMAL(10,0),   -- 當年總營收（百萬美元）
    method         VARCHAR(50) not null,-- 'billing' 或 'hq'
   PRIMARY KEY (id),
    CONSTRAINT unique_revenue_group UNIQUE (fiscal_year, method, region)
);


-- ── 插入真實數據（來源：NVIDIA 10-K 年報） ──────────────────────
-- FY2016（Billing Location）總營收 5,010$M
INSERT INTO nvidia_revenue 
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2016','2016-01-31','United States',   643, 5010, 'billing'),
('FY2016','2016-01-31','Taiwan',         1912, 5010, 'billing'),
('FY2016','2016-01-31','China',           806, 5010, 'billing'),
('FY2016','2016-01-31','Other',          1649, 5010, 'billing');

-- FY2017（Billing Location）總營收 $6910M
INSERT INTO nvidia_revenue 
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2017','2017-01-29','United States',   904, 6910, 'billing'),
('FY2017','2017-01-29','Taiwan',         2546, 6910, 'billing'),
('FY2017','2017-01-29','China',          1305, 6910, 'billing'),
('FY2017','2017-01-29','Other',          2155, 6910, 'billing');


-- FY2018（Billing Location）總營收 9,714$M
INSERT INTO nvidia_revenue 
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2018','2018-01-28','United States',  1274, 9714, 'billing'),
('FY2018','2018-01-28','Taiwan',         2991, 9714, 'billing'),
('FY2018','2018-01-28','China',          1896, 9714, 'billing'),
('FY2018','2018-01-28','Other',          3553, 9714, 'billing');


-- FY2019（Billing Location）總營收 11,716$M
INSERT INTO nvidia_revenue 
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2019','2019-01-27','United States',  1506, 11716, 'billing'),
('FY2019','2019-01-27','Taiwan',         3360, 11716, 'billing'),
('FY2019','2019-01-27','China',          2801, 11716, 'billing'),
('FY2019','2019-01-27','Other',          4049, 11716, 'billing');

-- FY2020（Billing Location）總營收 10,918$M
INSERT INTO nvidia_revenue 
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2020','2020-01-26','United States',   886, 10918, 'billing'),
('FY2020','2020-01-26','Taiwan',         3025, 10918, 'billing'),
('FY2020','2020-01-26','China',          2731, 10918, 'billing'),
('FY2020','2020-01-26','Other',          4276, 10918, 'billing');

-- FY2021（Billing Location）總營收 16,675$M
INSERT INTO nvidia_revenue 
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2021','2021-01-31','United States',  3214, 16675, 'billing'),
('FY2021','2021-01-31','Taiwan',         4531, 16675, 'billing'),
('FY2021','2021-01-31','China',          3886, 16675, 'billing'),
('FY2021','2021-01-31','Other',          5044, 16675, 'billing');

-- FY2022（Billing Location）總營收 $26,914M
INSERT INTO nvidia_revenue
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2022','2022-01-30','United States',  4349, 26914, 'billing'),
('FY2022','2022-01-30','Taiwan',         8544, 26914, 'billing'),
('FY2022','2022-01-30','China',          7111, 26914, 'billing'),
('FY2022','2022-01-30','Other',          6910, 26914, 'billing');

-- FY2023（Billing Location）總營收 $26,974M
INSERT INTO nvidia_revenue 
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2023','2023-01-29','United States',  8292, 26974, 'billing'),
('FY2023','2023-01-29','Taiwan',         6986, 26974, 'billing'),
('FY2023','2023-01-29','China',          5785, 26974, 'billing'),
('FY2023','2023-01-29','Other',          5911, 26974, 'billing');

-- FY2024（Billing Location）總營收 $60,922M
INSERT INTO nvidia_revenue 
  (fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2024','2024-01-28','United States', 31533, 60922, 'billing'),
('FY2024','2024-01-28','Taiwan',        14912, 60922, 'billing'),
('FY2024','2024-01-28','China',         12330, 60922, 'billing'),
('FY2024','2024-01-28','Other',          2147, 60922, 'billing');

-- FY2025（Billing Location）總營收 $130,497M
INSERT INTO nvidia_revenue 
(fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2025','2025-01-26','United States', 77482, 130497, 'billing'),
('FY2025','2025-01-26','Taiwan',        23600, 130497, 'billing'),
('FY2025','2025-01-26','China',         25048, 130497, 'billing'),
('FY2025','2025-01-26','Other',          4367, 130497, 'billing');

-- FY2026（HQ Location）總營收 $215,938M
-- 注意：FY2026 起改採 HQ Location，與前幾年不可直接比較
-- 台灣數字偏高原因：台積電/鴻海等台灣公司幫美國客戶下單
-- 輝達估算其中 76% 最終流向美國/歐洲終端客戶
INSERT INTO nvidia_revenue 
(fiscal_year, year_end_date, region, revenue_m, total_rev_m, method)
VALUES
('FY2026','2026-01-25','United States', 149617, 215938, 'hq'),
('FY2026','2026-01-25','Taiwan',         42345, 215938, 'hq'),
('FY2026','2026-01-25','China',          19677, 215938, 'hq'),
('FY2026','2026-01-25','Other',           4299, 215938, 'hq');


select
fiscal_year,
region,
year_end_date,
revenue_m
from nvidia_revenue
order by region,fiscal_year;
-- ================================================================
-- 練習 1：SELECT + WHERE
-- 問題：中國歷年營收與占比
-- ================================================================

SELECT
    fiscal_year,
    year_end_date,
    region,
    revenue_m,
    total_rev_m,
    ROUND(revenue_m * 1.0 / total_rev_m * 100, 1) AS pct,
    -- T-SQL 重點：整數相除會無條件捨去，乘以 1.0 強制轉浮點數
    method
FROM nvidia_revenue
WHERE region = 'China'
ORDER BY fiscal_year;

-- 預期洞察：
-- 中國絕對值：$806M → $19,677M
-- 中國占比：    16.1% →     9.1%（從四分之一降到個位數）
-- 結論：「中國業務萎縮」要看占比，不能只看絕對值


-- ================================================================
-- 練習 2：GROUP BY + CASE WHEN（Pivot 技巧）
-- 問題：每年各地區營收水平展開，同時顯示中國占比
-- ================================================================

SELECT
    fiscal_year,
    method,
    MAX(total_rev_m)                                    AS total_rev_m,
    SUM(CASE WHEN region = 'United States'
             THEN revenue_m ELSE 0 END)                 AS us_rev_m,
    SUM(CASE WHEN region = 'Taiwan'
             THEN revenue_m ELSE 0 END)                 AS tw_rev_m,
    SUM(CASE WHEN region = 'China'
             THEN revenue_m ELSE 0 END)                 AS china_rev_m,
	SUM(CASE WHEN region = 'other'
             THEN revenue_m ELSE 0 END)                 AS other_rev_m,
    ROUND(
        SUM(CASE WHEN region = 'China'
                 THEN revenue_m ELSE 0 END) * 1.0
        / NULLIF (MAX(total_rev_m),0) * 100, 1
    )                                                   AS china_pct
FROM nvidia_revenue
GROUP BY fiscal_year, method
ORDER BY fiscal_year;

-- 用 MAX(total_rev_m) 取出該年度的總營收值


-- ================================================================
-- 練習 3：HAVING
-- 問題：哪些財年的中國業務超過 $10,000M？
-- ================================================================

SELECT
    fiscal_year,
    SUM(CASE WHEN region = 'China'
             THEN revenue_m ELSE 0 END) AS china_rev_m
FROM nvidia_revenue
GROUP BY fiscal_year
HAVING SUM(CASE WHEN region = 'China'
                THEN revenue_m ELSE 0 END) > 10000
ORDER BY china_rev_m DESC;

-- 記憶口訣：WHERE 過濾原始行，HAVING 過濾分組後的結果


-- ================================================================
-- 練習 4：TOP
-- 問題：FY2026 營收最高的前 3 個地區
-- ================================================================

SELECT distinct                    -- T-SQL 用 TOP，標準 SQL 用 LIMIT
    region,
    revenue_m,
    ROUND(revenue_m * 1.0 / total_rev_m * 100, 1) AS pct
FROM nvidia_revenue
WHERE fiscal_year = 'FY2026'
ORDER BY revenue_m DESC
limit 3;



-- ================================================================
-- 練習 5：子查詢 + JOIN + CASE WHEN（綜合題）
-- 問題：FY2022 vs FY2025（同為 Billing 方法）成長倍數比較
-- ================================================================

SELECT
    r25.region,
    r22.revenue_m                                           AS fy2022_rev_m,
    r25.revenue_m                                           AS fy2025_rev_m,
    ROUND(r25.revenue_m * 1.0 / r22.revenue_m, 2)          AS growth_multiple,
    CASE
        WHEN r25.revenue_m * 1.0 / r22.revenue_m >= 10
             THEN N'高速成長 (>10x)'
        WHEN r25.revenue_m * 1.0 / r22.revenue_m >= 3
             THEN N'強勁成長 (3-10x)'
        WHEN r25.revenue_m * 1.0 / r22.revenue_m >= 1
             THEN N'持平成長 (1-3x)'
        ELSE      N'萎縮 (<1x)'
    END                                                     AS growth_label
FROM
    (SELECT region, revenue_m
     FROM nvidia_revenue
     WHERE fiscal_year = 'FY2025') AS r25
JOIN
    (SELECT region, revenue_m
     FROM nvidia_revenue
     WHERE fiscal_year = 'FY2022') AS r22
    ON r25.region = r22.region
ORDER BY growth_multiple DESC;


-- 預期結果：
-- United States → 21.3x → 高速成長
-- Taiwan        →  4.2x → 強勁成長
-- China         →  2.4x → 持平成長（絕對值有成長，占比卻大跌）
-- Other         →  1.3x → 持平成長


-- ================================================================
-- 練習 6：計算方法陷阱（分析師必知）
-- 問題：為什麼 FY2026 台灣數字看起來異常高？
-- ================================================================

-- 查看 FY2025 vs FY2026 台灣數字的跳升
SELECT
    fiscal_year,
    region,
    revenue_m,
    ROUND(revenue_m * 1.0 / total_rev_m * 100, 1) AS pct,
    method
FROM nvidia_revenue
WHERE region = 'Taiwan'
ORDER BY fiscal_year;

-- 你會看到台灣從 FY2025 的 $24,847M 跳到 FY2026 的 $42,350M
-- 這不代表台灣突然買了這麼多 GPU
-- 原因：FY2026 改採 HQ Location 計算
-- 台積電/鴻海總部在台灣，但他們幫美國客戶採購的 GPU 都算進台灣
-- 輝達 10-K 特別說明：台灣客戶中 76% 最終流向美國/歐洲

-- 核心教訓：數字本身不說謊，但必須理解「這個數字是怎麼定義的」


