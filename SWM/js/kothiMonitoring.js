const zoneDropdown = document.getElementById("zoneDropdown");

const wardDropdown = document.getElementById("wardDropdown");



const boxContainer = document.getElementById("boxContainer");

const aleartMessage = document.getElementById("aleartMessage");



const zoneRequestData = {

    mode: 11,

    vehicleId: 0,

    AccId: 11401,

};



const wardRequestData = {

    mode: 12,

    vehicleId: 0,

    AccId: 11401,

    ZoneId: 0,

};



const kothiRequestData = {

    mode: 56,

    Fk_accid: 11401,

    Fk_ambcatId: 0,

    Fk_divisionid: 0,

    FK_VehicleID: 0,

    Fk_ZoneId: 0,

    FK_WardId: 0,

    Startdate: "",

    Enddate: "",

    Maxspeed: 0,

    Minspeed: 0,

    Fk_DistrictId: 0,

    Geoid: 0,

};



const attDataParameters = {

    mode: 1,

    zone_id: "",

    ward_id: "",

};



const populateZoneDropdown = async (zoneApi, zoneRequestData) => {

    try {

        const response = await axios.post(zoneApi, zoneRequestData, {

            headers: {

                "Content-Type": "application/json",

            },

        });



        const zoneMasterList = response.data.GetZoneResult.ZoneMasterList;



        for (const zone of zoneMasterList) {

            const option = document.createElement("option");

            option.value = zone.zoneid;

            option.text = zone.zonename;

            zoneDropdown.appendChild(option);

            zoneDropdown.fstdropdown.rebind();

        }

    } catch (error) {

        console.error("Error fetching data:", error);

    }

};



const populateWardDropdown = async () => {

    try {

        wardDropdown.innerHTML = '<option value="0">Select Ward</option>';



        const response = await axios.post(wardApi, wardRequestData, {

            headers: {

                "Content-Type": "application/json",

            },

        });



        const wardMasterList = response.data.GetWardResult.WardMasterList;



        for (const ward of wardMasterList) {

            const option = document.createElement("option");

            option.value = ward.PK_wardId;

            option.text = ward.wardName;

            wardDropdown.appendChild(option);

            wardDropdown.fstdropdown.rebind();

        }

    } catch (error) {

        console.error("Error fetching data:", error);

    }

};



const getAttData = async () => {

    try {

        const attRequestData = {

            storedProcedureName: "Proc_Sweeper_Att_Overview",

            parameters: JSON.stringify(attDataParameters),

        };



        const { data } = await axios.post(commonApi, attRequestData);

        console.log(data);



        if (!data.CommonMethodResult.CommonReportMasterList) {

            alert("No data found");

            return;

        }



        let tableData = JSON.parse(

            data.CommonMethodResult.CommonReportMasterList[0].ReturnValue

        );



        insertCard(tableData);

        showTotal(tableData);

        console.log(tableData);

    } catch (error) {

        console.error("Error fetching data:", error);

    }

};



const insertCard = (data) => {

    boxContainer.innerHTML = "";



    if (!data) {

        boxContainer.innerHTML = "";

        return;

    }



    for (const kothi of data) {

        const col = document.createElement("div");

        col.className = `col-md-3 my-2`;



        let classes = fillColor(kothi.PER_DIFF);



        //const diffPercentage = kothi.PER_DIFF >= 0 ? `${-kothi.PER_DIFF}%` : `${Math.abs(kothi.PER_DIFF)}%`;



        col.innerHTML = `

                            <div class="${classes}">

                                <div class="card-body">

                                    <h6 className="card-title text-truncate" title='${kothi.KOTHI}'>${kothi.KOTHI}<span class="badge text-bg-warning mx-2">${kothi.PER_DIFF}%</span></h6>

                                    <ul class="list-group list-group-item-light">

                                        <li class="list-group-item d-flex justify-content-between align-items-center">

                                          Total

                                          <span class="badge bg-primary rounded-pill">${kothi.TOTAL}</span>

                                        </li>

                                        <li class="list-group-item d-flex justify-content-between align-items-center">

                                          Day before yesterday

                                          <span class="badge bg-primary rounded-pill">${kothi.DayBefore_Attendance}</span>

                                        </li>

                                        <li class="list-group-item d-flex justify-content-between align-items-center">

                                          Yesterday

                                          <span class="badge bg-primary rounded-pill">${kothi.Yesterday_Attendance}</span>

                                        </li>

                                        <li class="list-group-item d-flex justify-content-between align-items-center">

                                          Today

                                          <span class="badge bg-primary rounded-pill">${kothi.Today_Attendance}</span>

                                        </li>

                                     </ul>

                                </div>

                            </div>

                         `;

        boxContainer.appendChild(col);

    }

};



const showTotal = (data) => {

    if (!data) {

        aleartMessage.innerHTML = `

          <div class="alert alert-danger" role="alert">

              Total Number of Kothi is 0

          </div>

       `;

        return;

    }

    aleartMessage.innerHTML = `

                                  <div class="alert alert-primary" role="alert">

                                      Total Number of Kothi is ${data.length}

                                  </div>

                               `;

};



const handleZoneSelect = (event) => {

    const { value } = event.target;

    wardRequestData.ZoneId = !value ? 0 : value;

    kothiRequestData.Fk_ZoneId = !value ? 0 : value;

    attDataParameters.zone_id = !value ? 0 : value;



    populateWardDropdown();

};



const handleWardSelect = async (event) => {

    const { value } = event.target;

    kothiRequestData.FK_WardId = !value ? 0 : value;

    attDataParameters.ward_id = !value ? 0 : value;

    await getAttData();

};



const fillColor = (data) => {

    if (data <= -5) {

        return "card shadow h-100 my-2 green";

    } else if (data < 0) {

        return "card shadow h-100 my-2 light-green";

    } else if (data === 0) {

        return "card shadow h-100 my-2";

    } else if (data > 0 && data < 5) {

        return "card shadow h-100 my-2 light-red";

    } else {

        return "card shadow h-100 my-2 red";

    }

};



// Ensure we only call populateZoneDropdown after window load and when APIs are defined

window.addEventListener("load", () => {

    if (typeof zoneApi !== "undefined") {

        populateZoneDropdown(zoneApi, zoneRequestData);

    } else {

        console.error("zoneApi is not defined. Ensure it is set in kothiMonitoring.aspx.");

    }

});

