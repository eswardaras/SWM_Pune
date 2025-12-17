<%@ Page Title="" Language="C#" AutoEventWireup="true" %>



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

    <script

        src="https://code.jquery.com/jquery-3.3.1.min.js"

        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="

        crossorigin="anonymous"></script>

    <script type="text/javascript">

        var commonApi = '<%= ConfigurationManager.AppSettings["CommonApiUrl"]%>';

        var zoneApi = '<%= ConfigurationManager.AppSettings["ZoneApiUrl"]%>';

        var wardApi = '<%= ConfigurationManager.AppSettings["WardApiUrl"]%>';

    </script>

    <style>

        .light-red {

            background-color: #bc5448;

            color: #fff !important;

        }



        .red {

            background-color: #d21404;

            color: #fff !important;

        }



        .light-green {

            background-color: #3ded97;

        }



        .green {

            background-color: #03ac13;

        }



        .legend-icons {

            font-size: 20px;

            border-radius: 2px;

        }



            .legend-icons.red {

                color: #d21404 !important;

            }



            .legend-icons.light-red {

                color: #bc5448 !important;

            }



            .legend-icons.white {

                color: #fff !important;

                border: 1px solid black;

            }



            .legend-icons.light-green {

                color: #3ded97 !important;

            }



            .legend-icons.green {

                color: #03ac13 !important;

            }

    </style>

    <title>Kothi Monitoring</title>

</head>

<body>

    <div class="container mt-3 border">

        <div class="row border-bottom">

            <div class="d-flex align-items-center">

                <i class="fa-solid fa-desktop me-2"></i>

                <h6 class="my-2">Kothi Monitoring</h6>

            </div>

        </div>

        <div class="row">

            <div class="col-md-3 mt-2">

                <label>Zone</label>

                <select

                    id="zoneDropdown"

                    class="form-select fstdropdown-select"

                    onchange="handleZoneSelect(event)">

                    <option value="0">Select Zone</option>

                </select>

            </div>

            <div class="col-md-3 mt-2">

                <label>Ward</label>

                <select

                    id="wardDropdown"

                    class="form-select fstdropdown-select"

                    onchange="handleWardSelect(event)">

                    <option value="0">Select Ward</option>

                </select>

            </div>

        </div>

        <div class="row my-3">

            <div class="col-auto">

                <i class="fa-solid fa-square legend-icons red"></i>

                <label data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Absenteeism has increased more than or equal to 5%">Worse<span class="badge bg-secondary mx-1">(>= 5%)</span></label>

            </div>

            <div class="col-auto">

                <i class="fa-solid fa-square legend-icons light-red"></i>

                <label data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Absenteeism has increased but less than 5%">Bad<span class="badge bg-secondary mx-1">(> 0 but < 5%)</span></label>

            </div>

            <div class="col-auto">

                <i class="fa-solid fa-square legend-icons white"></i>

                <label data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Absenteeism is same">Ok<span class="badge bg-secondary mx-1">(0)</span></label>

            </div>

            <div class="col-auto">

                <i class="fa-solid fa-square legend-icons light-green"></i>

                <label data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Absenteeism has decreased but less than 5%">Good<span class="badge bg-secondary mx-1">(> 0 < -5%)</span></label>

            </div>

            <div class="col-auto">

                <i class="fa-solid fa-square legend-icons green"></i>

                <label data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Absenteeism has decreased more than or equal to 5%">Better<span class="badge bg-secondary mx-1">(>= -5%)</span></label>

            </div>

        </div>

    </div>



    <div class="container my-3">

        <div id="aleartMessage"></div>

    </div>



    <div class="container">

        <div class="row mb-3" id="boxContainer"></div>

    </div>



    <script

        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"

        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"

        crossorigin="anonymous"></script>

    <script

        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"

        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"

        crossorigin="anonymous"></script>

    <script>

        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')

        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

    </script>

    <script src="js/axios.js"></script>

    <script defer src="js/kothiMonitoring.js"></script>

</body>

