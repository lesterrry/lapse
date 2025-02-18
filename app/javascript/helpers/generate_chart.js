function getRandomColor() {
    return '#6290C8';

    const c = ['#E0E447', '#33473B', '#334FD7', '#D8E6FF', '#FFC7EC', '#FF42C0', '#C7B0FE', '#431D58', '#F74A39', '#FFCCC8'];
    return c[Math.floor(Math.random() * c.length)];
}

function getDaysInYear(year) {
    return isLeap(year) ? 365 : 364;
}

function isLeap(year) {
    return year % 400 === 0 || (year % 100 !== 0 && year % 4 === 0);
}

function getDayOfYear(date) {
    const startOfYear = new Date(date.getFullYear(), 0, 1);
    const currentDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
    const diffInMilliseconds = currentDate - startOfYear;
    const dayOfYear = Math.floor(diffInMilliseconds / (1000 * 60 * 60 * 24));

    return dayOfYear;
}

function getYear(date) {
    return date.getFullYear();
}

export function generateChart(periods, selectedYear) {
    console.info('generating chart...');

    if (!periods.length) return null;

    periods = periods.map(i => {
        i.start = new Date(i.start);
        i.end = new Date(i.end);

        return i;
    });

    const sortedPeriods = periods.sort((a, b) => {
        return a.start - b.start;
    });

    const initialYear = selectedYear ?? sortedPeriods[0].start.getFullYear();
    const daysInYear = getDaysInYear(initialYear);

    console.info(`initial year: ${initialYear}, ${daysInYear} days`);

    let consecutivePeriods = [];
    let lastDay = -1;

    for (const period of sortedPeriods) {
        const startYear = getYear(period.start);
        const endYear = getYear(period.end);

        const startDay = startYear === initialYear ? getDayOfYear(period.start) : 0;
        const endDay = endYear === initialYear ? getDayOfYear(period.end) : daysInYear;

        if (startDay - 1 > lastDay) {
            console.info(`filling period ${lastDay}-${startDay}`);

            const range = startDay - lastDay;

            consecutivePeriods.push({ days: range, title: '', color: 'rgba(0, 0, 0, 0.02)' });

            lastDay += range;
        } else if (lastDay === -1) {
            lastDay = 0;
        }

        console.info(`adding period ${startDay}-${endDay}`);

        const range = endDay - startDay;

        const remaining = range + lastDay > daysInYear ? daysInYear - range : range;

        consecutivePeriods.push({ days: remaining, title: period.title, color: period.color_hex });

        lastDay += remaining;
    }

    if (lastDay < daysInYear - 1) {
        console.info(`filling rest of year ${lastDay}-${daysInYear}`);
        consecutivePeriods.push({ days: daysInYear - lastDay + 1, title: '', color: 'rgba(0, 0, 0, 0.02)' });
    }

    console.info(`total: ${consecutivePeriods.reduce((s, i) => s + i.days, 0)}`);

    return {
        labels: consecutivePeriods.map(i => i.title),
        datasets: [{
            data: consecutivePeriods.map(i => i.days),
            backgroundColor: consecutivePeriods.map(i => i.color || getRandomColor()),
        }]
    }
}
