const rampNameDropdown = document.getElementById("rampNameDropdown");
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");

const dateSpan1 = document.getElementById("dateSpan1");
const dateSpan2 = document.getElementById("dateSpan2");
const dateSpan3 = document.getElementById("dateSpan3");
const dateSpan4 = document.getElementById("dateSpan4");
const dateSpan5 = document.getElementById("dateSpan5");
const dateSpan6 = document.getElementById("dateSpan6");

const btnSearch = document.getElementById("btnSearch");

const table1 = document.getElementById("table1");
const table2 = document.getElementById("table2");
const table3 = document.getElementById("table3");
const table4 = document.getElementById("table4");
const table5 = document.getElementById("table5");
const table6 = document.getElementById("table6");

let selectedStartDate = startDate.value;
let selectedEndDate = endDate.value;

const rampParameters = {
  mode: 1,
};

const rampWiseWeightReportParameters = {
  mode: 2,
  rampid: 1,
  date1: selectedStartDate,
  date2: selectedEndDate,
};

// AJAX requests

const populateRampNameDropdown = async () => {
  try {
    const rampRequestData = {
      storedProcedureName: "proc_RampDashboard",
      parameters: JSON.stringify(rampParameters),
    };

    const response = await axios.post(commonApi, rampRequestData, {
      headers: {
        "Content-Type": "application/json",
      },
    });

    const rampMasterList =
      response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

    const rampList = JSON.parse(rampMasterList);

    for (const ramp of rampList) {
      const option = document.createElement("option");
      option.value = ramp.RMM_ID;
      option.text = ramp.RMM_NAME;
      rampNameDropdown.appendChild(option);
      rampNameDropdown.fstdropdown.rebind();
    }
  } catch (error) {
    console.error("Error fetching data:", error);
  }
};

const populateTable1 = async () => {
  try {
    dateSpan1.innerHTML = `Ramp Wise Report:- From ${formatDate(
      rampWiseWeightReportParameters.date1
    )} To ${formatDate(rampWiseWeightReportParameters.date2)}`;

    const tbody = table1.querySelector("tbody");
    tbody.innerHTML = `<tr>
                          <td colspan="10" class='text-danger'>Loading...</td>
                       </tr>`;

    const rampWiseWeightReportRequestData = {
      storedProcedureName: "proc_IncomingTransaction",
      parameters: JSON.stringify(rampWiseWeightReportParameters),
    };

    const response = await axios.post(
      commonApi,
      rampWiseWeightReportRequestData
    );
    console.log(response);

    tbody.innerHTML = "";
    if (!response.data.CommonMethodResult.CommonReportMasterList) {
      tbody.innerHTML = `<tr>
                               <td colspan="10" class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
      return;
    }

    const commonReportMasterList =
      response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

    let tableData = JSON.parse(commonReportMasterList);
    console.log("TABLEdATA", tableData);

    setDataTable(table1);

    for (const data of tableData) {
      const tr = document.createElement("tr");
      tr.innerHTML = `<tr>
            <td>${data["Depot No."]}</td>
            <td>${data["Entry Type"]}</td>
            <td>${data["RFID Entry Type"]}</td>
            <td>${data["Vehicle Type"]}</td>
            <td>${
              data["Tare Weight In (MT)"] === null
                ? " "
                : data["Tare Weight In (MT)"]
            }</td>
            <td>${
              data["Gross  Weight In (MT)"] === null
                ? " "
                : data["Gross  Weight In (MT)"]
            }</td>
            <td>${data["Net  Weight In (MT)"]}</td>
            <td>${data["Date Time"]}</td>
            <td>${data.Unloading}</td>
            <td>${data["Garbage Type"]}</td>
            <td>${data["Ward Office Name."]}</td>
        </tr>`;

      table1.querySelector("tbody").appendChild(tr);
    }
  } catch (error) {
    console.error("An error occurred while populating the table:", error);
  }
};

const populateTable2 = async () => {
  try {
    dateSpan2.innerHTML = `Incoming Weight Bifurcation:- From ${formatDate(
      rampWiseWeightReportParameters.date1
    )} To ${formatDate(rampWiseWeightReportParameters.date2)}`;

    const tbody = table2.querySelector("tbody");
    tbody.innerHTML = `<tr>
                          <td colspan="3" class='text-danger'>Loading...</td>
                       </tr>`;

    const rampWiseWeightReportRequestData = {
      storedProcedureName: "proc_IncomingTransaction",
      parameters: JSON.stringify(rampWiseWeightReportParameters),
    };

    const response = await axios.post(
      commonApi,
      rampWiseWeightReportRequestData
    );
    console.log(response);

    tbody.innerHTML = "";
    if (!response.data.CommonMethodResult.CommonReportMasterList) {
      tbody.innerHTML = `<tr>
                               <td colspan="3" class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
      return;
    }

    const commonReportMasterList =
      response.data.CommonMethodResult.CommonReportMasterList[4].ReturnValue;

    let tableData = JSON.parse(commonReportMasterList);
    console.log("TABLEdATA 2nd", tableData);

    setDataTable(table2);

    for (const data of tableData) {
      const tr = document.createElement("tr");
      tr.innerHTML = `<tr>
            <td>${data["Garbage Type"]}</td>
            <td>${data["Net  Weight In (MT)"]}</td>
        </tr>`;

      table2.querySelector("tbody").appendChild(tr);
    }
  } catch (error) {
    console.error("An error occurred while populating the table:", error);
  }
};

