// user_home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/utils/app_sizes.dart';
import 'package:provider/provider.dart';

import 'package:krishi_connect/provider/weather_provider.dart';
import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final weather = provider.weather;
    final day = weather?.forecast.forecastDays.first;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Greeting(),

          20.verticalSpace,

          if (provider.loading)
            const Center(child: CircularProgressIndicator()),

          if (weather != null && day != null) ...[
            _Location(weather.location.name, weather.location.region),

            16.verticalSpace,

            _TodaySummary(day),

            16.verticalSpace,

            _AstroInfo(day),

            20.verticalSpace,

            _HourlyForecast(day),
          ],

          if (provider.error != null)
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}

/* ───────────────── GREETING ───────────────── */

class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Hello 👋", style: context.textTheme.headlineSmall);
  }
}

/* ───────────────── LOCATION ───────────────── */

class _Location extends StatelessWidget {
  final String city;
  final String region;

  const _Location(this.city, this.region);

  @override
  Widget build(BuildContext context) {
    return Text("📍 $city, $region", style: context.textTheme.titleMedium);
  }
}

/* ───────────────── TODAY SUMMARY ───────────────── */

class _TodaySummary extends StatelessWidget {
  final dynamic day;
  const _TodaySummary(this.day);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes(context).width,
      child: CommonContainer(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🌤 ${day.day.condition.text}",
                style: context.textTheme.titleLarge,
              ),
              8.verticalSpace,
              Text(
                "🌡 Max: ${day.day.maxTemp}°C  |  Min: ${day.day.minTemp}°C",
              ),
              Text("💧 Humidity: ${day.day.humidity}%"),
              Text("☀️ UV Index: ${day.day.uv}"),
            ],
          ),
        ),
      ),
    );
  }
}

/* ───────────────── ASTRO INFO ───────────────── */

class _AstroInfo extends StatelessWidget {
  final dynamic day;
  const _AstroInfo(this.day);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes(context).width,
      child: CommonContainer(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("🌅 Sunrise: ${day.astro.sunrise}"),
              Text("🌇 Sunset: ${day.astro.sunset}"),
              Text("🌙 Moon: ${day.astro.moonPhase}"),
            ],
          ),
        ),
      ),
    );
  }
}

/* ───────────────── HOURLY FORECAST ───────────────── */

class _HourlyForecast extends StatelessWidget {
  final dynamic day;
  const _HourlyForecast(this.day);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("⏰ Hourly Forecast", style: context.textTheme.titleMedium),
        10.verticalSpace,

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: day.hours.length,
          separatorBuilder: (_, __) => 8.verticalSpace,
          itemBuilder: (context, index) {
            final hour = day.hours[index];
            return CommonContainer(
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("🕒 ${hour.time.split(' ').last}"),
                    Text("🌡 ${hour.temp}°C"),
                    Text("💨 ${hour.windKph} km/h"),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
