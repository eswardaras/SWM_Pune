const campaignDropdown = document.getElementById("campaignDropdown");
const table = document.getElementById("table");

const populateCampaignDropdown = async () => {
    try {
        campaignDropdown.innerHTML = '<option value="0">Select Campaign</option>';

        const requestData = {
            storedProcedureName: "proc_CreateCampaign",
            parameters: JSON.stringify({
                mode: 27,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let dropdownData = JSON.parse(commonReportMasterList);

        for (const data of dropdownData) {
            const option = document.createElement("option");
            option.value = data.pk_campid;
            option.text = data.campname;
            campaignDropdown.appendChild(option);
        }
        campaignDropdown.fstdropdown.rebind();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

const getData = async () => {
    try {
        const requestData = {
            storedProcedureName: "proc_CreateCampaign",
            parameters: JSON.stringify({
                mode: 26,
                CampName: campaignDropdown.selectedOptions[0].textContent,
                Pk_CampID: campaignDropdown.value,
            }),
        };

        const response = await axios.post(commonApi, requestData);

        const commonReportMasterList =
            response.data.CommonMethodResult.CommonReportMasterList[0].ReturnValue;

        let tableData = JSON.parse(commonReportMasterList);
        console.log(tableData);

        let srNo = 0;

        setDataTable(table);

        for (const data of tableData) {
            srNo++;
            const tr = document.createElement("tr");
            tr.innerHTML = `<tr>
              <td>${srNo}</td>
              <td>${!data.CampName ? "-" : data.CampName}</td>
              <td>${!data.date ? "-" : data.date}</td>
              <td>${!data.Status ? "-" : data.Status}</td>
              <td>${!data.Type ? "-" : data.Type}</td>
              <td>${!data.CampObjective ? "-" : data.CampObjective}</td>
              <td>${!data.activities ? "-" : data.activities}</td>
              <td>${!data.camprule ? "-" : data.camprule}</td>
              <td>${!data.RewardsParameter ? "-" : data.RewardsParameter}</td>
              <td>${!data.Location ? "-" : data.Location}</td>
              <td>${!data.RegisterCitizens ? "-" : data.RegisterCitizens}</td>
              <td>${!data.winner ? "-" : data.winner}</td>
          </tr>`;

            table.querySelector("tbody").appendChild(tr);
        }
        $("#tableWrapper").slideDown("slow");
    } catch (error) {
        console.error("Error fetching data:", error);
    }
};

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
                    text: "Excel <i class='fas fa-file-excel text-white'></i>",
                    title: document.title + " - " + getFormattedDate(),
                    className: "btn btn-sm btn-success mb-2", // Add your Excel button class here
                },
                {
                    extend: "pdf",
                    text: "PDF <i class='fa-regular fa-file-pdf text-white'></i>",
                    title: 'Campaign report' + " - " + getFormattedDate(),
                    className: "btn btn-sm btn-danger mb-2", // Add your Excel button class here
                    customize: function (doc) {
                        // Set custom page size (width x height)
                        doc.pageOrientation = "landscape"; // or "portrait" for portrait orientation
                        doc.pageSize = "A4"; // or an array: [width, height]

                        // Set custom margins (left, right, top, bottom)
                        doc.pageMargins = [20, 20, 20, 20];
                    },
                },
                // "pdf",
                // "csvHtml5",
            ],
            language: {
                lengthMenu: "_MENU_  records per page",
                sSearch: "<img src='Images/search.png' alt='search'>",
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
            order: [[0, 'asc']],
        });
    });
}

function getFormattedDate() {
    const today = new Date();
    const options = { year: "numeric", month: "short", day: "numeric" };
    return today.toLocaleDateString("en-US", options);
}

window.addEventListener("load", populateCampaignDropdown());
