const DEFAULT_COLOR = '#6290C8';
const EMPTY_PERIOD_COLOR = 'rgba(0, 0, 0, 0.02)';
const MS_PER_DAY = 1000 * 60 * 60 * 24;

/**
 * Returns the number of days in a given year
 * @param {number} year - The year to check
 * @return {number} - 366 for leap years, 365 for non-leap years
 */
function getDaysInYear(year) {
    return isLeap(year) ? 366 : 365;
}

/**
 * Checks if a year is a leap year
 * @param {number} year - The year to check
 * @return {boolean} - True if leap year, false otherwise
 */
function isLeap(year) {
    return year % 400 === 0 || (year % 100 !== 0 && year % 4 === 0);
}

/**
 * Gets the day of the year (0-365/366) for a given date
 * @param {Date} date - The date to check
 * @return {number} - The day of the year (0-based)
 */
function getDayOfYear(date) {
    const startOfYear = new Date(date.getFullYear(), 0, 0);
    return Math.floor((date - startOfYear) / MS_PER_DAY);
}

/**
 * Generates chart data for representing periods in a doughnut chart
 * @param {Array} periods - Array of period objects with start and end dates
 * @param {number} selectedYear - Optional year to filter periods by
 * @return {Object|null} - Chart.js compatible data object or null if no periods
 */
export function generateChart(periods, selectedYear) {
    console.info('generating chart...');

    if (!periods || !periods.length) return null;

    // Convert string dates to Date objects
    const periodsWithDates = periods.map(period => ({
        ...period,
        start: new Date(period.start),
        end: new Date(period.end)
    }));

    // Sort periods by start date
    const sortedPeriods = periodsWithDates.sort((a, b) => a.start - b.start);

    // Determine the year to use (selected or from first period)
    const initialYear = selectedYear ?? sortedPeriods[0].start.getFullYear();
    const daysInYear = getDaysInYear(initialYear);

    console.info(`initial year: ${initialYear}, ${daysInYear} days`);

    const consecutivePeriods = [];
    let lastDay = 0;

    // Process each period
    for (const period of sortedPeriods) {
        if (period.start >= period.end) {
            console.info(`skipping broken period`);

            continue;
        }

        const startYear = period.start.getFullYear();
        const endYear = period.end.getFullYear();

        // Calculate start and end days within the target year
        const startDay = startYear === initialYear ? getDayOfYear(period.start) : 0;
        const endDay = endYear === initialYear ? getDayOfYear(period.end) : daysInYear;

        // If there's a gap before this period, add an empty period
        if (startDay > lastDay) {
            const gapDays = startDay - lastDay;
            console.info(`filling gap ${lastDay}-${startDay} (${gapDays} days)`);
            consecutivePeriods.push({
                days: gapDays,
                title: '',
                color: EMPTY_PERIOD_COLOR
            });
        }

        // Calculate days for this period
        const periodDays = Math.min(endDay - startDay, daysInYear - lastDay);
        
        if (periodDays > 0) {
            console.info(`adding period ${startDay}-${endDay} (${periodDays} days)`);
            consecutivePeriods.push({
                days: periodDays,
                title: period.title,
                color: period.color_hex
            });
            
            lastDay = startDay + periodDays;
        }
    }

    // If there's remaining space in the year, add a final empty period
    if (lastDay < daysInYear) {
        const remainingDays = daysInYear - lastDay;
        console.info(`filling rest of year ${lastDay}-${daysInYear} (${remainingDays} days)`);
        consecutivePeriods.push({
            days: remainingDays,
            title: '',
            color: EMPTY_PERIOD_COLOR
        });
    }

    // Verify total days
    const totalDays = consecutivePeriods.reduce((sum, period) => sum + period.days, 0);
    console.info(`total days: ${totalDays} (should be ${daysInYear})`);

    // Return chart.js compatible data structure
    return {
        labels: consecutivePeriods.map(period => period.title),
        datasets: [{
            data: consecutivePeriods.map(period => period.days),
            backgroundColor: consecutivePeriods.map(period => period.color || DEFAULT_COLOR),
        }]
    };
}
