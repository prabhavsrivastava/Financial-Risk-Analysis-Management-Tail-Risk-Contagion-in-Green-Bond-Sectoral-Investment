### README: Steps for Generating Results for Tail Risk Contagion Analysis

This document outlines the steps undertaken to analyze tail risk contagion in international energy markets, as detailed in the project report.

---

#### **1. Data Collection**
- Daily closing prices of international energy markets and sector indices were collected.
- Data sources included the MSCI Green Bond Index, S&P Green Bond Index, Energy SPNY, and other related indices.

#### **2. Data Preparation**
- Time-series data was processed using logarithmic difference transformations to calculate returns.
- Statistical tests (ADF, Jarque-Bera) confirmed stationarity and non-normality of the data.

#### **3. Methodology Implementation**
- **ARMA-EGARCH-Skew-t Model**: Captured asymmetric and leptokurtic characteristics of volatility.
- **Quantile Time-Frequency Spillover Framework**: Used to model tail risk contagion under varying market states and time horizons.

#### **4. Statistical and Econometric Analysis**
- **Quantile Regression**: Explored spillovers at different quantiles (e.g., 0.05, 0.95).
- **Variance Decomposition**: Assessed contributions of directional and total spillovers between indices.

#### **5. Visualization**
- Graphical representations of spillover networks across time and frequency domains were generated.
- Heatmaps and spillover indices visualized tail risk propagation patterns.

#### **6. Interpretation of Results**
- Static and dynamic spillovers were analyzed to identify net exporters and importers of systemic risk.
- Frequency-domain analysis highlighted short-, medium-, and long-term spillover effects.

#### **7. Documentation**
- Key findings were summarized in tables and figures to emphasize the interconnectedness of green bonds and traditional energy markets.

#### **8. Conclusion and Recommendations**
- Policy implications were drawn to enhance market resilience and sustainable finance integration.
- Suggestions for future research included investigating emerging technologies' impact on spillovers.

---

