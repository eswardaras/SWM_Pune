const startDate = document.getElementById("startDate");
const endDate = document.getElementById("endDate");
const dateSpan = document.getElementById("dateSpan");
const btnSearch = document.getElementById("btnSearch");
const table1 = document.getElementById("table1");
const table2 = document.getElementById("table2");

//const commonApi =
//  "http://13.200.33.105/SWMServiceLive/SWMService.svc/CommonMethod";
//const loginId = 11401;


const getData = async () => {
  try {
    dateSpan.innerHTML = `Plant Summary Report:- From ${formatDate(
      startDate.value
    )} To ${formatDate(endDate.value)}`;

    let sData = new Date(startDate.value);
    let eData = new Date(endDate.value);

    const requestData = {
      storedProcedureName: "sp_PlantSummaryReport",
      parameters: JSON.stringify({
        mode: 21,
        Date1: startDate.value,
        Date2: endDate.value,
      }),
    };

    const response = await axios.post(commonApi, requestData);
    console.log(response);

    if (!response.data.CommonMethodResult.CommonReportMasterList) {
      alert("no data found");
      return;
    }

    // Ramp-wise data (index 0)
    const plantData =
      response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;
    // Totals (index 1)
    const totalData =
      response.data.CommonMethodResult.CommonReportMasterList[1].ReturnValue;

    let tableDataPlants = JSON.parse(plantData);
    let tableDataTotals = JSON.parse(totalData);

    console.log("Plant Data", tableDataPlants);
    console.log("Totals", tableDataTotals);

    if ((eData - sData) / (1000 * 60 * 60 * 24) >= 30) {
      function createExcelFile(data, sheetName) {
        const ws = XLSX.utils.json_to_sheet(data);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, sheetName);
        return XLSX.write(wb, { bookType: "xlsx", type: "binary" });
      }

      function s2ab(s) {
        const buf = new ArrayBuffer(s.length);
        const view = new Uint8Array(buf);
        for (let i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xff;
        return buf;
      }

      const zip = new JSZip();

      zip.file(
        "RampSummaryReport_Ramps.xlsx",
        s2ab(createExcelFile(tableDataPlants, "Ramps")),
        { binary: true }
      );
      zip.file(
        "RampSummaryReport_Totals.xlsx",
        s2ab(createExcelFile(tableDataTotals, "Totals")),
        { binary: true }
      );

      zip.generateAsync({ type: "blob" }).then(function (content) {
        Swal.close();
        saveAs(content, "RampSummaryReport.zip");
      });

      return;
    } else {
      populateTotalTable(tableDataTotals);
      populatePlantTable(tableDataPlants);
     
    }
  } catch (error) {
    alert("no data found");
    console.error("Error fetching data:", error);
  }
};

const populateTotalTable = (tableData) => {
  const tbody = $("#table1 tbody");
  tbody.empty();

  tableData.forEach((data, index) => {
    tbody.append(`
      <tr>
        <td>${index + 1}</td>
        <td>${data.Total_Incoming_Dry || 0}</td>
        <td>${data.Total_Incoming_Wet || 0}</td>
        <td>${data.Total_Incoming_Garden || 0}</td>
        <td>${data.Total_Incoming_DryWet || 0}</td>
        <td>${data.Total_Incoming_Reject || 0}</td>
        <td>${data.Total_Outgoing_Dry || 0}</td>
        <td>${data.Total_Outgoing_Wet || 0}</td>
        <td>${data.Total_Outgoing_Garden || 0}</td>
        <td>${data.Total_Outgoing_DryWet || 0}</td>
        <td>${data.Total_Outgoing_Reject || 0}</td>
      </tr>
    `);
  });

  setDataTable("#table1");
};

const populatePlantTable = (tableData) => {
  const tbody = $("#table2 tbody");
  tbody.empty();

  tableData.forEach((data, index) => {
    tbody.append(`
      <tr>
        <td>${index + 1}</td>
        <td>${data.PlantName || ""}</td>
         <td>${data.Capacity || 0}</td>
        <td>${data.Incoming_Dry || 0}</td>
        <td>${data.Incoming_Wet || 0}</td>
        <td>${data.Incoming_Garden || 0}</td>
        <td>${data.Incoming_DryWet || 0}</td>
        <td>${data.Incoming_Reject || 0}</td>
        <td>${data.Outgoing_Dry || 0}</td>
        <td>${data.Outgoing_Wet || 0}</td>
        <td>${data.Outgoing_Garden || 0}</td>
        <td>${data.Outgoing_DryWet || 0}</td>
        <td>${data.Outgoing_Reject || 0}</td>
      </tr>
    `);
  });

  setDataTable("#table2");
};