const populateTable3 = async () => {
  try {
    dateSpan3.innerHTML = `Outgoing Weight Bifurcation:- From ${formatDate(
      rampWiseWeightReportParameters.date1
    )} To ${formatDate(rampWiseWeightReportParameters.date2)}`;

    const tbody = table3.querySelector("tbody");
    tbody.innerHTML = `<tr>
                          <td colspan="3" class='text-danger'>Loading...</td>
                       </tr>`;

    const rampWiseWeightReportRequestData = {
      storedProcedureName: "proc_IncomingTransaction",
      parameters: JSON.stringify(rampWiseWeightReportParameters),
    };

    const response = await axios.post(
      commonApi,
      rampWiseWeightReportRequestData
    );
    console.log(response);

    tbody.innerHTML = "";
    if (!response.data.CommonMethodResult.CommonReportMasterList) {
      tbody.innerHTML = `<tr>
                               <td colspan="3" class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
      return;
    }

    const commonReportMasterList =
      response.data.CommonMethodResult.CommonReportMasterList[5].ReturnValue;

    let tableData = JSON.parse(commonReportMasterList);
    console.log("Outgoing Weight Bifurcation", tableData);

    setDataTable(table3);

    for (const data of tableData) {
      const tr = document.createElement("tr");
      tr.innerHTML = `<tr>
            <td>${data["Garbage Type"]}</td>
            <td>${data["Net  Weight In (MT)"]}</td>
        </tr>`;

      table3.querySelector("tbody").appendChild(tr);
    }
  } catch (error) {
    console.error("An error occurred while populating the table:", error);
  }
};

const populateTable4 = async () => {
  try {
    dateSpan4.innerHTML = `Outgoing Weight Bifurcation Plant Wise:- From ${formatDate(
      rampWiseWeightReportParameters.date1
    )} To ${formatDate(rampWiseWeightReportParameters.date2)}`;

    const tbody = table4.querySelector("tbody");
    tbody.innerHTML = `<tr>
                          <td colspan="10" class='text-danger'>Loading...</td>
                       </tr>`;

    const rampWiseWeightReportRequestData = {
      storedProcedureName: "proc_IncomingTransaction",
      parameters: JSON.stringify(rampWiseWeightReportParameters),
    };

    const response = await axios.post(
      commonApi,
      rampWiseWeightReportRequestData
    );
    console.log(response);

    tbody.innerHTML = "";
    if (!response.data.CommonMethodResult.CommonReportMasterList) {
      tbody.innerHTML = `<tr>
                               <td colspan="10" class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
      return;
    }

    const commonReportMasterList =
      response.data.CommonMethodResult.CommonReportMasterList[9].ReturnValue;

    let tableData = JSON.parse(commonReportMasterList);
    console.log("TABLEdATA", tableData);

    setDataTable(table4);

    for (const data of tableData) {
      const tr = document.createElement("tr");
      tr.innerHTML = `<tr>
            <td>${data["PLANT_NAME"]}</td>
            <td>${data["TOTAL_TRIPS"]}</td>
            <td>${data["TOTAL_WEIGHT"]}</td>
        </tr>`;

      table4.querySelector("tbody").appendChild(tr);
    }
  } catch (error) {
    console.error("An error occurred while populating the table:", error);
  }
};

