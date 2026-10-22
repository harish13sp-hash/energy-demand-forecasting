import pandas as pd

file_path = r"C:\Users\ELCOT\Documents\Power BI Desktop\energy_demand_cleaned_2024_2025.xlsx"

df = pd.read_excel(file_path)

print(df.shape)
print(df.head())

df["timestamp"] = pd.to_datetime(df["timestamp"])

df = df.sort_values("timestamp").reset_index(drop=True)

print(df[["timestamp", "consumption_mw"]].head())


time_difference = df["timestamp"].diff()

print(time_difference.value_counts().head())


train = df[df["timestamp"] < "2025-05-01"].copy()
test = df[df["timestamp"] >= "2025-05-01"].copy()

print("Training data:", train.shape)
print("Testing data:", test.shape)

print("\nTraining period:")
print(train["timestamp"].min(), "to", train["timestamp"].max())

print("\nTesting period:")
print(test["timestamp"].min(), "to", test["timestamp"].max())

from sklearn.ensemble import RandomForestRegressor


for data in [train, test]:
    data["hour"] = data["timestamp"].dt.hour
    data["day_of_week"] = data["timestamp"].dt.dayofweek
    data["month"] = data["timestamp"].dt.month
    data["day_of_month"] = data["timestamp"].dt.day
    data["is_weekend"] = data["timestamp"].dt.dayofweek >= 5



features = [
    "hour",
    "day_of_week",
    "month",
    "day_of_month",
    "is_weekend",
    "temperature"
]

X_train = train[features]
y_train = train["consumption_mw"]

X_test = test[features]
y_test = test["consumption_mw"]


model = RandomForestRegressor(
    n_estimators=100,
    random_state=42,
    n_jobs=-1
)


model.fit(X_train, y_train)

print("Random Forest model trained successfully!")

print("Starting Random Forest training...")
model.fit(X_train, y_train)
print("Random Forest model trained successfully!")


test["forecast_consumption_mw"] = model.predict(X_test)

print("\nForecast generated successfully!")

print(
    test[
        ["timestamp", "consumption_mw", "forecast_consumption_mw"]
    ].head(10)
)


from sklearn.metrics import mean_absolute_error, mean_squared_error
import numpy as np

mae = mean_absolute_error(
    y_test,
    test["forecast_consumption_mw"]
)

rmse = np.sqrt(
    mean_squared_error(
        y_test,
        test["forecast_consumption_mw"]
    )
)

mape = np.mean(
    np.abs(
        (y_test - test["forecast_consumption_mw"]) / y_test
    )
) * 100

print("\n--- Model Accuracy ---")
print(f"MAE  : {mae:.2f} MW")
print(f"RMSE : {rmse:.2f} MW")
print(f"MAPE : {mape:.2f}%")



forecast_output = test[
    ["timestamp", "consumption_mw", "forecast_consumption_mw"]
].copy()

forecast_output = forecast_output.rename(
    columns={
        "consumption_mw": "actual_consumption_mw",
        "forecast_consumption_mw": "forecast_consumption_mw"
    }
)

output_file = r"C:\Users\ELCOT\Desktop\python.py\energy_forecast_results.csv"

forecast_output.to_csv(output_file, index=False)

print("\nForecast CSV created successfully!")
print("File:", output_file)