btnSearch.addEventListener("click", async (e) => {
  e.preventDefault();

  let sData = new Date(startDate.value);
  let eData = new Date(endDate.value);

  if ((eData - sData) / (1000 * 60 * 60 * 24) < 30) {
    $("#tableWrapper").slideDown("slow");
    $("#table1 tbody").html(`<tr>
      <td colspan='50' class='text-danger'>Loading...</td>
    </tr>`);
    $("#table2 tbody").html(`<tr>
      <td colspan='50' class='text-danger'>Loading...</td>
    </tr>`);

    await getData();
  } else {
    Swal.fire({
      title: "Please wait",
      html: "Preparing to download the excel file",
      allowOutsideClick: false,
      didOpen: () => {
        Swal.showLoading();
      },
    });

    await getData();
  }
});
function setDataTable(tableId) {
  if ($.fn.DataTable.isDataTable(tableId)) {
    $(tableId).DataTable().clear().destroy();
  }

  $(tableId).DataTable({
    pageLength: 5,
    dom: "<'row'<'col-sm-6'B><'col-sm-6'f>>" +
      "<'row'<'col-sm-12'tr>>" +
      "<'row justify-content-between'<'col-sm-12 col-md-auto'l><'col-sm-12 col-md-auto'i><'col-sm-12 col-md-auto'p>>",
    buttons: [
      {
        text: 'Excel <i class="fas fa-file-excel"></i>',
        className: 'btn btn-success btn-sm mb-2',
        action: function () {
          exportExcel(tableId, "Plant Summary Report");
        }
      },
      {
        text: 'PDF <i class="fas fa-file-pdf"></i>',
        className: 'btn btn-danger btn-sm mb-2',
        action: function () {
          exportPDF(tableId, "Plant Summary Report");
        }
      }
    ],
    language: {
      lengthMenu: "_MENU_ records per page",
      search: "<img src='Images/search.png'>",
      paginate: { first: "First", last: "Last", next: "Next →", previous: "← Previous" }
    },
    lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
    order: [],
    columnDefs: [{ targets: 'no-sort', orderable: false }]
  });
}

function exportPDF(tableId, title = "Plant Summary Report") {
  const { jsPDF } = window.jspdf;
  const doc = new jsPDF("landscape", "pt", "a4");

  // Title
  doc.setFontSize(14);
  doc.setFont("helvetica", "bold");
  doc.text(title, 40, 30);

  // Date span (shown below title)
  const dateSpan = document.getElementById("dateSpan");
  let reportDate = dateSpan ? dateSpan.innerText : new Date().toLocaleDateString();

  doc.setFontSize(10);
  doc.setFont("helvetica", "normal");
  doc.text("Date: " + reportDate, 40, 45);

  // Simple AutoTable
  doc.autoTable({
    html: tableId,
    startY: 60,
    theme: "grid",
    styles: {
      fontSize: 8,
      cellPadding: 4,
      lineColor: [0, 0, 0],
      lineWidth: 0.25,
      textColor: [0, 0, 0]
    },
    headStyles: {
      fontStyle: 'bold',
      halign: 'center',
      valign: 'middle'
    },
    bodyStyles: {
      halign: 'center',
      valign: 'middle'
    },
    margin: { top: 50, left: 40, right: 40 },
    didDrawPage: function (data) {
      // Footer
      doc.setFontSize(8);
      doc.text("Generated on: " + new Date().toLocaleString(),
        data.settings.margin.left,
        doc.internal.pageSize.height - 10);
    }
  });

  doc.save(title + ".pdf");
}

function exportExcel(tableId, title = "Plant Summary Report") {
  // Get table element
  let table = document.querySelector(tableId);

  // Create workbook from table
  let wb = XLSX.utils.table_to_book(table, { sheet: title });
  let ws = wb.Sheets[wb.SheetNames[0]];

  // Get date range from span
  const dateSpan = document.getElementById("dateSpan");
  let reportDate = dateSpan ? dateSpan.innerText : new Date().toLocaleDateString();

  // Insert date range as first row
  XLSX.utils.sheet_add_aoa(ws, [["Date: " + reportDate]], { origin: "A1" });

  // Shift table down (so date range stays above)
  // XLSX automatically pushes existing content down

  // Export file
  XLSX.writeFile(wb, title + ".xlsx");
}

function formatDate(input) {
  var datePart = input.match(/\d+/g),
    year = datePart[0],
    month = datePart[1],
    day = datePart[2];

  return day + "-" + month + "-" + year;
}
