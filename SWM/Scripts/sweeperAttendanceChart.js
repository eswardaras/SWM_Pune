
/* CITY WISE CHART*/
const cityWise = document.getElementById("cityWise");
var cityWiseAttendance = document.getElementById('MainContent_hiddenFielddataTableJsonTotal').value;


/* ZONE WISE CHART*/
const zoneWise = document.getElementById("zoneWise");
var zoneWiseAttendance = document.getElementById('MainContent_hiddenFielddataTableJsonZoneWise').value;

//new Chart(ctx, {
//    type: "pie",
//    data: {
//        labels: ["Present", "Absent"],
//        datasets: [
//            {
//                data: [totalAttendanceData[0].Present, totalAttendanceData[0].Absent],
//                borderWidth: 1,
//            },
//        ],
//    },
//    options: {
//        responsive: true,
//        scales: {
//            y: {
//                stacked: true,
//                display: false,
//            },
//        },
//        plugins: {
//            legend: {
//                position: "right",
//                labels: {
//                    generateLabels: function (chart) {
//                        const labels = Chart.defaults.plugins.legend.labels.generateLabels(chart);
//                        labels.forEach(label => {
//                            if (label.text === 'Present') {
//                                label.text = `Present: ${totalAttendanceData[0].Present}`;
//                            } else if (label.text === 'Absent') {
//                                label.text = `Absent: ${totalAttendanceData[0].Absent}`;
//                            }
//                        });
//                        return labels;
//                    },
//                },
//            },
//            title: {
//                display: true,
//                text: `Total ${totalAttendanceData[0].Total}`,
//                font: {
//                    weight: "bold",
//                    size: 20,
//                },
//                position: 'bottom',
//            },
//        },
//    },
//});

function createPieChart(chartData) {
    const totalAttendanceData = JSON.parse(chartData);
    const cityWisePresent = totalAttendanceData[0].Present;
    const cityWiseAbsent = totalAttendanceData[0].Absent;
    const cityValues = [cityWisePresent, cityWiseAbsent];
    var cityLabels = ["Present", "Absent"];


    new Chart(cityWise, {
        type: "pie",
        data: {
            labels: cityLabels,
            datasets: [
                {
                    //label: "City Wise",
                    data: cityValues,
                    borderWidth: 1,
                },
            ],
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "right",
                    labels: {
                        generateLabels: function (chart) {
                            var data = chart.data;
                            if (data.labels.length && data.datasets.length) {
                                return data.labels.map(function (label, i) {
                                    var dataset = data.datasets[0];
                                    var value = dataset.data[i];
                                    return {
                                        text: label + ": " + value,
                                        fillStyle: dataset.backgroundColor[i],
                                        hidden: isNaN(dataset.data[i]), // Hide labels with NaN values (if any)
                                        index: i,
                                    };
                                });
                            }
                            return [];
                        },
                    },
                },
                title: {
                    display: true,
                    text: `Total ${cityWisePresent + cityWiseAbsent}`,
                    font: {
                        weight: 'bold',
                        size: 20,
                    },
                    position: 'bottom',
                },
            },
        },
    });
}

function createLineChart(chartData) {
    const zoneWiseAttendanceData = JSON.parse(chartData);

    const labels = [];
    const presentData = [];
    const absentData = [];
    let ultimateTotalZoneWise = null;

    zoneWiseAttendanceData.forEach(zoneData => {
        labels.push(`Zone ${zoneData.Zone}`);
        presentData.push(zoneData.Present);
        absentData.push(zoneData.Absent);
    });

    const totalPresent = presentData.reduce((total, value) => total + value, 0);
    const totalAbsent = absentData.reduce((total, value) => total + value, 0);
    const totalZoneWise = totalPresent + totalAbsent;

    new Chart(zoneWise, {
        type: "bar",
        data: {
            labels: labels,
            datasets: [
                {
                    label: "Present",
                    data: presentData,
                    backgroundColor: "rgba(54, 162, 235, 1)",
                },
                {
                    label: "Absent",
                    data: absentData,
                    backgroundColor: "rgba(255, 99, 132, 1)",
                },
            ],
        },
        options: {
            indexAxis: "y",
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        generateLabels: function (chart) {
                            const labels = Chart.defaults.plugins.legend.labels.generateLabels(chart);
                            labels.forEach(label => {
                                if (label.text === 'Present') {
                                    label.text = `Present: ${totalPresent}`;
                                } else if (label.text === 'Absent') {
                                    label.text = `Absent: ${totalAbsent}`;
                                }
                            });
                            return labels;
                        },
                    },
                },
                title: {
                    display: true,
                    text: `Total ${totalZoneWise}`,
                    font: {
                        weight: 'bold',
                        size: 20,
                    },
                    position: 'top',
                    padding: {
                        top: 20,
                    },
                },
            },
            scales: {
                x: {
                    stacked: true,
                    barPercentage: 0.7,
                    categoryPercentage: 0.8,
                },
                y: {
                    stacked: true,
                },
            },
            responsive: true,
            layout: {
                padding: {
                    left: 10,
                    right: 10,
                },
            },
            barPercentage: 0.6,
            categoryPercentage: 0.8,
        },
    });

}

if (cityWiseAttendance) {
    createPieChart(cityWiseAttendance);
}

if (zoneWiseAttendance) {
    createLineChart(zoneWiseAttendance);
}