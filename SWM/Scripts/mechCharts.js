const ctx = document.getElementById("cityWise");
const inputData = document.getElementById('MainContent_hiddenFielddataTableJsonCityWise').value;

const zoneWise = document.getElementById("zoneWise");
const zoneWiseValue = document.getElementById("MainContent_hiddenFielddataTableJsonZoneWise").value;

const cityRoute = document.getElementById("cityWiseRoute");
const cityRouteValue = document.getElementById('MainContent_hiddenFielddataTableJsonCityWiseRouteCovered').value;

const zoneWiseRoute = document.getElementById("zoneWiseRoute");
const zoneWiseRouteValue = document.getElementById("MainContent_hiddenFielddataTableJsonZoneWiseRouteCovered").value;

function createPieChart(chartData, canvasID) {
    const pieChartData = JSON.parse(chartData);
    console.log('City Wise', pieChartData);
    let total = null;
    let cover = null;
    let uncover = null;
    let partiallyCover = null;

    pieChartData.forEach((data) => {
        total = data.Total;
        cover = data.Cover;
        uncover = data.UnCover;
        partiallyCover = data.PartiallyCover;
    })

    let labels = ['Cover', 'Uncover', 'Partially Cover'];
    let datasetData = [cover, uncover, partiallyCover];

    new Chart(canvasID, {
        type: "pie",
        data: {
            labels: labels,
            datasets: [
                {
                    //label: "City Wise",
                    data: datasetData,
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
                    text: `Total ${total}`,
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

function createLineChart(chartData, canvasID) {
    const lineChartData = JSON.parse(chartData);
    console.log('Zone Wise Data', lineChartData);
    const labels = [];
    const cover = [];
    const uncover = [];
    const partiallyCover = [];

    lineChartData.forEach(data => {
        labels.push(`${data.Zone}`);
        cover.push(data.Cover);
        uncover.push(data.UnCover);
        partiallyCover.push(data.PartiallyCover);
    });

    const totalCover = cover.reduce((total, value) => total + value, 0);
    const totalUncover = uncover.reduce((total, value) => total + value, 0);
    const totalPartiallyCover = partiallyCover.reduce((a, c) => a + c, 0);
    const total = totalCover + totalUncover + totalPartiallyCover;


    new Chart(canvasID, {
        type: "bar",
        data: {
            labels: labels,
            datasets: [
                {
                    label: "Cover",
                    data: cover,
                    backgroundColor: "rgba(54, 162, 235, 1)",
                },
                {
                    label: "Uncover",
                    data: uncover,
                    backgroundColor: "rgba(255, 99, 132, 1)",
                },
                {
                    label: "PartiallyCover",
                    data: partiallyCover,
                    backgroundColor: "rgba(255, 159, 64, 1)",
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
                                if (label.text === 'Cover') {
                                    label.text = `Cover: ${totalCover}`;
                                } else if (label.text === 'Uncover') {
                                    label.text = `Uncover: ${totalUncover}`;
                                } else if (label.text === 'PartiallyCover') {
                                    label.text = `PartiallyCover ${totalPartiallyCover}`;
                                }
                            });
                            return labels;
                        },
                    },
                },
                title: {
                    display: true,
                    text: `Total ${total}`,
                    font: {
                        weight: 'bold',
                        size: 20,
                    },
                    position: 'bottom',
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

function createPieChartRoute(chartData, canvasID) {
    const pieChartData = JSON.parse(chartData);
    console.log('City Wise Route Covered (KM)', pieChartData);

    let total = null;
    let cover = null;
    let uncover = null;

    pieChartData.forEach((data) => {
        total = data.Total;
        cover = data.Cover;
        uncover = data.UnCover;
    })

    let labels = ['Cover', 'Uncover'];
    let datasetData = [cover, uncover];

    new Chart(canvasID, {
        type: "pie",
        data: {
            labels: labels,
            datasets: [
                {
                    //label: "City Wise",
                    data: datasetData,
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
                                        text: label + ": " + value + ' KM',
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
                    text: `Total ${total} KM`,
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

function createLineChartRoute(chartData, canvasID) {
    const lineChartData = JSON.parse(chartData);
    console.log('Zone Wise Route Covered(KM)', lineChartData);
    const labels = [];
    const cover = [];
    const uncover = [];

    lineChartData.forEach(data => {
        labels.push(`${data.Zone}`);
        cover.push(data.Cover);
        uncover.push(data.UnCover);
    });

    const totalCover = cover.reduce((total, value) => total + value, 0);
    const totalUncover = uncover.reduce((total, value) => total + value, 0);
    /*    const totalPartiallyCover = partiallyCover.reduce((a, c) => a + c, 0);*/
    const total = totalCover + totalUncover;


    new Chart(canvasID, {
        type: "bar",
        data: {
            labels: labels,
            datasets: [
                {
                    label: "Cover",
                    data: cover,
                    backgroundColor: "rgba(54, 162, 235, 1)",
                },
                {
                    label: "Uncover",
                    data: uncover,
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
                                if (label.text === 'Cover') {
                                    label.text = `Cover: ${totalCover} KM`;
                                } else if (label.text === 'Uncover') {
                                    label.text = `Uncover: ${totalUncover} KM`;
                                }
                            });
                            return labels;
                        },
                    },
                },
                title: {
                    display: true,
                    text: `Total ${total} KM`,
                    font: {
                        weight: 'bold',
                        size: 20,
                    },
                    position: 'bottom',
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

if (inputData) {
    createPieChart(inputData, ctx);
}

if (zoneWiseValue) {
    createLineChart(zoneWiseValue, zoneWise);
}

if (cityRouteValue) {
    createPieChartRoute(cityRouteValue, cityRoute);
}

if (zoneWiseRouteValue) {
    createLineChartRoute(zoneWiseRouteValue, zoneWiseRoute);
}

function limitNumber(number) {
    return Math.ceil(number);
}
