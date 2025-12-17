using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SWM.MODEL
{
    public class MAP
    {
        public string mode { get; set; }
        public string userId { get; set; }
        public string FK_VehicleID { get; set; }

        public string counts { get; set; }
        public string datetim { get; set; }
        public string vehicleName { get; set; }
        public string speed { get; set; }
        public string latitude { get; set; }
        public string longitude { get; set; }
        public string color { get; set; }
        public string vehicletype { get; set; }
        public string distance { get; set; }
        public string TIME { get; set; }
        public string LstRunIdletime { get; set; }
        public string LstDrive { get; set; }
        public string TodaysODO { get; set; }
        public string branch { get; set; }
        public string branchshow { get; set; }
        public string Direction { get; set; }

        public string ZoneId { get; set; }
        public string ZoneName { get; set; }

        public string PK_wardId { get; set; }
        public string wardName { get; set; }

        public string PK_VehicleId { get; set; }

        //public string Id { get; set; }
        //public string AnnotationFileName { get; set; }
        //public string VideoFileName { get; set; }
        //public string StartPosition { get; set; }
        //public string EndPosition { get; set; }
        //public string CreatedDate { get; set; }
        //public string CreatedBy { get; set; }
    }
}