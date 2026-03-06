# App Schedule Management

This project handles scheduling automatic app launches on Android. Doing this in the background is tricky because of Android's strict battery optimizations and permission rules. Here is how the project handles these issues:

## Background Execution Challenges -

### Q: What if background execution doesn't work perfectly?

**How I tackle complexity:** 
I successfully implemented the feature to open an app at the exact scheduled time when my app is open in the foreground. However, Android often blocks apps from automatically opening another app while running in the background or when killed. To handle this complexity, I added a reliable fallback. If the app is in the background, it triggers a high-priority local notification instead.

**How I communicate challenges:**
Instead of failing silently, the notification alerts the user that it's time for their scheduled task. Tapping the notification opens the app manually. This gracefully handles the OS limitation while making sure the user gets a reminder and never misses their schedule.

### Q: What if I can't get exact alarm permissions on Android 13+?

**How I research unknowns:**
I looked into the Android 13 (API 33) changes and found that Google no longer grants the `SCHEDULE_EXACT_ALARM` permission by default. Without it, the system batches background tasks together, meaning alarms might get delayed instead of running exactly on time.

**How I architect solutions:**
I separated the core logic into two clear modules: `alarm_services.dart` and `notification_services.dart`. When setting the alarm, I use settings like `exact: true` and `wakeup: true` to get the most accurate timing possible. We also explicitly request the `POST_NOTIFICATIONS` permission from the user. Because of this separated architecture, even if the exact alarm permission is missing and the background task gets delayed, the notification service smoothly steps in to finish the job as soon as the system allows it.
