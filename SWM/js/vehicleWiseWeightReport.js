const rampNameDropdown = document.getElementById("rampNameDropdown");
const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");
const dateSpan = document.getElementById("dateSpan");

const btnSearch = document.getElementById("btnSearch");
const content_table = document.getElementById("content_table");

let selectedStartDate = startDate.value;
let selectedEndDate = endDate.value;

const rampParameters = {
  // storedProcedureName: "proc_RampDashboard",
  mode: 1,
};

const vehicleWiseWeightReportParameters = {
  // storedProcedureName: "proc_DayWiseWeight",
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

const populateTable = async () => {
  try {
    dateSpan.innerHTML = `Vehicle Wise Weight Report:- From ${formatDate(
      vehicleWiseWeightReportParameters.date1
    )} To ${formatDate(vehicleWiseWeightReportParameters.date2)}`;

    const tbody = content_table.querySelector("tbody");
    tbody.innerHTML = `<tr>
                          <td colspan="10" class='text-danger'>Loading...</td>
                       </tr>`;

    const vehicleWiseWeightReportRequestData = {
      storedProcedureName: "proc_VehicleDayWiseWeightMIS",
      parameters: JSON.stringify(vehicleWiseWeightReportParameters),
    };

    const response = await axios.post(
      commonApi,
      vehicleWiseWeightReportRequestData
    );
    console.log(response);
    console.log(vehicleWiseWeightReportRequestData);

    // emptyTable(content_table);
    tbody.innerHTML = "";
    if (!response.data.CommonMethodResult.CommonReportMasterList) {
      // const tableBody = content_table.querySelector("tbody");
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

    setDataTable(content_table);

    const table_headers = tableData[0];
    const allHeaders = table_headers ? Object.keys(table_headers) : [];

    // const allHeaders = tableData.reduce((headers, entry) => {
    //   return [...headers, ...Object.keys(entry)];
    // }, []);

    const thead_tr = document.createElement("tr");

    content_table.querySelector("thead").innerHTML = "";
    for (const headerText of allHeaders) {
      const th = document.createElement("th");
      th.textContent = headerText;
      thead_tr.appendChild(th);
    }

    content_table.querySelector("thead").appendChild(thead_tr);

    // for (const data of tableData) {
    //   const tbody_tr = document.createElement("tr");
    //   tbody_tr.innerHTML = `<tr>
    //         <td>${data["Depot No"]}</td>
    //         <td>${data["Total Weight"]}</td>
    //         <td>${data["Avg Weight"]}</td>
    //     </tr>`;

    //   content_table.querySelector("tbody").appendChild(tbody_tr);
    // }

    for (const data of tableData) {
      const tbody_tr = document.createElement("tr");
      const td_data = Object.values(data);
      for (const data of td_data) {
        const td = document.createElement("td");
        td.innerHTML = data;
        tbody_tr.appendChild(td);
      }

      content_table.querySelector("tbody").appendChild(tbody_tr);
    }

    // $("#content_table").DataTable();
    // setDataTable(content_table);
  } catch (error) {
    console.error("An error occurred while populating the table:", error);
  }
};

// Handlers

const handleRampSelect = (event) => {
  const { value } = event.target;
  const selectedValue = !value ? 0 : value;
  vehicleWiseWeightReportParameters.rampid = selectedValue;
  console.log(vehicleWiseWeightReportParameters);
};

const handleStartDateSelect = () => {
  selectedStartDate = startDate.value;
  vehicleWiseWeightReportParameters.date1 = startDate.value;
};

const handleEndDateSelect = () => {
  selectedEndDate = endDate.value;
  vehicleWiseWeightReportParameters.date2 = endDate.value;
};

// Listners

btnSearch.addEventListener("click", async (e) => {
  e.preventDefault();

  if (startDate.value > endDate.value) {
    $("#error_warning").modal("show");
    return;
  }

  await populateTable();
  $("#tableWrapper").slideDown("slow");
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
    day = datePart[0],
    month = datePart[1],
    year = datePart[2];

  return day + "-" + month + "-" + year;
}

// on Window load

window.addEventListener("load", populateRampNameDropdown());
