# VerdiTech — Data Models
> Project: VerdiTech | Last Updated: June 27, 2026

- **Plant model** (id, type, plantingDate, currentStage, environment, predictions)
- **EnvironmentProfile model** (sunlight, water, soil, season)
- **DayPrediction model** (date, predictedStage, healthStatus, issues)
- **DailyLog model** (id, plantId, date, sunlightScore, waterScore, soilScore, note)
- **Recommendation model** (category, priority, message, forStage)
- **Enums**: PlantType, GrowthStage, SunlightLevel, WaterLevel, SoilQuality, Season, HealthStatus, Priority

