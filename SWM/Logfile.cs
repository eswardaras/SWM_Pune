using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web;

namespace SWM
{
    public static class Logfile
    {
        public static void TraceService(string LogFileName, string content)
        {
            string logFilePath = AppDomain.CurrentDomain.BaseDirectory + "\\" + LogFileName.Trim() + ".txt";
            //set up a filestream
            FileStream fs = new FileStream(logFilePath, FileMode.OpenOrCreate, FileAccess.Write);

            //set up a streamwriter for adding text
            StreamWriter sw = new StreamWriter(fs);

            //find the end of the underlying filestream
            sw.BaseStream.Seek(0, SeekOrigin.End);

            //add the text
            sw.WriteLine(content);
            //add the text to the underlying filestream

            sw.Flush();
            //close the writer
            sw.Close();
        }
    }
    
}