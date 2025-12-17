using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWM
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnHighlight_Click(object sender, EventArgs e)
        {
            // Get the user input for the area to highlight or color
            string userInput = txtInput.Text;

            // Use Leaflet to update the map with the highlighted area
            string script = @"var map = L.map('mapid').setView([51.505, -0.09], 13);var polygon = L.polygon([ [51.509, -0.08], [51.503, -0.06], [51.51, -0.047] ]).addTo(map); polygon.setStyle({fillColor: '" + userInput + "', fillOpacity: 0.7, color: 'black', weight: 2});";
            ScriptManager.RegisterStartupScript(Page, GetType(), "HighlightMapArea", script, true);
        }

    }
}