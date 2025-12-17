<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RampSummaryReport.aspx.cs" Inherits="SWM.RampSummaryReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	  <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link rel="stylesheet" href="css/fstdropdown.css" />
      <script src="js/fstdropdown.js"></script>
      <script
          src="https://kit.fontawesome.com/e8c1c6e963.js"
          crossorigin="anonymous"></script>
      <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous" />
      <script
          src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
          crossorigin="anonymous"></script>
      <script src="js/jquery-3.3.1.min.js"></script>
      <!-- DataTable Links -->
      <link
          rel="stylesheet"
          href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
      <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.6.0/jszip.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>

      <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

      <!-- DataTable Links End -->
      <link rel="stylesheet" href="css/sweeperAttendance.css" />
      <!-- Sweet Aleart -->
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
      <!-- Sweet Aleart End -->
      <title>Ramp Summary Report</title>
      <style>
          #table2 thead tr {
    background-color: lightcyan !important;
  }
  #table2 th, 
  #table2 td {
    text-align: center;
    vertical-align: middle; /* keeps multi-row headers vertically centered */
  }

          #table1 thead tr {
  background-color: lightcyan !important;
}
#table1 th, 
#table1 td {
  text-align: center;
  vertical-align: middle; /* keeps multi-row headers vertically centered */
}
</style>
  </head>
  <body>
    <div class="filters-section">
        <div class="filters-container">
            <div class="title d-flex justify-content-between">
                <div class="d-flex align-items-center">
                    <i class="fa-solid fa-book"></i>
                    <h3>Ramp Summary Report</h3>
                </div>
            </div>
            <div class="body">
                <form action="">
                    <div class="row px-3 pb-3">
                       
                        <div class="col-sm-2 date-wrapper">
                            <label for="">From Date</label>
                            <input type="date" class="form-control" id="startDate" />
                        </div>
                        <div class="col-sm-2 date-wrapper">
                            <label for="">To Date</label>
                            <input type="date" class="form-control" id="endDate" />
                        </div>
                       
                        <div class="col-sm-2 mt-1">
                            <div class="d-flex align-items-end h-100">
                                <button class="btn btn-success" type="button" id="btnSearch">
                                    Search
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
      <section
      class="sweeper-coverage-report-section"
      style="display: none"
      id="tableWrapper">
      <div class="sweeper-coverage-report mb-5">
          <div class="title dropdown-btn">
              <div class="controls">
                  <div>
                      <h2>Pune Municipal Corporation</h2>
                  </div>
              </div>
              <div class="text-danger d-flex align-items-center"></div>
              <div
                  class="downloads d-flex align-items-center"
                  id="div1"
                  runat="server"
                  visible="true">
                  <button type="button" class="btn btn-light toggler__btn p-1">
                      <i class="fa-solid fa-chevron-down"></i>
                  </button>
              </div>
          </div>

          <div class="body collapsible active toggler__content">
            <table id="table1" class="table table-striped text-center">
  <thead>
    <tr>
      <th colspan="11">Total Counts</th>
    </tr>
    <tr>
      <th rowspan="2">Sr. No</th>
      <th colspan="5">Incoming</th>
      <th colspan="5">Outgoing</th>
    </tr>
    <tr>
      <th>Dry</th><th>Wet</th><th>Garden</th><th>Dry/Wet</th><th>Reject</th>
      <th>Dry</th><th>Wet</th><th>Garden</th><th>Dry/Wet</th><th>Reject</th>
    </tr>
  </thead>
  <tbody></tbody>
</table>
          <%--  <table class="table table-striped text-center" id="table1">
  <thead>
    <!-- Title Row -->
    <tr>
      <th colspan="11" class="text-center">Total Counts</th>
    </tr>

    <!-- Group Headers -->
    <tr>
      <th rowspan="2">Sr. No</th>
      <th colspan="5" class="text-center">Incoming</th>
      <th colspan="5" class="text-center">Outgoing</th>
    </tr>

    <!-- Sub Headers -->
    <tr style="background-color: lightcyan";>
      <th>Dry</th>
      <th>Wet</th>
      <th>Garden</th>
      <th>Dry/Wet</th>
      <th>Reject</th>
      <th>Dry</th>
      <th>Wet</th>
      <th>Garden</th>
      <th>Dry/Wet</th>
      <th>Reject</th>
    </tr>
  </thead>
  <tbody></tbody>
</table>--%>

          </div>
      </div>

      <div class="sweeper-coverage-report">
          <div class="title dropdown-btn">
              <div class="controls">
                  <div>
                      <h2>Pune Municipal Corporation</h2>
                      <h3 id="dateSpan" class="alert alert-danger p-1"></h3>
                  </div>
              </div>
              <div class="text-danger d-flex align-items-center"></div>
              <div
                  class="downloads d-flex align-items-center"
                  id="div2"
                  runat="server"
                  visible="true">
                  <button type="button" class="btn btn-light toggler__btn p-1">
                      <i class="fa-solid fa-chevron-down"></i>
                  </button>
              </div>
          </div>

          <div class="body collapsible active toggler__content">
              <table id="table2" class="table table-bordered text-center">
  <thead>
    <tr>
      <th rowspan="2">Sr. No</th>
      <th rowspan="2">Ramp Name</th>
      <th rowspan="2">Capacity</th>
      <th colspan="5">Incoming</th>
      <th colspan="5">Outgoing</th>
    </tr>
    <tr>
      <th>Dry</th><th>Wet</th><th>Garden</th><th>Dry/Wet</th><th>Reject</th>
      <th>Dry</th><th>Wet</th><th>Garden</th><th>Dry/Wet</th><th>Reject</th>
    </tr>
  </thead>
  <tbody></tbody>
</table>
           <%--<table class="table table-bordered text-center" id="table2">
  <thead>
    <!-- Row 1: Main groups -->
    <tr style="background-color: lightcyan;">
      <th rowspan="2">Sr. No</th>
      <th rowspan="2">Ramp Name</th>
      <th colspan="5">Incoming</th>
      <th colspan="5">Outgoing</th>
    </tr>
    <!-- Row 2: Sub-columns -->
    <tr style="background-color: lightcyan;">
      <th>Dry</th>
      <th>Wet</th>
      <th>Garden</th>
      <th>Dry/Wet</th>
      <th>Reject</th>
      <th>Dry</th>
      <th>Wet</th>
      <th>Garden</th>
      <th>Dry/Wet</th>
      <th>Reject</th>
    </tr>
  </thead>
  <tbody></tbody>
</table>--%>

          </div>
      </div>
  </section>

  <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
      integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
      crossorigin="anonymous"></script>
  <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
      integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
      crossorigin="anonymous"></script>
  <script></script>
  <script src="js/axios.js"></script>
  <script>
      const dateInput = document.querySelectorAll("input[type='date']");
      const currentDate = new Date().toISOString().substr(0, 10);

      dateInput.forEach((input) => {
          if (!input.value) {
              input.value = currentDate;
          }
      });
  </script>
  <script>
      $(document).ready(function () {
          function collapseContent(button) {
              $(button).parent().parent().next().slideToggle("fast");
          }

          $(".toggler__btn").click(function () {
              collapseContent(this);
          });
      });
	</script>
  <script src="https://cdn.jsdelivr.net/npm/xlsx@0.16.9/dist/xlsx.full.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.6.0/jszip.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
  <script src="js/RampSummaryReport.js"></script>
</body>


</asp:Content>
