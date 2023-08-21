/* Count the number of appointments for each day in the given dataset: */
SELECT 
    AppointmentDay, COUNT(*) AS Total_appointment
FROM
    patients
GROUP BY AppointmentDay
ORDER BY AppointmentDay;

/* Calculate the average number of appointments(Set to nearest whole number)
 per day in the given dataset */
SELECT 
    ROUND(AVG(Total_appointment)) AS average_appointments_per_day
FROM
    (SELECT 
        AppointmentDay, COUNT(*) AS Total_appointment
    FROM
        patients
    GROUP BY AppointmentDay) AS daily_appointments;

/* Find the day with the highest number of appointments in the given dataset */
SELECT 
    MAX(Total_appointment) AS highest_appointments
FROM
    (SELECT 
        AppointmentDay, COUNT(*) AS Total_appointment
    FROM
        patients
    GROUP BY AppointmentDay) AS daily_appointments;

/* Calculate the monthly average number of appointments in the given dataset */
SELECT 
    month, AVG(monthly_Appointments)
FROM
    (SELECT 
        DATE_FORMAT(AppointmentDay, '%y-%m') AS month,
            COUNT(*) AS monthly_Appointments
    FROM
        patients
    GROUP BY month) AS average_monthly_appointments
GROUP BY month;


/* Find the month with the highest number of appointments in the given dataset. */
SELECT 
    month, MAX(monthly_Appointments) AS highest_appointment
FROM
    (SELECT 
        DATE_FORMAT(AppointmentDay, '%y-%m') AS month,
            COUNT(*) AS monthly_Appointments
    FROM
        patients
    GROUP BY month) AS monthly_appointments
GROUP BY month
ORDER BY highest_appointment DESC
LIMIT 1;

/* Calculate the weekly average number of appointments in the given dataset. */
SELECT 
    Year, Week, AVG(appointments_per_week)
FROM
    (SELECT 
        YEAR(AppointmentDay) AS Year,
            WEEK(AppointmentDay) AS Week,
            COUNT(*) AS appointments_per_week
    FROM
        patients
    GROUP BY Year, Week) AS weekly_appointments
GROUP BY Year , Week;

/*Find the week with the highest number of appointments in the given dataset.*/
SELECT 
    Year,
    Week,
    MAX(appointments_per_week) AS highest_weekly_appointments
FROM
    (SELECT 
        YEAR(AppointmentDay) AS Year,
            WEEK(AppointmentDay) AS Week,
            COUNT(*) AS appointments_per_week
    FROM
        patients
    GROUP BY Year , Week) AS weekly_appointments
GROUP BY Year , Week
ORDER BY highest_weekly_appointments DESC
LIMIT 1;

/* Distribution of appointments based on gender in the dataset */
SELECT 
    Gender, COUNT(*) AS Appointment_count
FROM
    patients
GROUP BY Gender;

/* Calculate the number of appointments per weekday in the given dataset */
SELECT 
    DAYNAME(AppointmentDay) AS Weekday,
    COUNT(*) AS appointment_count
FROM
    patients
GROUP BY Weekday;

/* Average time between scheduling and the appointment day in the given dataset */
SELECT 
    CEIL(AVG(TIMESTAMPDIFF(DAY,
                ScheduledDay,
                AppointmentDay))) AS avg_day_difference
FROM
    patients;