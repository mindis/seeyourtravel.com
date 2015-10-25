﻿using System;
using System.Text;
using System.Web;
using System.Linq;
using System.Xml;

public partial class services_get_places : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string callback = Request.QueryString["callback"];
        string types = Request.QueryString["types"];
        string set = Request.QueryString["set"];
        string from = Request.QueryString["from"];
        string to = Request.QueryString["to"];
        double minx = double.Parse(Request.QueryString["minx"]);
        double miny = double.Parse(Request.QueryString["miny"]);
        double maxx = double.Parse(Request.QueryString["maxx"]);
        double maxy = double.Parse(Request.QueryString["maxy"]);
        double x = (minx + maxx) / 2;
        double y = (miny + maxy) / 2;
        StringBuilder items = new StringBuilder();

        string order = Request.QueryString["order"];

        Guid userId = Tools.GetUserId(this);

        var db = new SeeYourTravelEntities();
        var places = (from t in db.GetUserAndPublicPlacesByLocation(userId, types, miny, minx, maxy, maxx, 0, 1000) select t).ToList();

        //XmlDocument doc = new XmlDocument();
        //    doc.Load(Server.MapPath(@"..\data\photos.xml"));
        //    string query = string.Format("//r[b>={2} and b<={3} and c>={0} and c<={1}][position() >= {4} and position() <= {5}]", minx, maxx, miny, maxy, from, to);
        //    XmlNodeList list = doc.SelectNodes(query);

        //    foreach (XmlElement elem in list)
        foreach (var place in places)
        {
            // http://localhost:88/seeyourtravel/services/get_places.aspx?types=restaurant%2Clodging&set=full&from=0&to=10&miny=47.955776&minx=10.096568999999999&maxy=48.055775999999994&maxx=10.196569&callback=abc

            double lat = place.Lat;
            double lng = place.Lng;
            string icon = "data/places/forum.jpg";
            Guid id = Guid.Empty;
            string description = place.Name;
            string resultTypes = "\'restaurant\'";
            string vicinity = place.Vicinity;

            if (items.Length > 0)
                items.AppendLine(",");
            items.AppendFormat(@"
      {
         'geometry' : {
            'location' : {
               'lat' : {0}, 
               'lng' : {1}
            }
         },
         'icon' : '{2}',
         'id' : '{3}',
         'name' : '{4}',
         'opening_hours' : {
            'open_now' : true,
            'weekday_text' : []
         },
         'photos' : [
            {
               'height' : 500,
               'width' : 375,
               'html_attributions' : [
                  'TBD'
               ],
               'raw_reference' : {
                  'fife_url' : '{2}'
               }
            }
         ],
         'rating' : 1.1,
         'types' : [ {5} ]
         'vicinity' : '{6}'
      }
", (decimal)lat, (decimal)lng, icon, id, description, resultTypes, vicinity);
        }

        string result = string.Format(@"/**/{0}( {
   'results' : [
      {1}
   ],
   'status' : 'OK'
}
 )", callback, items.ToString());
        //Response.Cache.SetNoStore();
        //Response.Cache.SetNoServerCaching();
        //Response.Cache.SetMaxAge(new TimeSpan(0));
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.AppendCacheExtension("no-store, must-revalidate");
        //Response.AppendHeader("Pragma", "no-cache");
        //Response.AppendHeader("Expires", "0");

Response.ContentType = "application/javascript; charset=utf-8";
        Response.Headers.Add("X-Frame-Options", "SAMEORIGIN");
        Response.Headers.Add("Content-Disposition", "Attachment");

        Response.Write(result);
        
        Response.End();
    }
}

//        string result = @"/**/" + callback + @"( {
//   'html_attributions' : [],
//   'next_page_token' : 'CoQC9AAAAJ--wCsNhotf9qf23DPwPDuM5t0iBee4HsyLksTuqiJXod1qyTsxA-XZ_d2E6iQO-KxXwUGi-y0abQc75GxAhM7Owzs_CWPfrLhQDcsCwmeIaVJOkFshdN_ms6p0VDtRy9lsAgSd-8ufJcah9CvY8YXHgS8_ZRE0TgcIQvhZH5C0mysMMtnDqQqWaZwpLKJz0_7vR4sWuqYEm8zDxERsaeHGEokIhbuFh-9c_f9YMsdvW8v-Njmt80tKSuWAuz3XA3m8UdqZTDmkkrMEkUhwgsCtEWWG2htDYuM5Ahm_nL_GimwZ8rfGT5tZ0rcmexo6O5NOALeCmX81OFuyjU8RyVcSEBPnezRjVNBcnYCtnP2p_5caFLQYCq7Ntfyh-Me1MF-8SKiBNgm4',
//   'results' : [
//      {
//         'geometry' : {
//            'location' : {
//               'lat' : 50.459021,
//               'lng' : 30.490029
//            }
//         },
//         'icon' : 'http://maps.gstatic.com/mapfiles/place_api/icons/lodging-71.png',
//         'id' : '7b02a90d6ca08c66a393394f651b342cfa099cf7',
//         'name' : 'Business Center Forum',
//         'opening_hours' : {
//            'open_now' : true,
//            'weekday_text' : []
//         },
//         'photos' : [
//            {
//               'height' : 500,
//               'html_attributions' : [
//                  '\u003ca href=\'https://seeyourtravel.com/data/places/forum.jpg\'\u003eBusiness Center Forum, Kyiv\u003c/a\u003e'
//               ],
//               'raw_reference' : {
//                  'fife_url' : 'https://seeyourtravel.com/data/places/forum.jpg'
//               },
//               'width' : 375
//            }
//         ],
//         'place_id' : 'SYT_ChIJN4hjZZeDQUYRomvwjuHwwp8',
//         'rating' : 1.1,
//         'reference' : 'CoQBfwAAAJct3UQ1FDf7msS62iBHPWdfPQWDJp9fMZZszkYpMC5DY8ROI6tqZxtAgWsghUbGtdfOJzCKTQ3jxHkorv9WrqD1z8HumCvVjTZ3vhbK7KuIkpP2-XgTTelUVLgGVZA-4gpUhHrlofYs1TmiutBjH5-a6DzasnPeTmeYifbEbqDOEhBIKylxdg5tQkU1jvHJLE7TGhRykwoUQN-ppdetuMKoVTaslSTSsw',
//         'scope' : 'SeeYourTravel',
//         'types' : [ 'lodging', 'point_of_interest', 'establishment' ],
//         'vicinity' : 'Lukyanivka, Kyiv'
//      }
//   ],
//   'status' : 'OK'
//}
// )";
