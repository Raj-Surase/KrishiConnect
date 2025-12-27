// user_home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:krishi_connect/core/utils/app_sizes.dart';
import 'package:krishi_connect/repo/model/weather.dart';
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

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Text(provider.error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (weather == null) return const SizedBox();

    final days = weather.forecast.forecastDays;
    final selectedDay = days[provider.selectedDayIndex];

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hello 👋", style: context.textTheme.headlineSmall),
          10.verticalSpace,

          Text(
            "📍 ${weather.location.name}, ${weather.location.region}",
            style: context.textTheme.titleMedium,
          ),

          20.verticalSpace,

          _DateSelector(days),

          20.verticalSpace,

          _DaySummary(selectedDay),

          16.verticalSpace,

          _AstroInfo(selectedDay),

          20.verticalSpace,

          _HourlyForecast(selectedDay),
        ],
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  final List<dynamic> days;
  const _DateSelector(this.days);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => 8.horizontalSpace,
        itemBuilder: (context, index) {
          final date = days[index].date;

          final selected = provider.selectedDayIndex == index;

          return ChoiceChip(
            label: Text(date.substring(5)), // MM-DD
            selected: selected,
            onSelected: (_) => provider.selectDay(index),
          );
        },
      ),
    );
  }
}

class _DaySummary extends StatelessWidget {
  final dynamic day;
  const _DaySummary(this.day);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
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
              Text("🌡 Max: ${day.day.maxtempC}°C"),
              Text("🌡 Min: ${day.day.mintempC}°C"),
              Text("💧 Humidity: ${day.day.avghumidity}%"),
              Text("☀️ UV Index: ${day.day.uv}"),
              Text("🌧 Rain chance: ${day.day.dailyChanceOfRain}%"),
            ],
          ),
        ),
      ),
    );
  }
}

class _HourlyForecast extends StatelessWidget {
  final ForecastDay day;
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
                    Text("🌡 ${hour.temp}°C"), // ✅ FIXED
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

class _AstroInfo extends StatelessWidget {
  final dynamic day;
  const _AstroInfo(this.day);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CommonContainer(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("🌅 Sunrise: ${day.astro.sunrise}"),
              Text("🌇 Sunset: ${day.astro.sunset}"),
              Text("🌙 Moon Phase: ${day.astro.moonPhase}"),
            ],
          ),
        ),
      ),
    );
  }
}
