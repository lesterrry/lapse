function getRandomColor() {
    const hue = Math.floor(Math.random() * 360);
    const color = 'hsl(' + hue + ', 80%, 85%)';
    return color;
}

function getDaysInYear(year) {
    return isLeap(year) ? 366 : 365;
}

function isLeap(year) {
    return year % 400 === 0 || (year % 100 !== 0 && year % 4 === 0);
}

function getDayOfYear(date) {
    var start = new Date(date.getFullYear(), 0, 0);
    var diff = (date - start) + ((start.getTimezoneOffset() - date.getTimezoneOffset()) * 60 * 1000);
    var oneDay = 1000 * 60 * 60 * 24;
    var day = Math.floor(diff / oneDay);
    return day;
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
    
    console.log(sortedPeriods);

    let consecutivePeriods = [];
    let lastDay = 1;

    for (const period of sortedPeriods) {
        const startYear = getYear(period.start);
        const endYear = getYear(period.end);
        
        const startDay = startYear === initialYear ? getDayOfYear(period.start) : 1;
        const endDay = endYear === initialYear ? getDayOfYear(period.end) : daysInYear;

        if (startDay - 1 > lastDay) {
            console.info(`filling period ${lastDay}-${startDay}`);

            const range = startDay - lastDay;

            consecutivePeriods.push({ days: range, title: '', color: 'rgba(0,0,0,0)' });

            lastDay += range;
        }

        console.info(`adding period ${startDay}-${endDay}`);

        const range = endDay - startDay;

        consecutivePeriods.push({ days: range + lastDay > daysInYear ? daysInYear - range : range, title: period.title });

        lastDay += range;
    }

    if (lastDay < daysInYear) {
        consecutivePeriods.push({ days: daysInYear - lastDay + 1, title: '', color: 'rgba(0,0,0,0)' });
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