const populateTable5 = async () => {
  try {
    dateSpan5.innerHTML = `Ramp Wise (Incomming Details):- From ${formatDate(
      rampWiseWeightReportParameters.date1
    )} To ${formatDate(rampWiseWeightReportParameters.date2)}`;

    tbody = table5.querySelector("tbody");
    tbody.innerHTML = `<tr>
                          <td colspan="10" class='text-danger'>Loading...</td>
                       </tr>`;

    const rampWiseWeightReportRequestData = {
      storedProcedureName: "proc_IncomingTransaction",
      parameters: JSON.stringify(rampWiseWeightReportParameters),
    };

    const response = await axios.post(
      commonApi,
      rampWiseWeightReportRequestData
    );
    console.log(response);

    tbody.innerHTML = "";
    if (!response.data.CommonMethodResult.CommonReportMasterList) {
      tbody.innerHTML = `<tr>
                               <td colspan="10" class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
      return;
    }

    const commonReportMasterList =
      response.data.CommonMethodResult.CommonReportMasterList[6].ReturnValue;

    let tableData = JSON.parse(commonReportMasterList);
    console.log("TABLEdATA", tableData);

    setDataTable(table5);

    for (const data of tableData) {
      const tr = document.createElement("tr");
      tr.innerHTML = `<tr>
      <td>${data["Depot No."]}</td>
      <td>${data["Entry Type"]}</td>
      <td>${data["RFID Entry Type"]}</td>
      <td>${data["Vehicle Type"]}</td>
      <td>${
        data["Tare Weight In (MT)"] === null ? " " : data["Tare Weight In (MT)"]
      }</td>
      <td>${
        data["Gross  Weight In (MT)"] === null
          ? " "
          : data["Gross  Weight In (MT)"]
      }</td>
      <td>${
        data["Net  Weight In (MT)"] === null ? " " : data["Net  Weight In (MT)"]
      }</td>
      <td>${data["Date Time"]}</td>
      <td>${data.Unloading}</td>
      <td>${data["Garbage Type"]}</td>
      <td>${data["Ward Office Name."]}</td>
        </tr>`;

      table5.querySelector("tbody").appendChild(tr);
    }
  } catch (error) {
    console.error("An error occurred while populating the table:", error);
  }
};

const populateTable6 = async () => {
  try {
    dateSpan6.innerHTML = `Ramp Wise (Outgoing Details):- From ${formatDate(
      rampWiseWeightReportParameters.date1
    )} To ${formatDate(rampWiseWeightReportParameters.date2)}`;

    const tbody = table6.querySelector("tbody");
    tbody.innerHTML = `<tr>
                          <td colspan="10" class='text-danger'>Loading...</td>
                       </tr>`;

    const rampWiseWeightReportRequestData = {
      storedProcedureName: "proc_IncomingTransaction",
      parameters: JSON.stringify(rampWiseWeightReportParameters),
    };

    const response = await axios.post(
      commonApi,
      rampWiseWeightReportRequestData
    );
    console.log(response);

    tbody.innerHTML = "";
    if (!response.data.CommonMethodResult.CommonReportMasterList) {
      tbody.innerHTML = `<tr>
                               <td colspan="10" class='text-danger'>
                                  <i class="fa-solid fa-triangle-exclamation mx-1"></i>
                                  No Data Found
                                </td>
                            </tr>`;
      return;
    }

    const commonReportMasterList =
      response.data.CommonMethodResult.CommonReportMasterList[7].ReturnValue;

    let tableData = JSON.parse(commonReportMasterList);
    console.log("TABLEdATA", tableData);

    setDataTable(table6);

    for (const data of tableData) {
      const tr = document.createElement("tr");
      tr.innerHTML = `<tr>
                       <td>${data["Depot No."]}</td>
                       <td>${data["Entry Type"]}</td>
                       <td>${data["RFID Entry Type"]}</td>
                       <td>${data["Vehicle Type"]}</td>
                       <td>${
                         data["Tare Weight In (MT)"] === null
                           ? " "
                           : data["Tare Weight In (MT)"]
                       }</td>
                       <td>${
                         data["Gross  Weight In (MT)"] === null
                           ? " "
                           : data["Gross  Weight In (MT)"]
                       }</td>
                       <td>${
                         data["Net  Weight In (MT)"] === null
                           ? " "
                           : data["Net  Weight In (MT)"]
                       }</td>
                       <td>${data["Date Time"]}</td>
                       <td>${data.Unloading}</td>
                       <td>${data["Garbage Type"]}</td>
                       <td>${data["Ward Office Name."]}</td>
                     </tr>`;

      table6.querySelector("tbody").appendChild(tr);
    }
  } catch (error) {
    console.error("An error occurred while populating the table:", error);
  }
};

// Handlers

const handleRampSelect = (event) => {
  const { value } = event.target;
  const selectedValue = !value ? 0 : value;
  rampWiseWeightReportParameters.rampid = selectedValue;
};

const handleStartDateSelect = () => {
  selectedStartDate = startDate.value;
  rampWiseWeightReportParameters.date1 = startDate.value;
};

const handleEndDateSelect = () => {
  selectedEndDate = endDate.value;
  rampWiseWeightReportParameters.date2 = endDate.value;
};

// Listners

btnSearch.addEventListener("click", async (e) => {
  e.preventDefault();

  if (startDate.value > endDate.value) {
    $("#error_warning").modal("show");
    return;
  }

  $("#tableWrapper1").slideDown("slow");
  await populateTable1();
  $("#tableWrapper2").slideDown("slow");
  await populateTable2();
  $("#tableWrapper3").slideDown("slow");
  await populateTable3();
  $("#tableWrapper4").slideDown("slow");
  await populateTable4();
  $("#tableWrapper5").slideDown("slow");
  await populateTable5();
  $("#tableWrapper6").slideDown("slow");
  await populateTable6();
});

// DataTable

function setDataTable(tableId) {
  if ($.fn.DataTable.isDataTable(tableId)) {
    // DataTable is already initialized, no need to reinitialize
    $(tableId).DataTable().clear().draw();
    $(tableId).DataTable().destroy();
  }

  $(document).ready(function () {
    var table = $(tableId).DataTable({
      pageLength: 5,
      dom:
        "<'row'<'col-sm-12 col-md-6'B><'col-sm-12 col-md-6'f>>" +
        "<'row'<'col-sm-12'tr>>" +
        "<'row justify-content-between'<'col-sm-12 col-md-auto d-flex align-items-center'l><'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
      buttons: [
        {
          extend: "excelHtml5",
          text: "Excel <i class='fas fa-file-excel'></i>",
          title: document.title,
          className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
        },
        {
          extend: "pdf",
          text: "PDF <i class='fa-regular fa-file-pdf'></i>",
          title: document.title,
          className: "btn btn-sm btn-danger mb-2", // Add your Excel button class here
          customize: function (doc) {
            // Set custom page size (width x height)
            doc.pageOrientation = "portrait"; // or "portrait" for portrait orientation
            doc.pageSize = "LEGAL"; // or an array: [width, height]

            // Set custom margins (left, right, top, bottom)
            doc.pageMargins = [20, 20, 20, 20];
          },
        },
        // "pdf",
        // "csvHtml5",
      ],
      language: {
        lengthMenu: "_MENU_  records per page",
        sSearch: "<img src='../Images/search.png' alt='search'>",
        paginate: {
          first: "First",
          last: "Last",
          next: "Next &rarr;",
          previous: "&larr; Previous",
        },
      },
      lengthMenu: [
        [5, 10, 25, 50, -1],
        [5, 10, 25, 50, "All"],
      ],

      // use below code to disable sorting on first column
      order: [],
      columnDefs: [
        {
          targets: "no-sort",
          orderable: false,
        },
      ],

      // use below code to disable sorting on any column (0 based index/ use -1 for last column)
      // columnDefs: [{ orderable: false, targets: -1 }],
    });
  });
}

// Format date

function formatDate(input) {
  var datePart = input.match(/\d+/g),
    year = datePart[0],
    month = datePart[1],
    day = datePart[2];

  return day + "-" + month + "-" + year;
}

// on Window load

window.addEventListener("load", populateRampNameDropdown());
